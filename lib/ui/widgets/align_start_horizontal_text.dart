import 'package:flutter/material.dart';
import 'package:newbkmmobile/core/r.dart';

class AlignStartHorizontalText extends StatelessWidget {
  const AlignStartHorizontalText(
      {Key? key,
      required this.title,
      required this.content,
      required this.colorTitle,
      required this.colorContent,
      required this.fontSizeTitle,
      required this.fontSizeContent,
      required this.fontWeightTitle,
      required this.fontWeightContent,
      required this.colorBackgroundContent})
      : super(key: key);
  final String title;
  final String content;
  final Color colorTitle;
  final Color colorContent;
  final double fontSizeTitle;
  final double fontSizeContent;
  final FontWeight fontWeightTitle;
  final FontWeight fontWeightContent;
  final Color colorBackgroundContent;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          flex: 3,
          child: Text(
            title,
            style: TextStyle(
              color: colorTitle,
              fontSize: fontSizeTitle,
              fontWeight: fontWeightTitle,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            R.strings.colon,
            style: TextStyle(
              color: colorTitle,
              fontSize: fontSizeTitle,
              fontWeight: fontWeightTitle,
            ),
          ),
        ),
        Expanded(
          flex: 7,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: colorBackgroundContent,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: colorBackgroundContent == Colors.transparent
                    ? Text(
                        content,
                        style: TextStyle(
                          color: colorContent,
                          fontSize: fontSizeContent,
                          fontWeight: fontWeightContent,
                        ),
                        textAlign: TextAlign.start,
                      )
                    : Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Text(
                          content,
                          style: TextStyle(
                            color: colorContent,
                            fontSize: fontSizeContent,
                            fontWeight: fontWeightContent,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
