import 'package:newbkmmobile/core/R/json_safe.dart';

class FileModel {
  final String? id;
  final String? fileName;
  final String? url;

  FileModel({this.id, this.fileName, this.url});

  factory FileModel.fromJson(Map<String, dynamic> json) {
    return FileModel(
      id: safeString(json['id']),
      fileName: safeString(json['file_name']),
      url: safeString(json['url']),
    );
  }
}
