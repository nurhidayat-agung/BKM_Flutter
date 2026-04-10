import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'image_compressor.dart';

Future<void> pickImage({
  required BuildContext context,
  required Function(File) onImagePicked,
}) async {
  final ImagePicker picker = ImagePicker();

  showModalBottomSheet(
    context: context,
    builder: (_) {
      return SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt),
              title: const Text('Ambil dari Kamera'),
              onTap: () async {
                Navigator.pop(context);
                // 1. Ambil foto asli (tanpa dibatasi kualitasnya di sini)
                final XFile? image = await picker.pickImage(
                    source: ImageSource.camera,
                );

                if (image != null) {
                  File originalFile = File(image.path);

                  // 2. Masukkan ke Mesin Kompresi Dinamis! (Otomatis target 2 MB)
                  File compressedFile = await ImageCompressor.compressImageRecursive(originalFile);

                  // 3. Kirim hasilnya kembali ke Form
                  onImagePicked(compressedFile);
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo),
              title: const Text('Pilih dari Galeri'),
              onTap: () async {
                Navigator.pop(context);
                final XFile? image = await picker.pickImage(
                  source: ImageSource.gallery,
                );

                if (image != null) {
                  File originalFile = File(image.path);

                  // 2. Masukkan ke Mesin Kompresi Dinamis! (Otomatis target 2 MB)
                  File compressedFile = await ImageCompressor.compressImageRecursive(originalFile);

                  // 3. Kirim hasilnya kembali ke Form
                  onImagePicked(compressedFile);
                }
              },
            ),
          ],
        ),
      );
    },
  );
}
