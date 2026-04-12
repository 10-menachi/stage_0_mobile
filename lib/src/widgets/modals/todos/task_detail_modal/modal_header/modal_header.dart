import 'package:flutter/material.dart';
import 'package:stage_0_mobile/src/database.dart';
import 'package:stage_0_mobile/src/widgets/modals/todos/task_detail_modal/modal_header/category_badge.dart';
import 'package:stage_0_mobile/src/widgets/modals/todos/task_detail_modal/modal_header/handle_close.dart';
import 'package:stage_0_mobile/src/widgets/modals/todos/task_detail_modal/modal_header/modal_title.dart';
import 'package:stage_0_mobile/src/widgets/modals/todos/task_detail_modal/modal_header/time_date.dart';

class ModalHeader extends StatelessWidget {
  const ModalHeader({super.key, required this.color, required this.todo});

  final Color color;
  final TodoItem todo;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 20, 24),
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          HandleClose(),
          const SizedBox(height: 20),
          CategoryBadge(todo: todo),
          const SizedBox(height: 12),
          ModalTitle(todo: todo),
          const SizedBox(height: 16),
          TimeDate(todo: todo),
        ],
      ),
    );
  }
}
