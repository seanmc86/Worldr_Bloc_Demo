import 'package:equatable/equatable.dart';
import 'package:super_enum/super_enum.dart';

part 'home_event.g.dart';

@superEnum
enum _HomeEvent {
  @object
  CreateNewMessage,
  @object
  GetUnreadMessages
}
