import 'package:equatable/equatable.dart';
import 'package:super_enum/super_enum.dart';
import 'package:worldr_task/entity/person/person.dart';

part 'person_event.g.dart';

@superEnum
enum _PersonEvent {
  @object
  GetPersons,
  @Data(fields: [DataField('sportsType', SportsType)])
  GetPersonsForType,
}
