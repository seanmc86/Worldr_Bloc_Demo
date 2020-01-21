import 'package:hive/hive.dart';

import 'package:worldr_task/entity/counts.dart';
import 'package:worldr_task/entity/message.dart';
import 'package:worldr_task/entity/person/person.dart';

const PERSON_BOX = 'persons';
const PERSON_KEY = 'persons_key';
const MESSAGE_BOX = 'messages';

abstract class LocalDataSource {
  /// Gets the cached [Person]
  /// Creates new [Person] and [Message] if no cached data is present.
  Future<Persons> getLastPersons({SportsType filterBySportsType});

  /// Persists all new [Persons]
  Future<void> cachePersons(Persons personsToCache);

  /// Gets the cached [Message]
  Future<Messages> getLastMessages(
      {String filterByGuid, SportsType filterBySportsType});

  /// Persists all new [Messages]
  Future<void> cacheMessages(Messages messagesToCache);

  /// Gets the [Counts] of total unread messages for all sports types
  Future<Counts> getUnreadMessageCount();

  /// Updates the read status of a [Message] to true
  Future<void> updateMessageToRead(Message message);
}

class LocalDataSourceImpl implements LocalDataSource {
  LocalDataSourceImpl();

  @override
  Future<Persons> getLastPersons({SportsType filterBySportsType}) async {
    final personsBox = await Hive.openBox<Person>(PERSON_BOX);
    if (filterBySportsType != null) {
      final personsBoxFiltered = personsBox.values
          .where((person) => person.sportsType == filterBySportsType);
      return Persons(results: personsBoxFiltered.toList());
    }
    return Persons(results: personsBox.values.toList());
  }

  @override
  Future<void> cachePersons(Persons personsToCache) async {
    final personBox = await Hive.openBox<Person>(PERSON_BOX);
    return personsToCache.results.forEach((person) async {
      await personBox.add(person);
    });
  }

  @override
  Future<Messages> getLastMessages(
      {String filterByGuid, SportsType filterBySportsType}) async {
    final messagingBox = await Hive.openBox<Message>(MESSAGE_BOX);
    if (filterByGuid != null) {
      final messagingBoxFiltered = messagingBox.values
          .where((message) => message.personGuid == filterByGuid);
      return Messages(results: messagingBoxFiltered.toList());
    }
    if (filterBySportsType != null) {
      final messagingBoxFiltered = messagingBox.values
          .where((message) => message.sportsType == filterBySportsType);
      return Messages(results: messagingBoxFiltered.toList());
    }
    return Messages(results: messagingBox.values.toList());
  }

  @override
  Future<void> cacheMessages(Messages messagesToCache) async {
    final messagingBox = await Hive.openBox<Message>(MESSAGE_BOX);
    return messagesToCache.results.forEach((message) async {
      await messagingBox.add(message);
    });
  }

  @override
  Future<Counts> getUnreadMessageCount() async {
    final messagingBox = await Hive.openBox<Message>(MESSAGE_BOX);
    final basketballCount = messagingBox.values
        .where((message) =>
            !message.isRead && message.sportsType == SportsType.Basketball)
        .length;
    final hockeyCount = messagingBox.values
        .where((message) =>
            !message.isRead && message.sportsType == SportsType.Hockey)
        .length;
    return Counts(unreadBasketball: basketballCount, unreadHockey: hockeyCount);
  }

  @override
  Future<void> updateMessageToRead(Message message) async {
    message.isRead = true;
    return message.save();
  }
}
