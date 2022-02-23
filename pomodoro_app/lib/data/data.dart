import '../helpers/app_constants.dart';
import '../models/model.dart';

List<PomodoroType> pomodoroData = [
  PomodoroType(
      id: 1, typeLabel: kWorkLabel, timeInMinutes: 25, isReverse: true),
  PomodoroType(
      id: 2, typeLabel: kLongBreakLabel, timeInMinutes: 10, isReverse: true),
  PomodoroType(
      id: 3, typeLabel: kShortBreakLabel, timeInMinutes: 5, isReverse: true),
  PomodoroType(id: 4, typeLabel: k3minLabel, timeInMinutes: 3, isReverse: true),
  PomodoroType(id: 5, typeLabel: k1minLabel, timeInMinutes: 1, isReverse: true),
];
