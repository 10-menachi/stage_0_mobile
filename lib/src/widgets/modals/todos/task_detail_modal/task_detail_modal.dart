import 'package:flutter/material.dart';
import 'package:stage_0_mobile/src/database.dart';
import 'package:stage_0_mobile/src/helpers.dart';
import 'package:stage_0_mobile/src/widgets/modals/todos/task_detail_modal/modal_body/modal_body.dart';
import 'package:stage_0_mobile/src/widgets/modals/todos/task_detail_modal/modal_header/modal_header.dart';

class TaskDetailModal extends StatelessWidget {
  final TodoItem todo;
  final VoidCallback onToggleDone;
  final VoidCallback onEditComplete;

  const TaskDetailModal({
    super.key,
    required this.todo,
    required this.onToggleDone,
    required this.onEditComplete,
  });

  @override
  Widget build(BuildContext context) {
    final Color color = parseColor(todo.priorityColor);

    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.12),
      decoration: const BoxDecoration(
        color: Color(0xFFF8F7F3),
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        children: [
          ModalHeader(color: color, todo: todo),

          ModalBody(
            todo: todo,
            color: color,
            onToggleDone: onToggleDone,
            onEditComplete: onEditComplete,
          ),
        ],
      ),
    );
  }
}
