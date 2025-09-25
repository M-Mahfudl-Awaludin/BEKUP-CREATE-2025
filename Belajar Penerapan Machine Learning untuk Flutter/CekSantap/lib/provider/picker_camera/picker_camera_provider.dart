import 'package:ceksantap/screen/picker_camera/camera_screen.dart';
import 'package:ceksantap/static/tflite_service.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';


class PickerCameraProvider extends ChangeNotifier {
  String? imagePath;
  XFile? imageFile;

  bool isUploading = false;
  bool _isCropping = false;
  String? message;
  UploadResponse? uploadResponse;

  final TFLiteService _tfliteService = TFLiteService();

  Future<void> initModel() async {
    await _tfliteService.loadModel();
  }

  void setUploading(bool value) {
    isUploading = value;
    notifyListeners();
  }

  void _setImage(XFile? value) {
    imageFile = value;
    imagePath = value?.path;
    notifyListeners();
  }

  Future<void> openCamera() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      final cropped = await _cropImage(pickedFile.path);
      if (cropped != null) {
        _setImage(cropped);
        _resetUploadState();
      }
    }
  }

  Future<void> openCustomCamera(BuildContext context) async {
    final XFile? pickedFile = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CameraPage(),
      ),
    );

    if (pickedFile != null) {
      final cropped = await _cropImage(pickedFile.path);
      if (cropped != null) {
        _setImage(cropped);
        _resetUploadState();
      }
    }
  }


  Future<void> openGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final cropped = await _cropImage(pickedFile.path);
      if (cropped != null) {
        _setImage(cropped);
        _resetUploadState();
      }
    }
  }



  Future<XFile?> _cropImage(String path) async {
    if (_isCropping) return null;
    _isCropping = true;

    try {
      final croppedFile = await ImageCropper().cropImage(
        sourcePath: path,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            lockAspectRatio: false,
          ),
          IOSUiSettings(title: 'Cropper'),
        ],
      );

      if (croppedFile != null) return XFile(croppedFile.path);
    } catch (e) {
      debugPrint('Crop error: $e');
    } finally {
      _isCropping = false;
    }

    return null;
  }

  Future<void> analyzeImage() async {
    if (imagePath == null) return;

    setUploading(true);
    _resetUploadState();

    try {
      final result = await _tfliteService.classifyImage(imagePath!);

      uploadResponse = UploadResponse(
        message: "Success",
        data: UploadData(
          result: result['result'],
          confidenceScore: (result['confidence'] * 100).toInt(),
        ),
      );
      message = "Detected: ${uploadResponse!.data!.result}";
    } catch (e) {
      message = "Error: $e";
    }

    setUploading(false);
    notifyListeners();
  }

  void _resetUploadState() {
    message = null;
    uploadResponse = null;
    notifyListeners();
  }
}

class UploadData {
  final String result;
  final int confidenceScore;
  UploadData({required this.result, required this.confidenceScore});
}

class UploadResponse {
  final String? message;
  final UploadData? data;
  UploadResponse({this.message, this.data});
}
