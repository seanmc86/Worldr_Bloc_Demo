// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MessageAdapter extends TypeAdapter<Message> {
  @override
  final typeId = 2;

  @override
  Message read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Message(
      personGuid: fields[0] as String,
      content: fields[1] as String,
      sportsType: fields[3] as SportsType,
    )..isRead = fields[2] as bool;
  }

  @override
  void write(BinaryWriter writer, Message obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.personGuid)
      ..writeByte(1)
      ..write(obj.content)
      ..writeByte(2)
      ..write(obj.isRead)
      ..writeByte(3)
      ..write(obj.sportsType);
  }
}
