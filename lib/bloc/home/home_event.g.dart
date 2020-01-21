// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_event.dart';

// **************************************************************************
// SuperEnumGenerator
// **************************************************************************

@immutable
abstract class HomeEvent extends Equatable {
  const HomeEvent(this._type);

  factory HomeEvent.createNewMessage() = CreateNewMessage;

  factory HomeEvent.getUnreadMessages() = GetUnreadMessages;

  final _HomeEvent _type;

//ignore: missing_return
  FutureOr<R> when<R>(
      {@required FutureOr<R> Function(CreateNewMessage) createNewMessage,
      @required FutureOr<R> Function(GetUnreadMessages) getUnreadMessages}) {
    assert(() {
      if (createNewMessage == null || getUnreadMessages == null)
        throw 'check for all possible cases';
      return true;
    }());
    switch (this._type) {
      case _HomeEvent.CreateNewMessage:
        return createNewMessage(this as CreateNewMessage);
      case _HomeEvent.GetUnreadMessages:
        return getUnreadMessages(this as GetUnreadMessages);
    }
  }

  FutureOr<R> whenOrElse<R>(
      {FutureOr<R> Function(CreateNewMessage) createNewMessage,
      FutureOr<R> Function(GetUnreadMessages) getUnreadMessages,
      @required FutureOr<R> Function(HomeEvent) orElse}) {
    assert(() {
      if (orElse == null) throw 'Missing orElse case';
      return true;
    }());
    switch (this._type) {
      case _HomeEvent.CreateNewMessage:
        if (createNewMessage == null) break;
        return createNewMessage(this as CreateNewMessage);
      case _HomeEvent.GetUnreadMessages:
        if (getUnreadMessages == null) break;
        return getUnreadMessages(this as GetUnreadMessages);
    }
    return orElse(this);
  }

  FutureOr<void> whenPartial(
      {FutureOr<void> Function(CreateNewMessage) createNewMessage,
      FutureOr<void> Function(GetUnreadMessages) getUnreadMessages}) {
    assert(() {
      if (createNewMessage == null && getUnreadMessages == null)
        throw 'provide at least one branch';
      return true;
    }());
    switch (this._type) {
      case _HomeEvent.CreateNewMessage:
        if (createNewMessage == null) break;
        return createNewMessage(this as CreateNewMessage);
      case _HomeEvent.GetUnreadMessages:
        if (getUnreadMessages == null) break;
        return getUnreadMessages(this as GetUnreadMessages);
    }
  }

  @override
  List get props => const [];
}

@immutable
class CreateNewMessage extends HomeEvent {
  const CreateNewMessage._() : super(_HomeEvent.CreateNewMessage);

  factory CreateNewMessage() {
    _instance ??= CreateNewMessage._();
    return _instance;
  }

  static CreateNewMessage _instance;
}

@immutable
class GetUnreadMessages extends HomeEvent {
  const GetUnreadMessages._() : super(_HomeEvent.GetUnreadMessages);

  factory GetUnreadMessages() {
    _instance ??= GetUnreadMessages._();
    return _instance;
  }

  static GetUnreadMessages _instance;
}
