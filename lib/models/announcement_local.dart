import 'package:hive/hive.dart';

part 'announcement_local.g.dart';

@HiveType(typeId: 2)
class AnnouncementLocal {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String userId;

  @HiveField(2)
  final String startDate;

  @HiveField(3)
  final String endDate;

  @HiveField(4)
  final String announcement;

  @HiveField(5)
  final String fontSize;

  @HiveField(6)
  final String fontColor;

  @HiveField(7)
  final String backgroundImg;

  @HiveField(8)
  final String backgroundColor;

  @HiveField(9)
  final String isImg;

  AnnouncementLocal({
    required this.id,
    required this.userId,
    required this.startDate,
    required this.endDate,
    required this.announcement,
    required this.fontSize,
    required this.fontColor,
    required this.backgroundImg,
    required this.backgroundColor,
    required this.isImg,
  });
}