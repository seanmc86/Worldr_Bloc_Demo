import 'package:super_enum/super_enum.dart';
import 'package:worldr_task/entity/message.dart';

part 'message_state.g.dart';

@superEnum
enum _MessageState {
  @object
  Initial,
  @object
  Loading,
  @Data(fields: [
    DataField('messages', Messages),
  ])
  Loaded,
  @Data(fields: [
    DataField('message', String),
  ])
  Error,
}
