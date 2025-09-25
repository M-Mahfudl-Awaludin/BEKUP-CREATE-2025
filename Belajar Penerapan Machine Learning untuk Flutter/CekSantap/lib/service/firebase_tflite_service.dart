import 'dart:io';
import 'package:firebase_ml_model_downloader/firebase_ml_model_downloader.dart';
import 'package:flutter/services.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

class FirebaseTFLiteService {
  Interpreter? _interpreter;
  List<String> _labels = [];
  bool _isQuantized = true;

  Future<void> loadModel({
    String modelName = "Food-Detector",
    String labelsPath = "assets/labels.txt",
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

    final rawLabels = await rootBundle.loadString(labelsPath);
    _labels = rawLabels.split('\n').where((e) =>
    e
        .trim()
        .isNotEmpty).toList();
  }

  Interpreter get interpreter {
    if (_interpreter == null) throw Exception("Interpreter belum di-load");
    return _interpreter!;
  }

  List<String> get labels => _labels;
  bool get isQuantized => _isQuantized;
}
