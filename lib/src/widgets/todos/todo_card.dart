import 'package:flutter/material.dart';
import 'package:stage_0_mobile/src/database.dart';
import 'package:stage_0_mobile/src/helpers.dart';

class TodoCard extends StatelessWidget {
  final TodoItem todo;

  const TodoCard({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: todo.done ? 0.65 : 1.0,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: parseColor(todo.priorityColor),
          borderRadius: BorderRadius.circular(22),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    todo.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      height: 1.1,
                      fontWeight: FontWeight.w500,
                      decoration: todo.done
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                      decorationColor: Colors.white60,
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  height: 38,
                  width: 38,
                  decoration: BoxDecoration(
                    color: todo.done
                        ? Colors.white.withValues(alpha: 0.35)
                        : Colors.white.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    todo.done ? Icons.check : Icons.more_horiz,
                    color: Colors.white,
                    size: todo.done ? 20 : 24,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              todo.description,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.white.withValues(alpha: 0.9),
                fontSize: 13,
                height: 1.35,
              ),
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                Icon(
                  Icons.access_time,
                  size: 18,
                  color: Colors.white.withValues(alpha: 0.95),
                ),
                const SizedBox(width: 6),
                Text(
                  formatTodoDateTime(
                    date: todo.date,
                    start: todo.startTime,
                    end: todo.endTime,
                  ),
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.95),
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
