import 'package:super_enum/super_enum.dart';
import 'package:worldr_task/entity/person/person.dart';

part 'person_state.g.dart';

@superEnum
enum _PersonState {
  @object
  Initial,
  @object
  Loading,
  @Data(fields: [
    DataField('persons', Persons),
    DataField('sportsType', SportsType),
  ])
  Loaded,
  @Data(fields: [
    DataField('message', String),
  ])
  Error,
}
