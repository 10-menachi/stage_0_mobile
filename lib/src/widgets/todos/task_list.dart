import 'package:flutter/material.dart';
import 'package:stage_0_mobile/src/utils/constants.dart';
import 'package:stage_0_mobile/src/widgets/todos/todo_card.dart';

class TaskList extends StatelessWidget {
  final void Function(Map<String, dynamic> todo, int index) openTaskDetail;

  const TaskList({super.key, required this.openTaskDetail});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        padding: const EdgeInsets.only(bottom: 120),
        itemCount: todos.length,
        separatorBuilder: (_, _) => const SizedBox(height: 14),
        itemBuilder: (context, index) {
          final todo = todos[index];
          return GestureDetector(
            onTap: () => openTaskDetail(todo, index),
            child: TodoCard(
              title: todo['title'] as String,
              description: todo['description'] as String,
              time: '${todo['startTime']} - ${todo['endTime']}',
              color: todo['priorityColor'] as Color,
              isDone: todo['done'] as bool,
            ),
          );
        },
      ),
    );
  }
}
