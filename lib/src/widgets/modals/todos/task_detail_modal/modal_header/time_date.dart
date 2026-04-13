import 'package:flutter/material.dart';
import 'package:stage_0_mobile/src/database.dart';
import 'package:stage_0_mobile/src/helpers.dart';
import 'package:stage_0_mobile/src/widgets/modals/todos/task_detail_modal/modal_header/header_chip.dart';

class TimeDate extends StatelessWidget {
  const TimeDate({super.key, required this.todo});

  final TodoItem todo;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        HeaderChip(
          icon: Icons.access_time,
          label: '${formatTime(todo.startTime)} – ${formatTime(todo.endTime)}',
        ),
        const SizedBox(width: 10),
        HeaderChip(
          icon: Icons.calendar_today_outlined,
          label: formatDate(todo.date),
        ),
      ],
    );
  }
}
