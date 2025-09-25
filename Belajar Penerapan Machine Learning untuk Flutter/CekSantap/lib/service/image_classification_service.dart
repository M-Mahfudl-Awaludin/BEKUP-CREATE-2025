import 'dart:developer';
import 'dart:isolate';
import 'package:camera/camera.dart';
import 'package:ceksantap/service/firebase_tflite_service.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
import 'isolate_inference.dart';

class ImageClassificationService {
  late final FirebaseTFLiteService _firebaseService;
  late final IsolateInference isolateInference;

  late final Interpreter interpreter;
  late final List<String> labels;

  late final List<int> inputShape;
  late final List<int> outputShape;

  Future<void> initHelper() async {
    _firebaseService = FirebaseTFLiteService();
    await _firebaseService.loadModel(
      modelName: "Food-Detector",
      labelsPath: "assets/labels.txt",
      isQuantized: true,
    );

    interpreter = _firebaseService.interpreter;
    labels = _firebaseService.labels;

    inputShape = interpreter.getInputTensors().first.shape;
    outputShape = interpreter.getOutputTensors().first.shape;

    isolateInference = IsolateInference();
    await isolateInference.start();

    log("✅ ImageClassificationService ready (Firebase ML Custom)");
  }

  Future<Map<String, double>> inferenceCameraFrame(CameraImage cameraImage) async {
    final isolateModel = InferenceModel(
      cameraImage,
      interpreter.address,
      labels,
      inputShape,
      outputShape,
    );

    final responsePort = ReceivePort();
    isolateInference.sendPort.send(
      isolateModel..responsePort = responsePort.sendPort,
    );

    final results = await responsePort.first as Map<String, double>;
    return results;
  }

  Future<void> close() async {
    await isolateInference.close();
  }
}
