import 'package:equatable/equatable.dart';
import 'package:super_enum/super_enum.dart';
import 'package:worldr_task/entity/message.dart';
import 'package:worldr_task/entity/person/person.dart';

part 'message_event.g.dart';

@superEnum
enum _MessageEvent {
  @Data(
      fields: [DataField('guid', String), DataField('sportsType', SportsType)])
  GetMessages,
  @Data(fields: [DataField('message', Message)])
  MessageOpened,
}
