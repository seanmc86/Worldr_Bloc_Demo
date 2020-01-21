import 'package:equatable/equatable.dart';
import 'package:super_enum/super_enum.dart';
import 'package:worldr_task/entity/person/person.dart';

part 'app_event.g.dart';

@superEnum
enum _AppEvent {
  @Data(
      fields: [DataField('pageNum', int), DataField('sportsType', SportsType)])
  GetPage,
  @object
  GoBack,
  @Data(fields: [
    DataField('pageNum', int),
    DataField('filtedByGuid', String),
    DataField('filterBySportsType', SportsType)
  ])
  GoToMessages
}
