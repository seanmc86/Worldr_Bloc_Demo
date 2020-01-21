// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_state.dart';

// **************************************************************************
// SuperEnumGenerator
// **************************************************************************

@immutable
abstract class MessageState extends Equatable {
  const MessageState(this._type);

  factory MessageState.initial() = Initial;

  factory MessageState.loading() = Loading;

  factory MessageState.loaded({@required Messages messages}) = Loaded;

  factory MessageState.error({@required String message}) = Error;

  final _MessageState _type;

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
      case _MessageState.Initial:
        return initial(this as Initial);
      case _MessageState.Loading:
        return loading(this as Loading);
      case _MessageState.Loaded:
        return loaded(this as Loaded);
      case _MessageState.Error:
        return error(this as Error);
    }
  }

  FutureOr<R> whenOrElse<R>(
      {FutureOr<R> Function(Initial) initial,
      FutureOr<R> Function(Loading) loading,
      FutureOr<R> Function(Loaded) loaded,
      FutureOr<R> Function(Error) error,
      @required FutureOr<R> Function(MessageState) orElse}) {
    assert(() {
      if (orElse == null) throw 'Missing orElse case';
      return true;
    }());
    switch (this._type) {
      case _MessageState.Initial:
        if (initial == null) break;
        return initial(this as Initial);
      case _MessageState.Loading:
        if (loading == null) break;
        return loading(this as Loading);
      case _MessageState.Loaded:
        if (loaded == null) break;
        return loaded(this as Loaded);
      case _MessageState.Error:
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
      case _MessageState.Initial:
        if (initial == null) break;
        return initial(this as Initial);
      case _MessageState.Loading:
        if (loading == null) break;
        return loading(this as Loading);
      case _MessageState.Loaded:
        if (loaded == null) break;
        return loaded(this as Loaded);
      case _MessageState.Error:
        if (error == null) break;
        return error(this as Error);
    }
  }

  @override
  List get props => const [];
}

@immutable
class Initial extends MessageState {
  const Initial._() : super(_MessageState.Initial);

  factory Initial() {
    _instance ??= Initial._();
    return _instance;
  }

  static Initial _instance;
}

@immutable
class Loading extends MessageState {
  const Loading._() : super(_MessageState.Loading);

  factory Loading() {
    _instance ??= Loading._();
    return _instance;
  }

  static Loading _instance;
}

@immutable
class Loaded extends MessageState {
  const Loaded({@required this.messages}) : super(_MessageState.Loaded);

  final Messages messages;

  @override
  String toString() => 'Loaded(messages:${this.messages})';
  @override
  List get props => [messages];
}

@immutable
class Error extends MessageState {
  const Error({@required this.message}) : super(_MessageState.Error);

  final String message;

  @override
  String toString() => 'Error(message:${this.message})';
  @override
  List get props => [message];
}
