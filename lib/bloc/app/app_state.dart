import 'package:super_enum/super_enum.dart';
import 'package:worldr_task/entity/person/person.dart';

part 'app_state.g.dart';

@superEnum
enum _AppState {
  @object
  Initial,
  @Data(
      fields: [DataField('pageNum', int), DataField('sportsType', SportsType)])
  Loaded,
  @Data(fields: [
    DataField('pageNum', int),
    DataField('filtedByGuid', String),
    DataField('filterBySportsType', SportsType)
  ])
  LoadedMessages
}
