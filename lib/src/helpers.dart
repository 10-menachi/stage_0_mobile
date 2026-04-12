import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final List<Color> priorityColorOptions = const [
  Color(0xFF7B6EF6),
  Color(0xFF2196F3),
  Color(0xFF10B981),
  Color(0xFFD6755B),
  Color(0xFFF59E0B),
  Color(0xFFEC4899),
];

DateTime combineDateAndTime(DateTime date, TimeOfDay time) {
  return DateTime(date.year, date.month, date.day, time.hour, time.minute);
}

Color parseColor(String colorString) {
  final hex = colorString.replaceAll('Color(', '').replaceAll(')', '');

  return Color(int.parse(hex));
}

String formatDate(DateTime dateTime) {
  return DateFormat('EEE, d MMM yyyy').format(dateTime);
}

String formatTime(DateTime dateTime) {
  return DateFormat('h:mm a').format(dateTime);
}
