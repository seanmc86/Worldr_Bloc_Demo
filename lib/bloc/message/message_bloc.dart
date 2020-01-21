import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:worldr_task/data/repository/message_repository.dart';
import 'package:worldr_task/entity/message.dart';
import './bloc.dart';

class MessageBloc extends Bloc<MessageEvent, MessageState> {
  final MessageRepository messageRepository;

  MessageBloc(this.messageRepository);

  Messages _messages = Messages(results: []);

  @override
  MessageState get initialState => MessageState.initial();

  @override
  Stream<MessageState> mapEventToState(
    MessageEvent event,
  ) async* {
    yield MessageState.loading();

    if (event is GetMessages) {
      final response = await messageRepository.getMessages(
          filterByGuid: event.guid, filterBySportsType: event.sportsType);

      yield* response.fold(
        (failure) async* {
          yield MessageState.error(message: failure.message);
        },
        (messages) async* {
          _messages = messages;
          yield MessageState.loaded(messages: messages);
        },
      );
    } else if (event is MessageOpened) {
      final response =
          await messageRepository.updateMessageToRead(event.message);

      yield* response.fold(
        (failure) async* {
          yield MessageState.error(message: failure.message);
        },
        (messages) async* {
          yield MessageState.loaded(messages: _messages);
        },
      );
    }
  }
}
