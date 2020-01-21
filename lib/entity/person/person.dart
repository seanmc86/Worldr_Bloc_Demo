import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:worldr_task/core/errors/global_messages.dart';

part 'person.g.dart';

@HiveType(typeId: 0)
enum SportsType {
  @HiveField(7)
  Basketball,
  @HiveField(8)
  Hockey
}

SportsType _getSportsTypeFromString(String fromString) {
  switch (fromString) {
    case GlobalMessages.sportsTitleBasketball:
      return SportsType.Basketball;
      break;
    default:
      return SportsType.Hockey;
  }
}

@HiveType(typeId: 1)
class Person extends HiveObject {
  @HiveField(0)
  final String guid;
  @HiveField(1)
  final String firstName;
  @HiveField(2)
  final String lastName;
  @HiveField(3)
  final SportsType sportsType;
  @HiveField(4)
  final int colorRed;
  @HiveField(5)
  final int colorGreen;
  @HiveField(6)
  final int colorBlue;

  Person(
      {@required this.guid,
      @required this.firstName,
      @required this.lastName,
      @required this.sportsType,
      @required this.colorRed,
      @required this.colorGreen,
      @required this.colorBlue});

  factory Person.fromFaker(dynamic data) {
    return Person(
        guid: data['guid'],
        firstName: data['firstName'],
        lastName: data['lastName'],
        sportsType: data['sportsType'],
        colorRed: data['colorRed'],
        colorGreen: data['colorGreen'],
        colorBlue: data['colorBlue']);
  }

  factory Person.fromJson(Map<String, dynamic> json) {
    return Person(
        guid: json['guid'],
        firstName: json['firstName'],
        lastName: json['lastName'],
        sportsType: _getSportsTypeFromString(json['sportsType']),
        colorRed: json['colorRed'],
        colorGreen: json['colorGreen'],
        colorBlue: json['colorBlue']);
  }
}

class Persons extends Equatable {
  final List<Person> results;

  const Persons({@required this.results});

  @override
  List get props => [results];
}
