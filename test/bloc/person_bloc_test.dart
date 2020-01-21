import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:worldr_task/bloc/person/bloc.dart';
import 'package:worldr_task/core/errors/failure.dart';
import 'package:worldr_task/data/repository/message_repository.dart';
import 'package:worldr_task/entity/person/person.dart';

class MockMessageRepository extends Mock implements MessageRepository {}

void main() {
  MockMessageRepository mockMessageRepository;

  setUp(() {
    mockMessageRepository = MockMessageRepository();
  });
  group('GetPersons', () {
    final Either<Failure, Persons> successResponse = Right(Persons(results: [
      Person(
          guid: '1',
          firstName: 'Joe',
          lastName: 'Soap',
          sportsType: SportsType.Basketball,
          colorRed: 200,
          colorBlue: 200,
          colorGreen: 200)
    ]));
    final Either<Failure, Persons> errorResponse =
        Left(Failure(message: 'Getting persons failed!'));
    String errorMessage;
    Persons persons;
    successResponse.fold((failure) => errorMessage = failure.message,
        (response) => persons = response);
    errorResponse.fold((failure) => errorMessage = failure.message,
        (response) => persons = response);

    blocTest(
      'emits [Loading], [Loaded] when successfully called',
      build: () {
        when(mockMessageRepository.getPersons())
            .thenAnswer((_) async => successResponse);
        return PersonBloc(mockMessageRepository);
      },
      act: (bloc) => bloc.add(GetPersons()),
      expect: [
        PersonState.initial(),
        PersonState.loading(),
        PersonState.loaded(persons: persons, sportsType: SportsType.Basketball)
      ],
    );

    blocTest(
      'emits [Loading], [Error] when unsuccessfully called',
      build: () {
        when(mockMessageRepository.getPersons())
            .thenAnswer((_) async => errorResponse);
        return PersonBloc(mockMessageRepository);
      },
      act: (bloc) => bloc.add(GetPersons()),
      expect: [
        PersonState.initial(),
        PersonState.loading(),
        PersonState.error(message: errorMessage)
      ],
    );
  });

  group('GetPersonsForType', () {
    final Either<Failure, Persons> successResponse = Right(Persons(results: [
      Person(
          guid: '1',
          firstName: 'Joe',
          lastName: 'Soap',
          sportsType: SportsType.Basketball,
          colorRed: 200,
          colorBlue: 200,
          colorGreen: 200)
    ]));
    final Either<Failure, Persons> successResponseEmpty =
        Right(Persons(results: []));
    final Either<Failure, Persons> errorResponse =
        Left(Failure(message: 'Getting persons failed!'));
    String errorMessage;
    Persons persons;
    Persons personsFiltered;
    successResponse.fold((failure) => errorMessage = failure.message,
        (response) => persons = response);
    successResponseEmpty.fold((failure) => errorMessage = failure.message,
        (response) => personsFiltered = response);
    errorResponse.fold((failure) => errorMessage = failure.message,
        (response) => persons = response);

    blocTest(
      'emits [Loading], [Loaded] when successfully called with correct filter',
      build: () {
        when(mockMessageRepository.getPersons(
                filterBySportsType: SportsType.Basketball))
            .thenAnswer((_) async => successResponse);
        return PersonBloc(mockMessageRepository);
      },
      act: (bloc) =>
          bloc.add(GetPersonsForType(sportsType: SportsType.Basketball)),
      expect: [
        PersonState.initial(),
        PersonState.loading(),
        PersonState.loaded(persons: persons, sportsType: SportsType.Basketball)
      ],
    );

    blocTest(
      'emits [Loading], [Loaded] when successfully called with the incorrect filter',
      build: () {
        when(mockMessageRepository.getPersons(
                filterBySportsType: SportsType.Hockey))
            .thenAnswer((_) async => successResponseEmpty);
        return PersonBloc(mockMessageRepository);
      },
      act: (bloc) => bloc.add(GetPersonsForType(sportsType: SportsType.Hockey)),
      expect: [
        PersonState.initial(),
        PersonState.loading(),
        PersonState.loaded(
            persons: personsFiltered, sportsType: SportsType.Basketball)
      ],
    );

    blocTest(
      'emits [Loading], [Error] when unsuccessfully called',
      build: () {
        when(mockMessageRepository.getPersons())
            .thenAnswer((_) async => errorResponse);
        return PersonBloc(mockMessageRepository);
      },
      act: (bloc) => bloc.add(GetPersons()),
      expect: [
        PersonState.initial(),
        PersonState.loading(),
        PersonState.error(message: errorMessage)
      ],
    );
  });
}
