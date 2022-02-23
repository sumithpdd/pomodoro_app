import '../helpers/app_constants.dart';
import '../models/model.dart';

List<PomodoroType> pomodoroData = [
  PomodoroType(1, typeLabel: kWorkLabel, timeInMinutes: 25, isReverse: true),
  PomodoroType(2,
      typeLabel: kLongBreakLabel, timeInMinutes: 10, isReverse: true),
  PomodoroType(3,
      typeLabel: kShortBreakLabel, timeInMinutes: 5, isReverse: true),
  PomodoroType(4, typeLabel: k3minLabel, timeInMinutes: 3, isReverse: true),
  PomodoroType(5, typeLabel: k1minLabel, timeInMinutes: 1, isReverse: true),
];
