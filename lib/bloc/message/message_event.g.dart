// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message_event.dart';

// **************************************************************************
// SuperEnumGenerator
// **************************************************************************

@immutable
abstract class MessageEvent extends Equatable {
  const MessageEvent(this._type);

  factory MessageEvent.getMessages(
      {@required String guid, @required SportsType sportsType}) = GetMessages;

  factory MessageEvent.messageOpened({@required Message message}) =
      MessageOpened;

  final _MessageEvent _type;

//ignore: missing_return
  FutureOr<R> when<R>(
      {@required FutureOr<R> Function(GetMessages) getMessages,
      @required FutureOr<R> Function(MessageOpened) messageOpened}) {
    assert(() {
      if (getMessages == null || messageOpened == null)
        throw 'check for all possible cases';
      return true;
    }());
    switch (this._type) {
      case _MessageEvent.GetMessages:
        return getMessages(this as GetMessages);
      case _MessageEvent.MessageOpened:
        return messageOpened(this as MessageOpened);
    }
  }

  FutureOr<R> whenOrElse<R>(
      {FutureOr<R> Function(GetMessages) getMessages,
      FutureOr<R> Function(MessageOpened) messageOpened,
      @required FutureOr<R> Function(MessageEvent) orElse}) {
    assert(() {
      if (orElse == null) throw 'Missing orElse case';
      return true;
    }());
    switch (this._type) {
      case _MessageEvent.GetMessages:
        if (getMessages == null) break;
        return getMessages(this as GetMessages);
      case _MessageEvent.MessageOpened:
        if (messageOpened == null) break;
        return messageOpened(this as MessageOpened);
    }
    return orElse(this);
  }

  FutureOr<void> whenPartial(
      {FutureOr<void> Function(GetMessages) getMessages,
      FutureOr<void> Function(MessageOpened) messageOpened}) {
    assert(() {
      if (getMessages == null && messageOpened == null)
        throw 'provide at least one branch';
      return true;
    }());
    switch (this._type) {
      case _MessageEvent.GetMessages:
        if (getMessages == null) break;
        return getMessages(this as GetMessages);
      case _MessageEvent.MessageOpened:
        if (messageOpened == null) break;
        return messageOpened(this as MessageOpened);
    }
  }

  @override
  List get props => const [];
}

@immutable
class GetMessages extends MessageEvent {
  const GetMessages({@required this.guid, @required this.sportsType})
      : super(_MessageEvent.GetMessages);

  final String guid;

  final SportsType sportsType;

  @override
  String toString() =>
      'GetMessages(guid:${this.guid},sportsType:${this.sportsType})';
  @override
  List get props => [guid, sportsType];
}

@immutable
class MessageOpened extends MessageEvent {
  const MessageOpened({@required this.message})
      : super(_MessageEvent.MessageOpened);

  final Message message;

  @override
  String toString() => 'MessageOpened(message:${this.message})';
  @override
  List get props => [message];
}
