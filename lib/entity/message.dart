import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:worldr_task/entity/person/person.dart';

part 'message.g.dart';

@HiveType(typeId: 2)
class Message extends HiveObject {
  @HiveField(0)
  final String personGuid;
  @HiveField(1)
  final String content;
  @HiveField(2)
  bool isRead = false;
  @HiveField(3)
  final SportsType sportsType;

  Message(
      {@required this.personGuid,
      @required this.content,
      @required this.sportsType});

  factory Message.fromFaker(dynamic data) {
    return Message(
        personGuid: data['personGuid'],
        content: data['content'],
        sportsType: data['sportsType']);
  }
}

class Messages extends Equatable {
  final List<Message> results;

  const Messages({@required this.results});

  @override
  List get props => [results];
}
