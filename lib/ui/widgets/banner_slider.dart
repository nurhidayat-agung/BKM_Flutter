import 'package:flutter/material.dart';
import 'package:newbkmmobile/models/announcement_local.dart';

class BannerSlider extends StatelessWidget {
  const BannerSlider({Key? key, required this.announcementLocal})
      : super(key: key);
  final AnnouncementLocal announcementLocal;

  @override
  Widget build(BuildContext context) {
    double height = 300.0;

    return Container(
      height: height,
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      child: Stack(
        children: [
          Container(
            alignment: Alignment.center,
            child: Image.network(
              announcementLocal.backgroundImg,
              height: height,
              width: double.infinity,
              fit: BoxFit.fill,
              loadingBuilder: (BuildContext context, Widget child,
                  ImageChunkEvent? loadingProgress) {
                if (loadingProgress == null) return child;
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
              errorBuilder: (BuildContext context, Object exception,
                  StackTrace? stackTrace) {
                return Container(
                  color: Color(int.parse(announcementLocal.backgroundColor
                      .replaceAll('#', '0xff'))),
                );
              },
              // color: Color(int.parse(announcementLocal.backgroundColor.replaceAll('#', '0xff'))),
            ),
          ),
          Container(
            margin: const EdgeInsets.all(4.0),
            alignment: Alignment.center,
            child: Text(
              announcementLocal.announcement,
              style: TextStyle(
                  color: Color(int.parse(
                      announcementLocal.fontColor.replaceAll('#', '0xff'))),
                  fontWeight: FontWeight.bold,
                  fontSize: double.parse(announcementLocal.fontSize),
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
