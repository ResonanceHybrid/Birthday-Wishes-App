import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'dart:io';

/// Utility class for capturing widgets as images and saving to gallery
class ImageSaver {
  /// Request storage permissions (for Android)
  static Future<bool> requestPermissions() async {
    if (Platform.isAndroid) {
      // For Android 13+, we need different permissions
      if (await Permission.photos.request().isGranted) {
        return true;
      }
      // Fallback for older Android versions
      if (await Permission.storage.request().isGranted) {
        return true;
      }
      return false;
    }
    // iOS doesn't require explicit permission for saving to gallery
    return true;
  }

  /// Capture a widget to image bytes using RepaintBoundary
  static Future<Uint8List?> captureWidget(GlobalKey repaintBoundaryKey) async {
    try {
      RenderRepaintBoundary boundary = repaintBoundaryKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary;
      
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      
      if (byteData != null) {
        return byteData.buffer.asUint8List();
      }
      return null;
    } catch (e) {
      debugPrint('Error capturing widget: $e');
      return null;
    }
  }

  /// Save image bytes to the device gallery
  static Future<bool> saveToGallery(Uint8List imageBytes, {String? fileName}) async {
    try {
      final hasPermission = await requestPermissions();
      if (!hasPermission) {
        debugPrint('Storage permission denied');
        return false;
      }

      final result = await ImageGallerySaverPlus.saveImage(
        imageBytes,
        quality: 100,
        name: fileName ?? 'birthday_wish_${DateTime.now().millisecondsSinceEpoch}',
      );

      if (result != null && result['isSuccess'] == true) {
        return true;
      }
      return false;
    } catch (e) {
      debugPrint('Error saving to gallery: $e');
      return false;
    }
  }

  /// Capture widget and save to gallery in one step
  static Future<bool> captureAndSave(GlobalKey repaintBoundaryKey, {String? fileName}) async {
    final imageBytes = await captureWidget(repaintBoundaryKey);
    if (imageBytes != null) {
      return await saveToGallery(imageBytes, fileName: fileName);
    }
    return false;
  }

  /// Capture widget and share
  static Future<void> captureAndShare(GlobalKey repaintBoundaryKey, {String? text}) async {
    try {
      final imageBytes = await captureWidget(repaintBoundaryKey);
      if (imageBytes == null) return;

      final tempDir = await getTemporaryDirectory();
      final file = File('${tempDir.path}/birthday_wish_${DateTime.now().millisecondsSinceEpoch}.png');
      await file.writeAsBytes(imageBytes);

      await Share.shareXFiles(
        [XFile(file.path)],
        text: text ?? 'Check out this birthday wish! 🎂',
      );
    } catch (e) {
      debugPrint('Error sharing: $e');
    }
  }
}
