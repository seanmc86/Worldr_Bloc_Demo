import 'package:worldr_task/entity/person/person.dart';

abstract class GlobalMessages {
  static const String appTitle = 'Worldr Task';
  static const String homeScreenTitle = 'Home';
  static const String peopleScreenTitle = 'People';
  static const String messagesScreenTitle = 'Messages';

  static const String noMessagesFromPerson =
      'You have no messages from this person!';
  static const String noPeopleInCategory =
      'There are no people in this category yet!';

  static const String sportsTitleBasketball = 'Basketball';
  static const String sportsTitleHockey = 'Hockey';

  static const String CACHE_FAILURE = 'Cache Failure';
  static const String HIVE_FAILURE = 'Local Storage Failure';

  static Person dummyPerson = Person(
      guid: '1',
      firstName: 'James',
      lastName: 'Bond 007',
      sportsType: SportsType.Basketball,
      colorRed: 200,
      colorGreen: 200,
      colorBlue: 200);
}
