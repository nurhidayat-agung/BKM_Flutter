import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

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
                final XFile? image = await picker.pickImage(
                  source: ImageSource.camera,
                  imageQuality: 30, //konversi 30%
                  maxWidth: 720,
                  maxHeight: 720,
                );

                if (image != null) {
                  onImagePicked(File(image.path));
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
                  imageQuality: 30, // Konversi 30%
                  maxWidth: 720,
                  maxHeight: 720,
                );

                if (image != null) {
                  onImagePicked(File(image.path));
                }
              },
            ),
          ],
        ),
      );
    },
  );
}
