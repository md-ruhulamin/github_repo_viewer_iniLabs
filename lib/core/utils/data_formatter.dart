  import 'package:intl/intl.dart';


String formatDate(DateTime date) {
  try {
    final months = [
      'Jan','Feb','Mar','Apr','May','Jun',
      'Jul','Aug','Sep','Oct','Nov','Dec'
    ];
    final twoDigits = (int n) => n.toString().padLeft(2, '0');
    final day = date.day;
    final hour = twoDigits(date.hour);
    final minute = twoDigits(date.minute);
    return '${months[date.month - 1]} $day, ${date.year} $hour:$minute';
  } catch (e, stack) {
    // Log the error if you have a logger
    // print('formatDate error: $e');
    // Provide a safe fallback string
    return '${date.toIso8601String()}';
  }
}