import 'package:newbkmmobile/models/common/announcement.dart';
import 'package:newbkmmobile/models/common/master_data.dart';
import 'package:newbkmmobile/models/common/menu_item.dart';

class AppSettingsData {
  MasterData? masterData;
  List<MenuItem>? menus;
  List<Announcement>? announcements;

  AppSettingsData({
    this.masterData,
    this.menus,
    this.announcements,
  });

  factory AppSettingsData.fromJson(Map<String, dynamic> json) {
    return AppSettingsData(
      masterData: json['master_data'] != null
          ? MasterData.fromJson(json['master_data'])
          : null,
      menus: json['menus'] != null
          ? (json['menus'] as List).map((e) => MenuItem.fromJson(e)).toList()
          : null,
      announcements: json['announcements'] != null
          ? (json['announcements'] as List)
          .map((e) => Announcement.fromJson(e))
          .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'master_data': masterData?.toJson(),
    'menus': menus?.map((e) => e.toJson()).toList(),
    'announcements': announcements?.map((e) => e.toJson()).toList(),
  };
}
