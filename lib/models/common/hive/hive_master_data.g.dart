// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive_master_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HiveMasterDataAdapter extends TypeAdapter<HiveMasterData> {
  @override
  final int typeId = 2;

  @override
  HiveMasterData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HiveMasterData(
      repairTypes: (fields[0] as List?)?.cast<HiveSimpleMaster>(),
      leaveTypes: (fields[1] as List?)?.cast<HiveSimpleMaster>(),
      urgencyLevels: (fields[2] as List?)?.cast<HiveSimpleMaster>(),
      maintenancetypes: (fields[3] as List?)?.cast<HiveSimpleMaster>(),
    );
  }

  @override
  void write(BinaryWriter writer, HiveMasterData obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.repairTypes)
      ..writeByte(1)
      ..write(obj.leaveTypes)
      ..writeByte(2)
      ..write(obj.urgencyLevels)
      ..writeByte(3)
      ..write(obj.maintenancetypes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HiveMasterDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
