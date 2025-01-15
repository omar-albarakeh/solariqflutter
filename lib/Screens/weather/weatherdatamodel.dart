class WeatherDataModel {
  final Map<String, dynamic> currentWeather;
  final List<Map<String, dynamic>> fiveDayForecast;
  final List<Map<String, dynamic>> solarRadiationData;

  WeatherDataModel({
    required this.currentWeather,
    required this.fiveDayForecast,
    required this.solarRadiationData,
  });

  String formatTimestamp(int? timestamp) {
    if (timestamp == null) return 'N/A';
    final dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return "${_formatDayOfWeek(dateTime)}, ${_formatDate(dateTime)} at ${_formatTime(dateTime)}";
  }

  String _formatDayOfWeek(DateTime dateTime) {
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

  String _formatDate(DateTime dateTime) {
    return "${dateTime.day.toString().padLeft(2, '0')}-${dateTime.month.toString().padLeft(2, '0')}-${dateTime.year}";
  }

  String _formatTime(DateTime dateTime) {
    final hour = dateTime.hour.toString().padLeft(2, '0');
    final minute = dateTime.minute.toString().padLeft(2, '0');
    return "$hour:$minute";
  }
}