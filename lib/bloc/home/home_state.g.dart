// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_state.dart';

// **************************************************************************
// SuperEnumGenerator
// **************************************************************************

@immutable
abstract class HomeState extends Equatable {
  const HomeState(this._type);

  factory HomeState.initial() = Initial;

  factory HomeState.loaded({@required Counts counts}) = Loaded;

  factory HomeState.error({@required String message}) = Error;

  final _HomeState _type;

//ignore: missing_return
  FutureOr<R> when<R>(
      {@required FutureOr<R> Function(Initial) initial,
      @required FutureOr<R> Function(Loaded) loaded,
      @required FutureOr<R> Function(Error) error}) {
    assert(() {
      if (initial == null || loaded == null || error == null)
        throw 'check for all possible cases';
      return true;
    }());
    switch (this._type) {
      case _HomeState.Initial:
        return initial(this as Initial);
      case _HomeState.Loaded:
        return loaded(this as Loaded);
      case _HomeState.Error:
        return error(this as Error);
    }
  }

  FutureOr<R> whenOrElse<R>(
      {FutureOr<R> Function(Initial) initial,
      FutureOr<R> Function(Loaded) loaded,
      FutureOr<R> Function(Error) error,
      @required FutureOr<R> Function(HomeState) orElse}) {
    assert(() {
      if (orElse == null) throw 'Missing orElse case';
      return true;
    }());
    switch (this._type) {
      case _HomeState.Initial:
        if (initial == null) break;
        return initial(this as Initial);
      case _HomeState.Loaded:
        if (loaded == null) break;
        return loaded(this as Loaded);
      case _HomeState.Error:
        if (error == null) break;
        return error(this as Error);
    }
    return orElse(this);
  }

  FutureOr<void> whenPartial(
      {FutureOr<void> Function(Initial) initial,
      FutureOr<void> Function(Loaded) loaded,
      FutureOr<void> Function(Error) error}) {
    assert(() {
      if (initial == null && loaded == null && error == null)
        throw 'provide at least one branch';
      return true;
    }());
    switch (this._type) {
      case _HomeState.Initial:
        if (initial == null) break;
        return initial(this as Initial);
      case _HomeState.Loaded:
        if (loaded == null) break;
        return loaded(this as Loaded);
      case _HomeState.Error:
        if (error == null) break;
        return error(this as Error);
    }
  }

  @override
  List get props => const [];
}

@immutable
class Initial extends HomeState {
  const Initial._() : super(_HomeState.Initial);

  factory Initial() {
    _instance ??= Initial._();
    return _instance;
  }

  static Initial _instance;
}

@immutable
class Loaded extends HomeState {
  const Loaded({@required this.counts}) : super(_HomeState.Loaded);

  final Counts counts;

  @override
  String toString() => 'Loaded(counts:${this.counts})';
  @override
  List get props => [counts];
}

@immutable
class Error extends HomeState {
  const Error({@required this.message}) : super(_HomeState.Error);

  final String message;

  @override
  String toString() => 'Error(message:${this.message})';
  @override
  List get props => [message];
}
