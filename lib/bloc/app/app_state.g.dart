// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_state.dart';

// **************************************************************************
// SuperEnumGenerator
// **************************************************************************

@immutable
abstract class AppState extends Equatable {
  const AppState(this._type);

  factory AppState.initial() = Initial;

  factory AppState.loaded(
      {@required int pageNum, @required SportsType sportsType}) = Loaded;

  factory AppState.loadedMessages(
      {@required int pageNum,
      @required String filtedByGuid,
      @required SportsType filterBySportsType}) = LoadedMessages;

  final _AppState _type;

//ignore: missing_return
  FutureOr<R> when<R>(
      {@required FutureOr<R> Function(Initial) initial,
      @required FutureOr<R> Function(Loaded) loaded,
      @required FutureOr<R> Function(LoadedMessages) loadedMessages}) {
    assert(() {
      if (initial == null || loaded == null || loadedMessages == null)
        throw 'check for all possible cases';
      return true;
    }());
    switch (this._type) {
      case _AppState.Initial:
        return initial(this as Initial);
      case _AppState.Loaded:
        return loaded(this as Loaded);
      case _AppState.LoadedMessages:
        return loadedMessages(this as LoadedMessages);
    }
  }

  FutureOr<R> whenOrElse<R>(
      {FutureOr<R> Function(Initial) initial,
      FutureOr<R> Function(Loaded) loaded,
      FutureOr<R> Function(LoadedMessages) loadedMessages,
      @required FutureOr<R> Function(AppState) orElse}) {
    assert(() {
      if (orElse == null) throw 'Missing orElse case';
      return true;
    }());
    switch (this._type) {
      case _AppState.Initial:
        if (initial == null) break;
        return initial(this as Initial);
      case _AppState.Loaded:
        if (loaded == null) break;
        return loaded(this as Loaded);
      case _AppState.LoadedMessages:
        if (loadedMessages == null) break;
        return loadedMessages(this as LoadedMessages);
    }
    return orElse(this);
  }

  FutureOr<void> whenPartial(
      {FutureOr<void> Function(Initial) initial,
      FutureOr<void> Function(Loaded) loaded,
      FutureOr<void> Function(LoadedMessages) loadedMessages}) {
    assert(() {
      if (initial == null && loaded == null && loadedMessages == null)
        throw 'provide at least one branch';
      return true;
    }());
    switch (this._type) {
      case _AppState.Initial:
        if (initial == null) break;
        return initial(this as Initial);
      case _AppState.Loaded:
        if (loaded == null) break;
        return loaded(this as Loaded);
      case _AppState.LoadedMessages:
        if (loadedMessages == null) break;
        return loadedMessages(this as LoadedMessages);
    }
  }

  @override
  List get props => const [];
}

@immutable
class Initial extends AppState {
  const Initial._() : super(_AppState.Initial);

  factory Initial() {
    _instance ??= Initial._();
    return _instance;
  }

  static Initial _instance;
}

@immutable
class Loaded extends AppState {
  const Loaded({@required this.pageNum, @required this.sportsType})
      : super(_AppState.Loaded);

  final int pageNum;

  final SportsType sportsType;

  @override
  String toString() =>
      'Loaded(pageNum:${this.pageNum},sportsType:${this.sportsType})';
  @override
  List get props => [pageNum, sportsType];
}

@immutable
class LoadedMessages extends AppState {
  const LoadedMessages(
      {@required this.pageNum,
      @required this.filtedByGuid,
      @required this.filterBySportsType})
      : super(_AppState.LoadedMessages);

  final int pageNum;

  final String filtedByGuid;

  final SportsType filterBySportsType;

  @override
  String toString() =>
      'LoadedMessages(pageNum:${this.pageNum},filtedByGuid:${this.filtedByGuid},filterBySportsType:${this.filterBySportsType})';
  @override
  List get props => [pageNum, filtedByGuid, filterBySportsType];
}
