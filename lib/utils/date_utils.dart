
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

String formatTime(DateTime dateTime) {
  final hour = dateTime.hour.toString().padLeft(2, '0');
  final minute = dateTime.minute.toString().padLeft(2, '0');
  return "$hour:$minute";
}
String formatTimestamp(int? timestamp) {
  if (timestamp == null) return 'N/A';
  final dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  return "${formatDayOfWeek(dateTime)}, ${formatDate(dateTime)} at ${formatTime(dateTime)}";
}
