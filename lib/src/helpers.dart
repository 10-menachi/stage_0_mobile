import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:stage_0_mobile/src/settings/riverpod/providers/todos/done_todos_count_provider.dart';
import 'package:stage_0_mobile/src/settings/riverpod/providers/todos/todos_count_provider.dart';
import 'package:stage_0_mobile/src/settings/riverpod/providers/todos/todos_provider.dart';
import 'package:stage_0_mobile/src/settings/riverpod/providers/todos/undone_todos_count_provider.dart';

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

String formatTimeOfDay(TimeOfDay t) {
  final now = DateTime.now();
  final dt = DateTime(now.year, now.month, now.day, t.hour, t.minute);
  return DateFormat('hh:mm a').format(dt);
}

String truncateText(String text, {int max = 6}) {
  return text.length > max ? '${text.substring(0, max)}...' : text;
}

String formatTodoDateTime({
  required DateTime date,
  required DateTime start,
  required DateTime end,
}) {
  final now = DateTime.now();

  final today = DateTime(now.year, now.month, now.day);
  final todoDay = DateTime(date.year, date.month, date.day);

  final difference = todoDay.difference(today).inDays;

  String dayLabel;

  switch (difference) {
    case 0:
      dayLabel = 'Today';
      break;
    case 1:
      dayLabel = 'Tomorrow';
      break;
    case -1:
      dayLabel = 'Yesterday';
      break;
    default:
      if (difference > 1 && difference <= 7) {
        dayLabel = 'In $difference days';
      } else if (difference < -1 && difference >= -7) {
        dayLabel = '${difference.abs()} days ago';
      } else {
        dayLabel = DateFormat('EEE, d MMM').format(date);
      }
  }

  final startTime = formatTime(start);
  final endTime = formatTime(end);

  return '$dayLabel • $startTime → $endTime';
}

void invalidateProviders(WidgetRef ref) {
  ref.invalidate(todosCountProvider);
  ref.invalidate(todosProvider);
  ref.invalidate(todosDoneCountProvider);
  ref.invalidate(todosLeftCountProvider);
}
