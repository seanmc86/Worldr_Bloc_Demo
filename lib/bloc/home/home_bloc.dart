import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:faker/faker.dart' as Faker;
import 'package:worldr_task/data/repository/message_repository.dart';
import './bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final MessageRepository messageRepository;

  HomeBloc(this.messageRepository);

  @override
  HomeState get initialState => HomeState.initial();

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    if (event is CreateNewMessage) {
      /// To ensure we have a valid [Persons] object
      /// For the new [Message] to be created
      /// We need to run getPersons() at least once
      await messageRepository.getPersons();

      /// Now we can create new [Message]
      final messageResponse = await messageRepository.createNewMessage();

      yield* messageResponse.fold(
        (failure) async* {
          yield HomeState.error(message: failure.message);
        },
        (_) async* {
          /// We need to place a timer in our BLoC to re-run this method,
          /// otherwise we will not receive any new [HomeState] to inform our UI
          final _randomSeconds = Faker.random.integer(5, min: 1);
          Future.delayed(Duration(seconds: _randomSeconds),
              () => add(HomeEvent.createNewMessage()));

          add(HomeEvent.getUnreadMessages());
        },
      );
    } else if (event is GetUnreadMessages) {
      /// Now we will return the [Counts] of new unread messages
      final response = await messageRepository.getUnreadMessageCount();

      yield* response.fold(
        (failure) async* {
          yield HomeState.error(message: failure.message);
        },
        (counts) async* {
          yield HomeState.loaded(counts: counts);
        },
      );
    }
  }
}
