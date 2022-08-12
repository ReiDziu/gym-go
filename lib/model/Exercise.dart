class Exercise {
  Exercise({
    required this.title,
    required this.gifPath,
    required this.duration,
    required this.count,
    required this.interval,
    required this.amount,
  });

  String title;
  String gifPath;
  Duration duration;
  int count;
  Duration interval;
  int amount;

  String get time => duration.inMinutes.toString();

  String get rest => interval.inMinutes.toString();
}
