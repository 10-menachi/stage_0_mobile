import 'package:flutter/material.dart';
import 'package:stage_0_mobile/src/database.dart';
import 'package:stage_0_mobile/src/widgets/modals/todos/task_detail_modal/modal_details/detail_section_label.dart';

class Description extends StatelessWidget {
  final TodoItem todo;
  const Description({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
            todo.description,
            style: const TextStyle(
              fontSize: 15,
              height: 1.6,
              color: Colors.black87,
            ),
          ),
        ),
      ],
    );
  }
}
