import 'package:flutter/material.dart';
import 'package:stage_0_mobile/src/database.dart';
import 'package:stage_0_mobile/src/widgets/modals/todos/task_detail_modal/modal_body/description.dart';
import 'package:stage_0_mobile/src/widgets/modals/todos/task_detail_modal/modal_body/details.dart';
import 'package:stage_0_mobile/src/widgets/modals/todos/task_detail_modal/task_detail_actions.dart';

class ModalBody extends StatelessWidget {
  const ModalBody({
    super.key,
    required this.todo,
    required this.color,
    required this.onToggleDone,
    required this.onEditComplete,
  });

  final TodoItem todo;
  final Color color;
  final VoidCallback onToggleDone;
  final VoidCallback onEditComplete;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 28, 24, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Description(todo: todo),
            const SizedBox(height: 24),
            Details(color: color, todo: todo),
            const SizedBox(height: 32),
            TaskDetailActions(
              todo: todo,
              color: color,
              onToggleDone: onToggleDone,
              onEditComplete: onEditComplete,
            ),
          ],
        ),
      ),
    );
  }
}
