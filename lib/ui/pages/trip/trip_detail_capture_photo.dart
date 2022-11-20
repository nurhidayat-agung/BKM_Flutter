import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:newbkmmobile/core/r.dart';

class TripDetailCapturePhoto extends StatefulWidget {
  const TripDetailCapturePhoto({
    Key? key,
    required this.spbImg,
    required this.onPhotoSelected,
  }) : super(key: key);
  final String spbImg;
  final Function(File) onPhotoSelected;

  @override
  State<TripDetailCapturePhoto> createState() => _TripDetailCapturePhotoState();
}

class _TripDetailCapturePhotoState extends State<TripDetailCapturePhoto> {
  final imgPicker = ImagePicker();
  File? _imgFile;

  @override
  Widget build(BuildContext context) {
    void openCamera() async {
      Navigator.of(context).pop();
      var imgCamera = await imgPicker.pickImage(source: ImageSource.camera);
      setState(() {
        _imgFile = File(imgCamera?.path ?? "");
        widget.onPhotoSelected(File(imgCamera?.path ?? ""));
      });
    }

    void openGallery() async {
      Navigator.of(context).pop();
      var imgGallery = await imgPicker.pickImage(source: ImageSource.gallery);
      setState(() {
        _imgFile = File(imgGallery?.path ?? "");
        widget.onPhotoSelected(File(imgGallery?.path ?? ""));
      });
    }

    return SizedBox(
      width: MediaQuery.of(context).size.width / 2,
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              title: Text(R.strings.titleChooseImage),
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    GestureDetector(
                      child: Text(R.strings.takePhoto),
                      onTap: () {
                        openCamera();
                      },
                    ),
                    const SizedBox(height: 18.0),
                    GestureDetector(
                      child: Text(R.strings.openGallery),
                      onTap: () {
                        openGallery();
                      },
                    ),
                    const SizedBox(height: 18.0),
                    GestureDetector(
                      child: Text(R.strings.cancel),
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                ),
              ),
            ),
          );
        },
        child: displayPhoto(widget.spbImg),
      ),
    );
  }

  Image displayPhoto(String spbImg) {
    if (_imgFile == null || _imgFile!.path.isEmpty) {
      return Image.network(
        spbImg,
        height: 100.0,
        width: double.infinity,
        fit: BoxFit.fill,
        loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) return child;
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
        errorBuilder:
            (BuildContext context, Object exception, StackTrace? stackTrace) {
          return const Icon(
            Icons.photo_camera,
            color: Colors.grey,
            size: 100.0,
          );
        },
      );
    } else {
      return Image.file(
        _imgFile ?? File(""),
        height: 200.0,
        width: double.infinity,
      );
    }
  }
}
