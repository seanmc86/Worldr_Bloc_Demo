// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_event.dart';

// **************************************************************************
// SuperEnumGenerator
// **************************************************************************

@immutable
abstract class AppEvent extends Equatable {
  const AppEvent(this._type);

  factory AppEvent.getPage(
      {@required int pageNum, @required SportsType sportsType}) = GetPage;

  factory AppEvent.goBack() = GoBack;

  factory AppEvent.goToMessages(
      {@required int pageNum,
      @required String filtedByGuid,
      @required SportsType filterBySportsType}) = GoToMessages;

  final _AppEvent _type;

//ignore: missing_return
  FutureOr<R> when<R>(
      {@required FutureOr<R> Function(GetPage) getPage,
      @required FutureOr<R> Function(GoBack) goBack,
      @required FutureOr<R> Function(GoToMessages) goToMessages}) {
    assert(() {
      if (getPage == null || goBack == null || goToMessages == null)
        throw 'check for all possible cases';
      return true;
    }());
    switch (this._type) {
      case _AppEvent.GetPage:
        return getPage(this as GetPage);
      case _AppEvent.GoBack:
        return goBack(this as GoBack);
      case _AppEvent.GoToMessages:
        return goToMessages(this as GoToMessages);
    }
  }

  FutureOr<R> whenOrElse<R>(
      {FutureOr<R> Function(GetPage) getPage,
      FutureOr<R> Function(GoBack) goBack,
      FutureOr<R> Function(GoToMessages) goToMessages,
      @required FutureOr<R> Function(AppEvent) orElse}) {
    assert(() {
      if (orElse == null) throw 'Missing orElse case';
      return true;
    }());
    switch (this._type) {
      case _AppEvent.GetPage:
        if (getPage == null) break;
        return getPage(this as GetPage);
      case _AppEvent.GoBack:
        if (goBack == null) break;
        return goBack(this as GoBack);
      case _AppEvent.GoToMessages:
        if (goToMessages == null) break;
        return goToMessages(this as GoToMessages);
    }
    return orElse(this);
  }

  FutureOr<void> whenPartial(
      {FutureOr<void> Function(GetPage) getPage,
      FutureOr<void> Function(GoBack) goBack,
      FutureOr<void> Function(GoToMessages) goToMessages}) {
    assert(() {
      if (getPage == null && goBack == null && goToMessages == null)
        throw 'provide at least one branch';
      return true;
    }());
    switch (this._type) {
      case _AppEvent.GetPage:
        if (getPage == null) break;
        return getPage(this as GetPage);
      case _AppEvent.GoBack:
        if (goBack == null) break;
        return goBack(this as GoBack);
      case _AppEvent.GoToMessages:
        if (goToMessages == null) break;
        return goToMessages(this as GoToMessages);
    }
  }

  @override
  List get props => const [];
}

@immutable
class GetPage extends AppEvent {
  const GetPage({@required this.pageNum, @required this.sportsType})
      : super(_AppEvent.GetPage);

  final int pageNum;

  final SportsType sportsType;

  @override
  String toString() =>
      'GetPage(pageNum:${this.pageNum},sportsType:${this.sportsType})';
  @override
  List get props => [pageNum, sportsType];
}

@immutable
class GoBack extends AppEvent {
  const GoBack._() : super(_AppEvent.GoBack);

  factory GoBack() {
    _instance ??= GoBack._();
    return _instance;
  }

  static GoBack _instance;
}

@immutable
class GoToMessages extends AppEvent {
  const GoToMessages(
      {@required this.pageNum,
      @required this.filtedByGuid,
      @required this.filterBySportsType})
      : super(_AppEvent.GoToMessages);

  final int pageNum;

  final String filtedByGuid;

  final SportsType filterBySportsType;

  @override
  String toString() =>
      'GoToMessages(pageNum:${this.pageNum},filtedByGuid:${this.filtedByGuid},filterBySportsType:${this.filterBySportsType})';
  @override
  List get props => [pageNum, filtedByGuid, filterBySportsType];
}
