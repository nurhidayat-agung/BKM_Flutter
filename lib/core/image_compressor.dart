import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';

class ImageCompressor {
  static Future<File> compressImageRecursive(
      File originalFile, {
        double targetMB = 0.5,
        int quality = 95,
      }) async {
    final targetSizeInBytes = targetMB * 1024 * 1024;
    final currentSize = await originalFile.length();

    // BASE CASE (Berhenti jika sudah di bawah 1 MB atau batas kualitas)
    if (currentSize <= targetSizeInBytes || quality <= 10) {
      return originalFile;
    }

    final tempDir = await getTemporaryDirectory();
    final targetPath = '${tempDir.absolute.path}/temp_compress_${DateTime.now().millisecondsSinceEpoch}.jpg';

    // Proses Kompresi
    final XFile? compressedXFile = await FlutterImageCompress.compressAndGetFile(
      originalFile.absolute.path,
      targetPath,
      quality: quality,
      minWidth: 1920,
      minHeight: 1080,
    );

    if (compressedXFile == null) return originalFile;

    File resultFile = File(compressedXFile.path);
    int newSize = await resultFile.length();

    if (newSize <= targetSizeInBytes) {
      return resultFile;
    } else {
      // REKURSIF: Panggil lagi dengan kualitas diturunkan 10
      return compressImageRecursive(
        originalFile,
        targetMB: targetMB,
        quality: quality - 10,
      );
    }
  }
}