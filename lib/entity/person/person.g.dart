// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SportsTypeAdapter extends TypeAdapter<SportsType> {
  @override
  final typeId = 0;

  @override
  SportsType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 7:
        return SportsType.Basketball;
      case 8:
        return SportsType.Hockey;
      default:
        return null;
    }
  }

  @override
  void write(BinaryWriter writer, SportsType obj) {
    switch (obj) {
      case SportsType.Basketball:
        writer.writeByte(7);
        break;
      case SportsType.Hockey:
        writer.writeByte(8);
        break;
    }
  }
}

class PersonAdapter extends TypeAdapter<Person> {
  @override
  final typeId = 1;

  @override
  Person read(BinaryReader reader) {
    var numOfFields = reader.readByte();
    var fields = <int, dynamic>{
      for (var i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Person(
      guid: fields[0] as String,
      firstName: fields[1] as String,
      lastName: fields[2] as String,
      sportsType: fields[3] as SportsType,
      colorRed: fields[4] as int,
      colorGreen: fields[5] as int,
      colorBlue: fields[6] as int,
    );
  }

  @override
  void write(BinaryWriter writer, Person obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.guid)
      ..writeByte(1)
      ..write(obj.firstName)
      ..writeByte(2)
      ..write(obj.lastName)
      ..writeByte(3)
      ..write(obj.sportsType)
      ..writeByte(4)
      ..write(obj.colorRed)
      ..writeByte(5)
      ..write(obj.colorGreen)
      ..writeByte(6)
      ..write(obj.colorBlue);
  }
}
