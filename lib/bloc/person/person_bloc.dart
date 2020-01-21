import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:worldr_task/data/repository/message_repository.dart';
import 'package:worldr_task/entity/person/person.dart';
import './bloc.dart';

class PersonBloc extends Bloc<PersonEvent, PersonState> {
  final MessageRepository messageRepository;

  PersonBloc(this.messageRepository);

  @override
  PersonState get initialState => PersonState.initial();

  @override
  Stream<PersonState> mapEventToState(
    PersonEvent event,
  ) async* {
    yield PersonState.loading();

    if (event is GetPersons) {
      final response = await messageRepository.getPersons();

      yield* response.fold(
        (failure) async* {
          yield PersonState.error(message: failure.message);
        },
        (persons) async* {
          yield PersonState.loaded(
              persons: persons, sportsType: SportsType.Basketball);
        },
      );
    } else if (event is GetPersonsForType) {
      final response = await messageRepository.getPersons(
          filterBySportsType: event.sportsType);

      yield* response.fold(
        (failure) async* {
          yield PersonState.error(message: failure.message);
        },
        (persons) async* {
          yield PersonState.loaded(
              persons: persons, sportsType: SportsType.Basketball);
        },
      );
    }
  }
}
