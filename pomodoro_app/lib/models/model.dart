class PomodoroType {
  late final int id;
  final String? typeLabel;
  final int? timeInMinutes;
  final bool? isReverse;
  PomodoroType({
    required this.id,
    required this.typeLabel,
    required this.timeInMinutes,
    required this.isReverse,
  });
}
