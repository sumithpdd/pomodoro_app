import 'package:realm/realm.dart';
part 'model.g.dart';

@RealmModel()
class _PomodoroType {
  @PrimaryKey()
  late final int id;
  String? typeLabel;
  int? timeInMinutes;
  bool? isReverse;
//  PomodoroType({
//     required this.id,
//     required this.typeLabel,
//     required this.timeInMinutes,
//     required this.isReverse,
//   });
}

@RealmModel()
class _UserRunHistory {
  late final int id;
  _PomodoroType? pomodoroType;
  int? stopTimeInMinutes;
  // DateTime? updatedTime;
  late int updatedTime; // no DateTime yet (stay tuned)
}
