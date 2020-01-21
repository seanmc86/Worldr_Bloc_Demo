import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:worldr_task/bloc/home/bloc.dart';
import 'package:worldr_task/core/errors/failure.dart';
import 'package:worldr_task/data/repository/message_repository.dart';
import 'package:worldr_task/entity/counts.dart';

class MockMessageRepository extends Mock implements MessageRepository {}

void main() {
  MockMessageRepository mockMessageRepository;

  setUp(() {
    mockMessageRepository = MockMessageRepository();
  });
  group('CreateNewMessage', () {
    final Either<Failure, void> successResponse = Right(null);
    final Either<Failure, void> errorResponse =
        Left(Failure(message: 'Creating messages failed!'));
    String errorMessage;
    successResponse.fold(
        (failure) => errorMessage = failure.message, (_) => null);
    errorResponse.fold(
        (failure) => errorMessage = failure.message, (_) => null);

    blocTest(
      'emits no [Error] when successfully called',
      build: () {
        when(mockMessageRepository.createNewMessage())
            .thenAnswer((_) async => successResponse);
        return HomeBloc(mockMessageRepository);
      },
      act: (bloc) => bloc.add(CreateNewMessage()),
      expect: [HomeState.initial()],
    );

    blocTest(
      'emits [Error] when unsuccessfully called',
      build: () {
        when(mockMessageRepository.createNewMessage())
            .thenAnswer((_) async => errorResponse);
        return HomeBloc(mockMessageRepository);
      },
      act: (bloc) => bloc.add(CreateNewMessage()),
      expect: [HomeState.initial(), HomeState.error(message: errorMessage)],
    );
  });

  group('GetUnreadMessages', () {
    final Either<Failure, Counts> successResponse =
        Right(Counts(unreadBasketball: 3, unreadHockey: 2));
    final Either<Failure, Counts> errorResponse =
        Left(Failure(message: 'Getting counts failed!'));
    String errorMessage;
    Counts counts;
    successResponse.fold((failure) => errorMessage = failure.message,
        (countsResponse) => counts = countsResponse);
    errorResponse.fold((failure) => errorMessage = failure.message,
        (countsResponse) => counts = countsResponse);

    blocTest(
      'emits [Loaded] when successfully called',
      build: () {
        when(mockMessageRepository.getUnreadMessageCount())
            .thenAnswer((_) async => successResponse);
        return HomeBloc(mockMessageRepository);
      },
      act: (bloc) => bloc.add(GetUnreadMessages()),
      expect: [HomeState.initial(), HomeState.loaded(counts: counts)],
    );

    blocTest(
      'emits [Error] when unsuccessfully called',
      build: () {
        when(mockMessageRepository.getUnreadMessageCount())
            .thenAnswer((_) async => errorResponse);
        return HomeBloc(mockMessageRepository);
      },
      act: (bloc) => bloc.add(GetUnreadMessages()),
      expect: [HomeState.initial(), HomeState.error(message: errorMessage)],
    );
  });
}
