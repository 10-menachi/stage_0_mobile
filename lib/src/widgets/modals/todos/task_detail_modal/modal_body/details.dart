import 'package:flutter/material.dart';
import 'package:stage_0_mobile/src/database.dart';
import 'package:stage_0_mobile/src/helpers.dart';
import 'package:stage_0_mobile/src/widgets/modals/todos/task_detail_modal/modal_details/detail_row.dart';
import 'package:stage_0_mobile/src/widgets/modals/todos/task_detail_modal/modal_details/detail_section_label.dart';
import 'package:stage_0_mobile/src/widgets/shared/custom_divider.dart';

class Details extends StatelessWidget {
  final Color color;
  final TodoItem todo;
  const Details({super.key, required this.color, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const DetailSectionLabel(text: 'Details'),
        const SizedBox(height: 10),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.black12),
          ),
          child: Column(
            children: [
              DetailRow(
                icon: Icons.calendar_today_outlined,
                label: 'Date',
                value: formatDate(todo.date),
                iconColor: color,
              ),
              CustomDivider(),
              DetailRow(
                icon: Icons.schedule_outlined,
                label: 'Start time',
                value: formatTime(todo.startTime),
                iconColor: color,
              ),
              CustomDivider(),
              DetailRow(
                icon: Icons.schedule_outlined,
                label: 'End time',
                value: formatTime(todo.endTime),
                iconColor: color,
              ),
              CustomDivider(),
              DetailRow(
                icon: Icons.label_outline_rounded,
                label: 'Category',
                value: todo.category,
                iconColor: color,
              ),
              CustomDivider(),
              DetailRow(
                icon: Icons.check_circle_outline_rounded,
                label: 'Status',
                value: todo.done ? 'Completed' : 'In Progress',
                iconColor: todo.done ? const Color(0xFF10B981) : Colors.orange,
                valueColor: todo.done ? const Color(0xFF10B981) : Colors.orange,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
