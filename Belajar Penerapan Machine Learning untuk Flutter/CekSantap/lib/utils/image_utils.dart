import 'dart:io';
import 'package:camera/camera.dart';
import 'package:image/image.dart' as image_lib;

class ImageUtils {
  static image_lib.Image? convertCameraImage(CameraImage cameraImage) {
    final imageFormatGroup = cameraImage.format.group;
    return switch (imageFormatGroup) {
      ImageFormatGroup.nv21 => convertNV21ToImage(cameraImage),
      ImageFormatGroup.yuv420 => convertYUV420ToImage(cameraImage),
      ImageFormatGroup.bgra8888 => convertBGRA8888ToImage(cameraImage),
      ImageFormatGroup.jpeg => convertJPEGToImage(cameraImage),
      _ => null,
    };
  }

  static image_lib.Image convertBGRA8888ToImage(CameraImage cameraImage) {
    image_lib.Image img = image_lib.Image.fromBytes(
        width: cameraImage.planes[0].width!,
        height: cameraImage.planes[0].height!,
        bytes: cameraImage.planes[0].bytes.buffer,
        order: image_lib.ChannelOrder.bgra);
    return img;
  }


  static image_lib.Image convertYUV420ToImage(CameraImage cameraImage) {
    final width = cameraImage.width;
    final height = cameraImage.height;
    final yBuffer = cameraImage.planes[0].bytes;
    final uBuffer = cameraImage.planes[1].bytes;
    final vBuffer = cameraImage.planes[2].bytes;
    final yRowStride = cameraImage.planes[0].bytesPerRow;
    final yPixelStride = cameraImage.planes[0].bytesPerPixel!;
    final uvRowStride = cameraImage.planes[1].bytesPerRow;
    final uvPixelStride = cameraImage.planes[1].bytesPerPixel!;

    final image = image_lib.Image(width: width, height: height);

    for (int h = 0; h < height; h++) {
      int uvh = (h / 2).floor();
      for (int w = 0; w < width; w++) {
        int uvw = (w / 2).floor();
        final yIndex = (h * yRowStride) + (w * yPixelStride);
        final uvIndex = (uvh * uvRowStride) + (uvw * uvPixelStride);

        final y = yBuffer[yIndex];
        final u = uBuffer[uvIndex];
        final v = vBuffer[uvIndex];

        int r = (y + 1.403 * (v - 128)).round();
        int g = (y - 0.344 * (u - 128) - 0.714 * (v - 128)).round();
        int b = (y + 1.770 * (u - 128)).round();

        r = r.clamp(0, 255);
        g = g.clamp(0, 255);
        b = b.clamp(0, 255);

        image.setPixelRgb(w, h, r, g, b);
      }
    }
    return image;
  }

  static image_lib.Image convertJPEGToImage(CameraImage cameraImage) {
    final bytes = cameraImage.planes[0].bytes;
    final image = image_lib.decodeImage(bytes);
    if (image == null) throw Exception("Cannot decode JPEG CameraImage");
    return image;
  }

  static image_lib.Image convertNV21ToImage(CameraImage cameraImage) {
    final width = cameraImage.width;
    final height = cameraImage.height;
    final nv21Bytes = cameraImage.planes[0].bytes;
    final image = image_lib.Image(width: width, height: height);

    for (int y = 0; y < height; y++) {
      for (int x = 0; x < width; x++) {
        int yValue = nv21Bytes[y * width + x];

        var color = image.getColor(yValue, yValue, yValue);
        image.setPixel(x, y, color);
      }
    }
    return image;
  }

  static Future<image_lib.Image> decodeImageFile(String imagePath) async {
    final file = File(imagePath);
    final bytes = await file.readAsBytes();
    final image = image_lib.decodeImage(bytes);
    if (image == null) throw Exception("Cannot decode image file");
    return image_lib.copyResize(image, width: 224, height: 224);
  }

  static image_lib.Image decodeImageFileSync(String imagePath) {
    final file = File(imagePath);
    final bytes = file.readAsBytesSync();
    final image = image_lib.decodeImage(bytes);
    if (image == null) throw Exception("Cannot decode image file");
    return image_lib.copyResize(image, width: 224, height: 224);
  }
}
