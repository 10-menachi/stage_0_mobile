import 'package:flutter/material.dart';
import 'package:stage_0_mobile/src/database.dart';
import 'package:stage_0_mobile/src/widgets/modals/todos/create_todo_modal/modal_body.dart';
import 'package:stage_0_mobile/src/widgets/modals/todos/create_todo_modal/modal_header.dart';

class CreateTodoModal extends StatefulWidget {
  final TodoItem? todo;

  const CreateTodoModal({super.key, this.todo});

  @override
  State<CreateTodoModal> createState() => CreateTodoModalState();
}

class CreateTodoModalState extends State<CreateTodoModal> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.08),
      decoration: const BoxDecoration(
        color: Color(0xFFF8F7F3),
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        children: [
          ModalHeader(title: widget.todo != null ? 'Edit Task' : 'New Task'),
          ModalBody(todo: widget.todo),
        ],
      ),
    );
  }
}
