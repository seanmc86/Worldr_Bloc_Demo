// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person_state.dart';

// **************************************************************************
// SuperEnumGenerator
// **************************************************************************

@immutable
abstract class PersonState extends Equatable {
  const PersonState(this._type);

  factory PersonState.initial() = Initial;

  factory PersonState.loading() = Loading;

  factory PersonState.loaded(
      {@required Persons persons, @required SportsType sportsType}) = Loaded;

  factory PersonState.error({@required String message}) = Error;

  final _PersonState _type;

//ignore: missing_return
  FutureOr<R> when<R>(
      {@required FutureOr<R> Function(Initial) initial,
      @required FutureOr<R> Function(Loading) loading,
      @required FutureOr<R> Function(Loaded) loaded,
      @required FutureOr<R> Function(Error) error}) {
    assert(() {
      if (initial == null || loading == null || loaded == null || error == null)
        throw 'check for all possible cases';
      return true;
    }());
    switch (this._type) {
      case _PersonState.Initial:
        return initial(this as Initial);
      case _PersonState.Loading:
        return loading(this as Loading);
      case _PersonState.Loaded:
        return loaded(this as Loaded);
      case _PersonState.Error:
        return error(this as Error);
    }
  }

  FutureOr<R> whenOrElse<R>(
      {FutureOr<R> Function(Initial) initial,
      FutureOr<R> Function(Loading) loading,
      FutureOr<R> Function(Loaded) loaded,
      FutureOr<R> Function(Error) error,
      @required FutureOr<R> Function(PersonState) orElse}) {
    assert(() {
      if (orElse == null) throw 'Missing orElse case';
      return true;
    }());
    switch (this._type) {
      case _PersonState.Initial:
        if (initial == null) break;
        return initial(this as Initial);
      case _PersonState.Loading:
        if (loading == null) break;
        return loading(this as Loading);
      case _PersonState.Loaded:
        if (loaded == null) break;
        return loaded(this as Loaded);
      case _PersonState.Error:
        if (error == null) break;
        return error(this as Error);
    }
    return orElse(this);
  }

  FutureOr<void> whenPartial(
      {FutureOr<void> Function(Initial) initial,
      FutureOr<void> Function(Loading) loading,
      FutureOr<void> Function(Loaded) loaded,
      FutureOr<void> Function(Error) error}) {
    assert(() {
      if (initial == null && loading == null && loaded == null && error == null)
        throw 'provide at least one branch';
      return true;
    }());
    switch (this._type) {
      case _PersonState.Initial:
        if (initial == null) break;
        return initial(this as Initial);
      case _PersonState.Loading:
        if (loading == null) break;
        return loading(this as Loading);
      case _PersonState.Loaded:
        if (loaded == null) break;
        return loaded(this as Loaded);
      case _PersonState.Error:
        if (error == null) break;
        return error(this as Error);
    }
  }

  @override
  List get props => const [];
}

@immutable
class Initial extends PersonState {
  const Initial._() : super(_PersonState.Initial);

  factory Initial() {
    _instance ??= Initial._();
    return _instance;
  }

  static Initial _instance;
}

@immutable
class Loading extends PersonState {
  const Loading._() : super(_PersonState.Loading);

  factory Loading() {
    _instance ??= Loading._();
    return _instance;
  }

  static Loading _instance;
}

@immutable
class Loaded extends PersonState {
  const Loaded({@required this.persons, @required this.sportsType})
      : super(_PersonState.Loaded);

  final Persons persons;

  final SportsType sportsType;

  @override
  String toString() =>
      'Loaded(persons:${this.persons},sportsType:${this.sportsType})';
  @override
  List get props => [persons, sportsType];
}

@immutable
class Error extends PersonState {
  const Error({@required this.message}) : super(_PersonState.Error);

  final String message;

  @override
  String toString() => 'Error(message:${this.message})';
  @override
  List get props => [message];
}
