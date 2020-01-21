import 'package:flutter/foundation.dart';
import 'package:worldr_task/entity/person/person.dart';

class Hockey extends Person {
  final String guid;
  final String firstName;
  final String lastName;
  final SportsType sportsType = SportsType.Hockey;
  final int colorRed;
  final int colorGreen;
  final int colorBlue;

  Hockey(
      {@required this.guid,
      @required this.firstName,
      @required this.lastName,
      @required this.colorRed,
      @required this.colorGreen,
      @required this.colorBlue})
      : super(
            guid: guid,
            firstName: firstName,
            lastName: lastName,
            sportsType: SportsType.Hockey,
            colorRed: colorRed,
            colorGreen: colorGreen,
            colorBlue: colorBlue);
}
