import 'dart:io';
import 'dart:isolate';
import 'package:ceksantap/utils/image_utils.dart';
import 'package:firebase_ml_model_downloader/firebase_ml_model_downloader.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'package:image/image.dart' as image_lib;
import 'package:flutter/services.dart' show rootBundle;

class TFLiteService {
  late Interpreter _interpreter;
  late List<String> _labels;
  bool _isQuantized = true; // default untuk model AIY Food quantized

  /// Load model TFLite & labels dari assets
  Future<void> loadModel({
    String modelName = "Food-Detector",
    String labelsPath = 'assets/labels.txt',
    bool isQuantized = true,
  }) async {
    _isQuantized = isQuantized;

    final model = await FirebaseModelDownloader.instance.getModel(
      modelName,
      FirebaseModelDownloadType.latestModel,
      FirebaseModelDownloadConditions(
        iosAllowsCellularAccess: true,
        iosAllowsBackgroundDownloading: true,
      ),
    );

    final modelFile = model.file;
    if (modelFile == null) {
      throw Exception("Model tidak ditemukan di Firebase");
    }

    _interpreter = Interpreter.fromFile(modelFile);

    // Load labels
    final rawLabels = await rootBundle.loadString(labelsPath);
    _labels = rawLabels.split('\n').where((e) => e.trim().isNotEmpty).toList();
  }

  /// Klasifikasi gambar (menggunakan Isolate)
  Future<Map<String, dynamic>> classifyImage(String imagePath) async {
    final responsePort = ReceivePort();
    await Isolate.spawn(
      _inferenceIsolate,
      [imagePath, _interpreter.address, responsePort.sendPort, _labels, _isQuantized],
    );
    return await responsePort.first;
  }

  /// Fungsi yang dijalankan di Isolate
  static void _inferenceIsolate(List<dynamic> args) {
    final String imagePath = args[0];
    final int interpreterAddress = args[1];
    final SendPort sendPort = args[2];
    final List<String> labels = args[3];
    final bool isQuantized = args[4];

    final interpreter = Interpreter.fromAddress(interpreterAddress);

    // Decode dan resize gambar
    final image = ImageUtils.decodeImageFileSync(imagePath);

    // Preprocess input sesuai tipe model
    final input = List.generate(
      1,
          (_) => List.generate(224, (i) => List.generate(224, (j) {
        final pixel = image.getPixel(j, i);
        if (isQuantized) {
          // untuk quantized model (uint8)
          return [pixel.r, pixel.g, pixel.b];
        } else {
          // untuk float32 model
          return [pixel.r / 255.0, pixel.g / 255.0, pixel.b / 255.0];
        }
      })),
    );

    // Output tensor
    dynamic output;
    if (isQuantized) {
      // output int untuk quantized
      output = List.generate(1, (_) => List.filled(labels.length, 0));
    } else {
      // output double untuk float32
      output = List.generate(1, (_) => List.filled(labels.length, 0.0));
    }

    // Jalankan inferensi
    interpreter.run(input, output);

    // Konversi output ke double untuk probabilitas
    List<double> probs;
    if (isQuantized) {
      probs = (output[0] as List<int>).map((e) => e.toDouble()).toList();
    } else {
      probs = List<double>.from(output[0]);
    }

    // Cari label dengan probabilitas tertinggi
    final maxIndex = probs.indexWhere((e) => e == probs.reduce((a, b) => a > b ? a : b));

    sendPort.send({
      'result': labels[maxIndex],
      'confidence': probs[maxIndex],
    });
  }
}

// Synchronous helper untuk decode image
extension ImageUtilsSync on ImageUtils {
  static image_lib.Image decodeImageFileSync(String imagePath) {
    final file = File(imagePath);
    final bytes = file.readAsBytesSync();
    final image = image_lib.decodeImage(bytes);
    if (image == null) throw Exception("Cannot decode image file");
    final resized = image_lib.copyResize(image, width: 224, height: 224);
    return resized;
  }
}
