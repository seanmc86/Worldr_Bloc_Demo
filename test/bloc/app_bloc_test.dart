import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:worldr_task/bloc/app/bloc.dart';
import 'package:worldr_task/entity/person/person.dart';

void main() {
  group('GetPage', () {
    blocTest(
      'emits [Loaded] when called',
      build: () {
        return AppBloc();
      },
      act: (bloc) =>
          bloc.add(GetPage(pageNum: 0, sportsType: SportsType.Basketball)),
      expect: [
        AppState.initial(),
        AppState.loaded(pageNum: 0, sportsType: SportsType.Basketball)
      ],
    );
  });

  group('GoBack', () {
    blocTest(
      'emits [Loaded] with the corresponding pageNum of 0 or 1 from GetPage() when called',
      build: () {
        return AppBloc();
      },
      act: (bloc) {
        bloc.add(GetPage(pageNum: 1, sportsType: SportsType.Basketball));
        return bloc.add(GoBack());
      },
      expect: [
        AppState.initial(),
        AppState.loaded(pageNum: 1, sportsType: SportsType.Basketball),
      ],
    );

    blocTest(
      'emits [Loaded] with the  pageNum of 0 if a pageNum of 2 is used when called',
      build: () {
        return AppBloc();
      },
      act: (bloc) {
        bloc.add(GetPage(pageNum: 2, sportsType: SportsType.Basketball));
        return bloc.add(GoBack());
      },
      expect: [
        AppState.initial(),
        AppState.loaded(pageNum: 2, sportsType: SportsType.Basketball),
        AppState.loaded(pageNum: 0, sportsType: SportsType.Basketball),
      ],
    );
  });

  group('GoToMessages', () {
    blocTest(
      'emits [LoadedMessages] when called with no filters',
      build: () {
        return AppBloc();
      },
      act: (bloc) => bloc.add(GoToMessages(
          pageNum: 0, filtedByGuid: null, filterBySportsType: null)),
      expect: [
        AppState.initial(),
        AppState.loadedMessages(
            pageNum: 0, filtedByGuid: null, filterBySportsType: null)
      ],
    );

    blocTest(
      'emits [LoadedMessages] with filter parameters when called with filters',
      build: () {
        return AppBloc();
      },
      act: (bloc) => bloc.add(GoToMessages(
          pageNum: 0,
          filtedByGuid: 'Joe',
          filterBySportsType: SportsType.Basketball)),
      expect: [
        AppState.initial(),
        AppState.loadedMessages(
            pageNum: 0,
            filtedByGuid: 'Joe',
            filterBySportsType: SportsType.Basketball)
      ],
    );
  });
}
