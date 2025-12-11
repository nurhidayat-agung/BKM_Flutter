import 'package:hive/hive.dart';
import 'package:newbkmmobile/core/R/HiveTypeId.dart';

part 'hive_simple_master.g.dart';

@HiveType(typeId: HiveTypeId.masterDataItem)
class HiveSimpleMaster {
  @HiveField(0)
  String? id;

  @HiveField(1)
  String? fieldName;

  @HiveField(2)
  String? fieldValue;

  @HiveField(3)
  String? name;

  @HiveField(4)
  String? code;

  @HiveField(5)
  int? sort;

  @HiveField(6)
  String? description;

  @HiveField(7)
  String? color;

  @HiveField(8)
  String? colorHex;

  @HiveField(9)
  int? isActive;

  HiveSimpleMaster({
    this.id,
    this.fieldName,
    this.fieldValue,
    this.name,
    this.code,
    this.sort,
    this.description,
    this.color,
    this.colorHex,
    this.isActive,
  });
}
