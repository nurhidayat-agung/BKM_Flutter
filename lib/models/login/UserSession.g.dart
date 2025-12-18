// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserSession.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserSessionAdapter extends TypeAdapter<UserSession> {
  @override
  final int typeId = 1;

  @override
  UserSession read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserSession(
      userId: fields[0] as String?,
      roleId: fields[1] as String?,
      name: fields[2] as String?,
      roleName: fields[3] as String?,
      token: fields[4] as String?,
      siteId: fields[5] as String?,
      driverId: fields[6] as String?,
      vehicleId: fields[7] as String?,
      policeNumber: fields[8] as String?,
      walletId: fields[9] as String?,
      balance: fields[10] as String?,
      savings: fields[11] as String?,
      status: fields[12] as int,
      userLogin: fields[13] as String?,
      password: fields[14] as String?,
      saving: fields[15] as String?,
      heldAmmount: fields[16] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, UserSession obj) {
    writer
      ..writeByte(17)
      ..writeByte(0)
      ..write(obj.userId)
      ..writeByte(1)
      ..write(obj.roleId)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.roleName)
      ..writeByte(4)
      ..write(obj.token)
      ..writeByte(5)
      ..write(obj.siteId)
      ..writeByte(6)
      ..write(obj.driverId)
      ..writeByte(7)
      ..write(obj.vehicleId)
      ..writeByte(8)
      ..write(obj.policeNumber)
      ..writeByte(9)
      ..write(obj.walletId)
      ..writeByte(10)
      ..write(obj.balance)
      ..writeByte(11)
      ..write(obj.savings)
      ..writeByte(12)
      ..write(obj.status)
      ..writeByte(13)
      ..write(obj.userLogin)
      ..writeByte(14)
      ..write(obj.password)
      ..writeByte(15)
      ..write(obj.saving)
      ..writeByte(16)
      ..write(obj.heldAmmount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserSessionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
