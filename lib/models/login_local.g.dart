// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_local.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class LoginLocalAdapter extends TypeAdapter<LoginLocal> {
  @override
  final int typeId = 0;

  @override
  LoginLocal read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return LoginLocal(
      status: fields[0] as int,
      message: fields[1] as String,
      userId: fields[2] as String,
      token: fields[3] as String,
      firebaseToken: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, LoginLocal obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.status)
      ..writeByte(1)
      ..write(obj.message)
      ..writeByte(2)
      ..write(obj.userId)
      ..writeByte(3)
      ..write(obj.token)
      ..writeByte(4)
      ..write(obj.firebaseToken);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LoginLocalAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
