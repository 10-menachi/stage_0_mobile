import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stage_0_mobile/src/widgets/modals/todos/task_detail_modal/detail_row.dart';
import 'package:stage_0_mobile/src/widgets/modals/todos/task_detail_modal/detail_section_label.dart';
import 'package:stage_0_mobile/src/widgets/modals/todos/task_detail_modal/header_chip.dart';
import 'package:stage_0_mobile/src/widgets/shared/custom_divider.dart';

class TaskDetailModal extends StatelessWidget {
  final Map<String, dynamic> todo;
  final VoidCallback onToggleDone;

  const TaskDetailModal({
    super.key,
    required this.todo,
    required this.onToggleDone,
  });

  @override
  Widget build(BuildContext context) {
    final Color color = todo['priorityColor'] as Color;
    final bool isDone = todo['done'] as bool;
    final String date = DateFormat(
      'EEEE, d MMMM y',
    ).format(todo['date'] as DateTime);

    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.12),
      decoration: const BoxDecoration(
        color: Color(0xFFF8F7F3),
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        children: [
          // ── Colored header ──
          Container(
            padding: const EdgeInsets.fromLTRB(24, 16, 20, 24),
            decoration: BoxDecoration(
              color: color,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(32),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Handle + close
                Row(
                  children: [
                    Center(
                      child: Container(
                        height: 4,
                        width: 40,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.35),
                          borderRadius: BorderRadius.circular(999),
                        ),
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        height: 36,
                        width: 36,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.close,
                          size: 18,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Category badge
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    todo['category'] as String,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                // Title
                Text(
                  todo['title'] as String,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    height: 1.15,
                    decoration: isDone
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                    decorationColor: Colors.white54,
                  ),
                ),
                const SizedBox(height: 16),
                // Time + date row
                Row(
                  children: [
                    HeaderChip(
                      icon: Icons.access_time,
                      label: '${todo['startTime']} – ${todo['endTime']}',
                    ),
                    const SizedBox(width: 10),
                    HeaderChip(
                      icon: Icons.calendar_today_outlined,
                      label: DateFormat(
                        'd MMM',
                      ).format(todo['date'] as DateTime),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // ── Scrollable body ──
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(24, 28, 24, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Description section
                  const DetailSectionLabel(text: 'Description'),
                  const SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: Colors.black12),
                    ),
                    child: Text(
                      todo['description'] as String,
                      style: const TextStyle(
                        fontSize: 15,
                        height: 1.6,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Details grid
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
                          value: date,
                          iconColor: color,
                        ),
                        CustomDivider(),
                        DetailRow(
                          icon: Icons.schedule_outlined,
                          label: 'Start time',
                          value: todo['startTime'] as String,
                          iconColor: color,
                        ),
                        CustomDivider(),
                        DetailRow(
                          icon: Icons.schedule_outlined,
                          label: 'End time',
                          value: todo['endTime'] as String,
                          iconColor: color,
                        ),
                        CustomDivider(),
                        DetailRow(
                          icon: Icons.label_outline_rounded,
                          label: 'Category',
                          value: todo['category'] as String,
                          iconColor: color,
                        ),
                        CustomDivider(),
                        DetailRow(
                          icon: Icons.check_circle_outline_rounded,
                          label: 'Status',
                          value: isDone ? 'Completed' : 'In Progress',
                          iconColor: isDone
                              ? const Color(0xFF10B981)
                              : Colors.orange,
                          valueColor: isDone
                              ? const Color(0xFF10B981)
                              : Colors.orange,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Action buttons
                  Row(
                    children: [
                      // Toggle done button
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            onToggleDone();
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: 54,
                            decoration: BoxDecoration(
                              color: isDone ? const Color(0xFFF0F0F0) : color,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  isDone
                                      ? Icons.refresh_rounded
                                      : Icons.check_rounded,
                                  color: isDone ? Colors.black54 : Colors.white,
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  isDone ? 'Mark Undone' : 'Mark Done',
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: isDone
                                        ? Colors.black54
                                        : Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      // Edit button
                      Container(
                        height: 54,
                        width: 54,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.black12),
                        ),
                        child: const Icon(
                          Icons.edit_outlined,
                          size: 20,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(width: 10),
                      // Delete button
                      Container(
                        height: 54,
                        width: 54,
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFEEEE),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: const Icon(
                          Icons.delete_outline_rounded,
                          size: 20,
                          color: Color(0xFFE53935),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
