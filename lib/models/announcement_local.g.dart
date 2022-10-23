// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'announcement_local.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class AnnouncementLocalAdapter extends TypeAdapter<AnnouncementLocal> {
  @override
  final int typeId = 2;

  @override
  AnnouncementLocal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return AnnouncementLocal(
      id: fields[0] as String,
      userId: fields[1] as String,
      startDate: fields[2] as String,
      endDate: fields[3] as String,
      announcement: fields[4] as String,
      fontSize: fields[5] as String,
      fontColor: fields[6] as String,
      backgroundImg: fields[7] as String,
      backgroundColor: fields[8] as String,
      isImg: fields[9] as String,
    );
  }

  @override
  void write(BinaryWriter writer, AnnouncementLocal obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.userId)
      ..writeByte(2)
      ..write(obj.startDate)
      ..writeByte(3)
      ..write(obj.endDate)
      ..writeByte(4)
      ..write(obj.announcement)
      ..writeByte(5)
      ..write(obj.fontSize)
      ..writeByte(6)
      ..write(obj.fontColor)
      ..writeByte(7)
      ..write(obj.backgroundImg)
      ..writeByte(8)
      ..write(obj.backgroundColor)
      ..writeByte(9)
      ..write(obj.isImg);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AnnouncementLocalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
