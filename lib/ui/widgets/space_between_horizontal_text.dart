import 'package:flutter/material.dart';

class SpaceBetweenHorizontalText extends StatelessWidget {
  const SpaceBetweenHorizontalText(
      {Key? key,
      required this.title,
      required this.content,
      required this.colorTitle,
      required this.colorContent,
      required this.fontSizeTitle,
      required this.fontSizeContent,
      required this.fontWeightTitle,
      required this.fontWeightContent})
      : super(key: key);
  final String title;
  final String content;
  final Color colorTitle;
  final Color colorContent;
  final double fontSizeTitle;
  final double fontSizeContent;
  final FontWeight fontWeightTitle;
  final FontWeight fontWeightContent;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              color: colorTitle,
              fontSize: fontSizeTitle,
              fontWeight: fontWeightTitle,
            ),
          ),
        ),
        Expanded(
          child: Text(
            content,
            style: TextStyle(
              color: colorContent,
              fontSize: fontSizeContent,
              fontWeight: fontWeightContent,
            ),
            textAlign: TextAlign.right,
          ),
        ),
      ],
    );
  }
}
