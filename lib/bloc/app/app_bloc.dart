import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:worldr_task/entity/person/person.dart';
import './bloc.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  @override
  AppState get initialState => AppState.initial();

  int _currentPageIndex = 0;

  @override
  Stream<AppState> mapEventToState(
    AppEvent event,
  ) async* {
    if (event is GetPage) {
      /// We only want to store a previous page if it is not the [MessageScreen]
      if (event.pageNum != 2) _currentPageIndex = event.pageNum;

      yield AppState.loaded(
          pageNum: event.pageNum, sportsType: event.sportsType);
    } else if (event is GoBack) {
      yield AppState.loaded(
          pageNum: _currentPageIndex, sportsType: SportsType.Basketball);
    } else if (event is GoToMessages) {
      yield AppState.loadedMessages(
          pageNum: event.pageNum,
          filtedByGuid: event.filtedByGuid,
          filterBySportsType: event.filterBySportsType);
    }
  }
}
