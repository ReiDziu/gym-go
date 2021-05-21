class Exercise {
  Exercise({
    this.title,
    this.gifPath,
    this.duration,
    this.count,
    this.interval,
    this.amount,
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

class DateTimeUtils {
  static String convertTimerTime(Duration time) {
    final int hours = time.inHours.remainder(Duration.hoursPerDay);
    final int minutes = time.inMinutes.remainder(Duration.minutesPerHour);
    final int seconds = time.inSeconds.remainder(Duration.secondsPerMinute);

    final StringBuffer stringBuffer = StringBuffer();

    if (hours > 0) {
      stringBuffer.write(hours);
      stringBuffer.write(':');
    }

    stringBuffer.write(_twoDigits(minutes));
    stringBuffer.write(':');

    stringBuffer.write(_twoDigits(seconds));

    return stringBuffer.toString();
  }

  static String convertClockTime(DateTime time) {
    final int hours = time.hour;
    final int minutes = time.minute;
    final int seconds = time.second;

    final StringBuffer stringBuffer = StringBuffer();

    stringBuffer.write(_twoDigits(hours));
    stringBuffer.write(':');

    stringBuffer.write(_twoDigits(minutes));
    stringBuffer.write(':');

    stringBuffer.write(_twoDigits(seconds));

    return stringBuffer.toString();
  }

  static String convertCalendarDate(DateTime date) {
    final int day = date.day;
    final int month = date.month;
    final int year = date.year;

    final StringBuffer stringBuffer = StringBuffer();

    stringBuffer.write(_twoDigits(day));
    stringBuffer.write('.');

    stringBuffer.write(_twoDigits(month));
    stringBuffer.write('.');

    stringBuffer.write(year);

    return stringBuffer.toString();
  }

  static String _twoDigits(int value) => value < 10 ? '0$value' : '$value';
}
