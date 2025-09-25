import 'package:camera/camera.dart';
import 'package:ceksantap/service/image_classification_service.dart';
import 'package:flutter/widgets.dart';


class ImageClassificationProvider extends ChangeNotifier {
  final ImageClassificationService _service;

  ImageClassificationProvider(this._service) {
    _service.initHelper();
  }

  Map<String, num> _classifications = {};

  Map<String, num> get classifications => Map.fromEntries(
    (_classifications.entries.toList()
      ..sort((a, b) => a.value.compareTo(b.value)))
        .reversed
        .take(3),
  );

  Future<void> runClassification(CameraImage camera) async {
    _classifications = await _service.inferenceCameraFrame(camera);
    notifyListeners();
  }

  Future<void> close() async {
    await _service.close();
  }
}