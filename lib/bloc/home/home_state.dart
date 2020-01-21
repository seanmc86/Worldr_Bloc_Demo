import 'package:super_enum/super_enum.dart';
import 'package:worldr_task/entity/counts.dart';

part 'home_state.g.dart';

@superEnum
enum _HomeState {
  @object
  Initial,
  @Data(fields: [
    DataField('counts', Counts),
  ])
  Loaded,
  @Data(fields: [
    DataField('message', String),
  ])
  Error,
}
