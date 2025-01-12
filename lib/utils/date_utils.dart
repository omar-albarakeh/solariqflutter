
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

String formatDate(DateTime dateTime) {
  return "${dateTime.day.toString().padLeft(2, '0')}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.year}";
}

