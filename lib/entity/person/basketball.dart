import 'package:flutter/foundation.dart';
import 'package:worldr_task/entity/person/person.dart';

class Basketball extends Person {
  final String guid;
  final String firstName;
  final String lastName;
  final SportsType sportsType = SportsType.Basketball;
  final int colorRed;
  final int colorGreen;
  final int colorBlue;

  Basketball(
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
            sportsType: SportsType.Basketball,
            colorRed: colorRed,
            colorGreen: colorGreen,
            colorBlue: colorBlue);
}
