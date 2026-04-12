import 'package:flutter/material.dart';
import 'package:stage_0_mobile/src/database.dart';
import 'package:stage_0_mobile/src/widgets/modals/todos/create_todo_modal/create_todo_modal.dart';

class TaskDetailActions extends StatelessWidget {
  final TodoItem todo;
  final bool isDone;
  final Color color;
  final VoidCallback onToggleDone;
  final VoidCallback onEditComplete;

  const TaskDetailActions({
    super.key,
    required this.todo,
    required this.isDone,
    required this.color,
    required this.onToggleDone,
    required this.onEditComplete,
  });

  void _openEditModal(BuildContext context) {
    Navigator.pop(context); // close detail modal first
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => CreateTodoModal(todo: todo),
    ).then((_) => onEditComplete());
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
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
                    isDone ? Icons.refresh_rounded : Icons.check_rounded,
                    color: isDone ? Colors.black54 : Colors.white,
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    isDone ? 'Mark Undone' : 'Mark Done',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: isDone ? Colors.black54 : Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        GestureDetector(
          onTap: () => _openEditModal(context),
          child: Container(
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
        ),
        const SizedBox(width: 10),
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
    );
  }
}
