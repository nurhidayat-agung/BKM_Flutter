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
    const primaryDarkColor = Color(0xFF2B4D66);
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // ==========================================
          // LAYER 1: GAMBAR FULL SCREEN
          // ==========================================
          Center(
            child: PhotoView(
              imageProvider: NetworkImage(
                widget.image,
              ),
              maxScale: PhotoViewComputedScale.covered * 2,
              minScale: PhotoViewComputedScale.contained * 0.8,
              errorBuilder: (context, error, stackTrace) {
                return const Center(
                  child: Text(
                    "Gambar tidak dapat dimuat",
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                );
              },
            ),
          ),

          // ==========================================
          // LAYER 2: TOMBOL KEMBALI (Di pojok kiri atas)
          // ==========================================
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(left: 12.0, top: 12.0),
              child: InkWell(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: primaryDarkColor,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.chevron_left,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
    // return Center(
    //   child: PhotoView(
    //     imageProvider: NetworkImage(
    //       widget.image,
    //     ),
    //     maxScale: PhotoViewComputedScale.covered * 2,
    //     minScale: PhotoViewComputedScale.contained * 0.8,
    //   ),
    // );
  }
}

