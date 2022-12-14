// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'vehicle_local.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VehicleLocalAdapter extends TypeAdapter<VehicleLocal> {
  @override
  final int typeId = 3;

  @override
  VehicleLocal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return VehicleLocal(
      id: fields[0] as String,
      vehicleNumber: fields[1] as String,
      isAvailable: fields[2] as String,
      repairStatus: fields[3] as String,
      capacity: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, VehicleLocal obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.vehicleNumber)
      ..writeByte(2)
      ..write(obj.isAvailable)
      ..writeByte(3)
      ..write(obj.repairStatus)
      ..writeByte(4)
      ..write(obj.capacity);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VehicleLocalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
