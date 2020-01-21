import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

import 'package:worldr_task/core/errors/failure.dart';
import 'package:worldr_task/core/errors/global_messages.dart';
import 'package:worldr_task/data/provider/local_data_source.dart';
import 'package:worldr_task/data/repository/faked_entities.dart';
import 'package:worldr_task/entity/counts.dart';
import 'package:worldr_task/entity/message.dart';
import 'package:worldr_task/entity/person/person.dart';

import '../../core/errors/exceptions.dart';

abstract class MessageRepository {
  Future<Either<Failure, Persons>> getPersons({SportsType filterBySportsType});
  Future<Either<Failure, Counts>> getUnreadMessageCount();
  Future<Either<Failure, Messages>> getMessages(
      {String filterByGuid, SportsType filterBySportsType});
  Future<Either<Failure, void>> updateMessageToRead(Message message);
  Future<Either<Failure, void>> createNewMessage();
}

class MessageRepositoryImpl implements MessageRepository {
  final LocalDataSource localDataSource;

  MessageRepositoryImpl({
    @required this.localDataSource,
  });

  @override
  Future<Either<Failure, Persons>> getPersons(
      {SportsType filterBySportsType}) async {
    try {
      /// TODO: Monitor investigation of Github issue logged at:
      /// https://github.com/hivedb/hive/issues/192
      /// (HiveError when opening box - temporary remedy is deleting/reinstalling app)
      var persons = await localDataSource.getLastPersons(
          filterBySportsType: filterBySportsType);

      /// If we receive no [Persons] AND there is no filter,
      /// this means the app is in a first-load state,
      /// so we should queue up the creation of new entities
      if (persons.results.length == 0 && filterBySportsType == null) {
        persons = await _cacheNewEntities();
      }
      return Right(persons);
    } on CacheException {
      return Left(Failure(message: GlobalMessages.CACHE_FAILURE));
    } on HiveError {
      return Left(Failure(message: GlobalMessages.HIVE_FAILURE));
    }
  }

  @override
  Future<Either<Failure, Counts>> getUnreadMessageCount() async {
    try {
      final count = await localDataSource.getUnreadMessageCount();
      return Right(count);
    } on CacheException {
      return Left(Failure(message: GlobalMessages.CACHE_FAILURE));
    } on HiveError {
      return Left(Failure(message: GlobalMessages.HIVE_FAILURE));
    }
  }

  @override
  Future<Either<Failure, Messages>> getMessages(
      {String filterByGuid, SportsType filterBySportsType}) async {
    try {
      final messages = await localDataSource.getLastMessages(
          filterByGuid: filterByGuid, filterBySportsType: filterBySportsType);
      return Right(messages);
    } on CacheException {
      return Left(Failure(message: GlobalMessages.CACHE_FAILURE));
    } on HiveError {
      return Left(Failure(message: GlobalMessages.HIVE_FAILURE));
    }
  }

  @override
  Future<Either<Failure, void>> updateMessageToRead(Message message) async {
    try {
      await localDataSource.updateMessageToRead(message);
      return Right(null);
    } on CacheException {
      return Left(Failure(message: GlobalMessages.CACHE_FAILURE));
    } on HiveError {
      return Left(Failure(message: GlobalMessages.HIVE_FAILURE));
    }
  }

  @override
  Future<Either<Failure, void>> createNewMessage() async {
    try {
      final persons = await localDataSource.getLastPersons();
      final messages = FakedEntities.createMessages(persons, 1, 1);

      print(
          'Message created on user: ${messages.results.first.personGuid} at time ${DateTime.now()}');

      await localDataSource.cacheMessages(messages);

      return Right(null);
    } on HiveError {
      return Left(Failure(message: GlobalMessages.HIVE_FAILURE));
    } catch (e) {
      /// TODO: Add some sort of analytics, as this should never fail
      return Left(Failure(message: e.toString()));
    }
  }

  Future<Persons> _cacheNewEntities() async {
    final persons = FakedEntities.createPersons(3, 5);
    final messages = FakedEntities.createMessages(persons, 5, 10);

    await localDataSource.cachePersons(persons);
    await localDataSource.cacheMessages(messages);

    return persons;
  }
}
