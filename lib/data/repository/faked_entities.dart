import 'package:faker/faker.dart' as Faker;
import 'package:worldr_task/entity/message.dart';
import 'package:worldr_task/entity/person/person.dart';

abstract class FakedEntities {
  static Persons createPersons(int min, int max) {
    final faker = Faker.Faker();

    /// Create a list of faked persons between the length of [min] and [max]
    final fakedPersons = Faker.random.amount(
        (_) => {
              'guid': faker.guid.guid(),
              'firstName': faker.person.firstName(),
              'lastName': faker.person.lastName(),
              'sportsType': Faker.random.boolean()
                  ? SportsType.Basketball
                  : SportsType.Hockey,
              'colorRed': Faker.random.integer(255, min: 0),
              'colorGreen': Faker.random.integer(255, min: 0),
              'colorBlue': Faker.random.integer(255, min: 0)
            },
        max,
        min: min);

    /// Converts faked dynamic objects to [Person] objects
    final persons = Persons(
        results:
            fakedPersons.map((person) => Person.fromFaker(person)).toList());

    return persons;
  }

  static Messages createMessages(Persons persons, int min, int max) {
    final faker = Faker.Faker();

    /// Create a list of faked messages between the length of [min] and [max]
    /// Uses a random guid from those already created in the faked persons
    final fakedMessages = Faker.random.amount((_) {
      final randomPerson = persons
          .results[Faker.random.integer(persons.results.length - 1, min: 0)];
      return {
        'personGuid': randomPerson.guid,
        'content': '${faker.lorem.sentence()} ${faker.lorem.sentence()}',
        'sportsType': randomPerson.sportsType
      };
    }, max, min: min);

    /// Converts faked dynamic objects to [Message] objects
    final messages = Messages(
        results: fakedMessages
            .map((message) => Message.fromFaker(message))
            .toList());

    return messages;
  }
}
