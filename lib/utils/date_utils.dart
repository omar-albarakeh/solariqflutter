
String formatDayOfWeek(DateTime dateTime) {
  return [
    'Sunday',
    'Monday',
    'Tuesday',
    'Wednesday',
    'Thursday',
    'Friday',
    'Saturday'
  ][dateTime.weekday - 1];
}

