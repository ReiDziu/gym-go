// ignore_for_file: avoid_classes_with_only_static_members

class DateTimeUtility {
  static String convertTimerTime(Duration time) {
    final int hours = time.inHours.remainder(Duration.hoursPerDay);
    final int minutes = time.inMinutes.remainder(Duration.minutesPerHour);
    final int seconds = time.inSeconds.remainder(Duration.secondsPerMinute);

    final StringBuffer stringBuffer = StringBuffer();

    if (hours > 0) {
      stringBuffer
        ..write(hours)
        ..write(':');
    }

    stringBuffer
      ..write(_twoDigits(minutes))
      ..write(':')
      ..write(_twoDigits(seconds));

    return stringBuffer.toString();
  }

  static String convertClockTime(DateTime time) {
    final int hours = time.hour;
    final int minutes = time.minute;
    final int seconds = time.second;

    final StringBuffer stringBuffer = StringBuffer()
      ..write(_twoDigits(hours))
      ..write(':')
      ..write(_twoDigits(minutes))
      ..write(':')
      ..write(_twoDigits(seconds));

    return stringBuffer.toString();
  }

  static String convertCalendarDate(DateTime date) {
    final int day = date.day;
    final int month = date.month;
    final int year = date.year;

    final StringBuffer stringBuffer = StringBuffer()
      ..write(_twoDigits(day))
      ..write('.')
      ..write(_twoDigits(month))
      ..write('.')
      ..write(year);

    return stringBuffer.toString();
  }

  static String _twoDigits(int value) => value < 10 ? '0$value' : '$value';
}
