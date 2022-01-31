// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_storage_type.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserStorageTypeAdapter extends TypeAdapter<UserStorageType> {
  @override
  final int typeId = 1;

  @override
  UserStorageType read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserStorageType(
      uid: fields[0] as int,
      age: fields[1] as int,
      name: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, UserStorageType obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.uid)
      ..writeByte(1)
      ..write(obj.age)
      ..writeByte(2)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserStorageTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
