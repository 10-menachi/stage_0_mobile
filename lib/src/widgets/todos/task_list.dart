import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stage_0_mobile/src/database.dart';
import 'package:stage_0_mobile/src/helpers.dart';
import 'package:stage_0_mobile/src/settings/riverpod/providers/todos/todos_provider.dart';
import 'package:stage_0_mobile/src/widgets/todos/todo_card.dart';

class TaskList extends ConsumerWidget {
  final void Function(TodoItem todo, int index) openTaskDetail;

  const TaskList({super.key, required this.openTaskDetail});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todos = ref.watch(todosProvider);

    return Expanded(
      child: todos.when(
        data: (data) {
          if (data.isEmpty) {
            return const Center(child: Text('No tasks yet'));
          }

          return ListView.separated(
            padding: const EdgeInsets.only(bottom: 120),
            itemCount: data.length,
            separatorBuilder: (_, _) => const SizedBox(height: 14),
            itemBuilder: (context, index) {
              final todo = data[index];

              return GestureDetector(
                onTap: () => openTaskDetail(todo, index),
                child: TodoCard(
                  title: todo.title,
                  description: todo.description,
                  time:
                      '${formatTime(todo.startTime)} - ${formatTime(todo.endTime)}',
                  color: parseColor(todo.priorityColor),
                  isDone: todo.done,
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => Center(child: Text(error.toString())),
      ),
    );
  }
}
