import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class FullImageView extends StatefulWidget {
  const FullImageView({Key? key, required this.image}) : super(key: key);
  final String image;

  @override
  State<FullImageView> createState() => _FullImageViewState();
}

class _FullImageViewState extends State<FullImageView> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: PhotoView(
        imageProvider: NetworkImage(
          widget.image,
        ),
        maxScale: PhotoViewComputedScale.covered * 2,
        minScale: PhotoViewComputedScale.contained * 0.8,
      ),
    );
  }
}
