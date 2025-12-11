// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_simple_master.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveSimpleMasterAdapter extends TypeAdapter<HiveSimpleMaster> {
  @override
  final int typeId = 3;

  @override
  HiveSimpleMaster read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveSimpleMaster(
      id: fields[0] as String?,
      fieldName: fields[1] as String?,
      fieldValue: fields[2] as String?,
      name: fields[3] as String?,
      code: fields[4] as String?,
      sort: fields[5] as int?,
      description: fields[6] as String?,
      color: fields[7] as String?,
      colorHex: fields[8] as String?,
      isActive: fields[9] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, HiveSimpleMaster obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.fieldName)
      ..writeByte(2)
      ..write(obj.fieldValue)
      ..writeByte(3)
      ..write(obj.name)
      ..writeByte(4)
      ..write(obj.code)
      ..writeByte(5)
      ..write(obj.sort)
      ..writeByte(6)
      ..write(obj.description)
      ..writeByte(7)
      ..write(obj.color)
      ..writeByte(8)
      ..write(obj.colorHex)
      ..writeByte(9)
      ..write(obj.isActive);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveSimpleMasterAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
