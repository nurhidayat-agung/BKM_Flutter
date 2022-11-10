import 'package:flutter/material.dart';

class GridItem {
  final String title;
  final AssetImage image;
  final Color color;
  final Widget widget;

  GridItem({required this.title, required this.image, required this.color, required this.widget});
}