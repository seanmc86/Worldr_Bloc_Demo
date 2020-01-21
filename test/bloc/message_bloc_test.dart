import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:worldr_task/bloc/message/bloc.dart';
import 'package:worldr_task/core/errors/failure.dart';
import 'package:worldr_task/data/repository/message_repository.dart';
import 'package:worldr_task/entity/message.dart';
import 'package:worldr_task/entity/person/person.dart';

class MockMessageRepository extends Mock implements MessageRepository {}

void main() {
  MockMessageRepository mockMessageRepository;

  setUp(() {
    mockMessageRepository = MockMessageRepository();
  });
  group('GetMessages', () {
    final Either<Failure, Messages> successResponse = Right(Messages(results: [
      Message(content: 'Hi', personGuid: '1', sportsType: SportsType.Basketball)
    ]));
    final Either<Failure, Messages> errorResponse =
        Left(Failure(message: 'Getting messages failed!'));
    String errorMessage;
    Messages messages;
    successResponse.fold((failure) => errorMessage = failure.message,
        (response) => messages = response);
    errorResponse.fold((failure) => errorMessage = failure.message,
        (response) => messages = response);

    blocTest(
      'emits [Loading], [Loaded] when successfully called',
      build: () {
        when(mockMessageRepository.getMessages())
            .thenAnswer((_) async => successResponse);
        return MessageBloc(mockMessageRepository);
      },
      act: (bloc) => bloc.add(GetMessages(guid: null, sportsType: null)),
      expect: [
        MessageState.initial(),
        MessageState.loading(),
        MessageState.loaded(messages: messages)
      ],
    );

    blocTest(
      'emits [Loading], [Error] when unsuccessfully called',
      build: () {
        when(mockMessageRepository.getMessages())
            .thenAnswer((_) async => errorResponse);
        return MessageBloc(mockMessageRepository);
      },
      act: (bloc) => bloc.add(GetMessages(guid: null, sportsType: null)),
      expect: [
        MessageState.initial(),
        MessageState.loading(),
        MessageState.error(message: errorMessage)
      ],
    );
  });

  group('MessageOpened', () {
    final Either<Failure, void> successResponse = Right(null);
    final Either<Failure, void> errorResponse =
        Left(Failure(message: 'Updating message failed!'));
    String errorMessage;
    errorResponse.fold(
        (failure) => errorMessage = failure.message, (_) => null);
    final message = Message(
        content: 'Hi', personGuid: '1', sportsType: SportsType.Basketball);
    final messages = Messages(results: [message]);
    final Either<Failure, Messages> successResponseMessages = Right(messages);

    blocTest(
      'emits [Loading], [Loaded] to first getMessages() and then [Loading], [Loaded] when successfully called',
      build: () {
        message.isRead = true;
        when(mockMessageRepository.getMessages())
            .thenAnswer((_) async => successResponseMessages);
        when(mockMessageRepository.updateMessageToRead(message))
            .thenAnswer((_) async => successResponse);
        return MessageBloc(mockMessageRepository);
      },
      act: (bloc) {
        bloc.add(GetMessages(guid: null, sportsType: null));
        return bloc.add(MessageOpened(message: message));
      },
      expect: [
        MessageState.initial(),
        MessageState.loading(),
        MessageState.loaded(messages: messages),
        MessageState.loading(),
        MessageState.loaded(messages: messages)
      ],
    );

    blocTest(
      'emits [Loading], [Error] when unsuccessfully called',
      build: () {
        message.isRead = false;
        when(mockMessageRepository.updateMessageToRead(message))
            .thenAnswer((_) async => errorResponse);
        return MessageBloc(mockMessageRepository);
      },
      act: (bloc) => bloc.add(MessageOpened(message: message)),
      expect: [
        MessageState.initial(),
        MessageState.loading(),
        MessageState.error(message: errorMessage)
      ],
    );
  });
}
