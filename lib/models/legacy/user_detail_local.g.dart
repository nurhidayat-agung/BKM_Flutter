// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_detail_local.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserDetailLocalAdapter extends TypeAdapter<UserDetailLocal> {
  @override
  final int typeId = 1;

  @override
  UserDetailLocal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserDetailLocal(
      userId: fields[0] as String,
      driverId: fields[1] as String,
      fullName: fields[2] as String,
      mobileNumber: fields[3] as String,
      dOB: fields[4] as String,
      address: fields[5] as String,
      bloodType: fields[6] as String,
      profilImg: fields[7] as String,
      activeWorkingDate: fields[8] as String,
      dedication: fields[9] as String,
      numberOfTrip: fields[10] as String,
      announcement: (fields[11] as List).cast<AnnouncementLocal>(),
      vehicle: fields[12] as VehicleLocal,
    );
  }

  @override
  void write(BinaryWriter writer, UserDetailLocal obj) {
    writer
      ..writeByte(13)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.driverId)
      ..writeByte(2)
      ..write(obj.fullName)
      ..writeByte(3)
      ..write(obj.mobileNumber)
      ..writeByte(4)
      ..write(obj.dOB)
      ..writeByte(5)
      ..write(obj.address)
      ..writeByte(6)
      ..write(obj.bloodType)
      ..writeByte(7)
      ..write(obj.profilImg)
      ..writeByte(8)
      ..write(obj.activeWorkingDate)
      ..writeByte(9)
      ..write(obj.dedication)
      ..writeByte(10)
      ..write(obj.numberOfTrip)
      ..writeByte(11)
      ..write(obj.announcement)
      ..writeByte(12)
      ..write(obj.vehicle);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserDetailLocalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
