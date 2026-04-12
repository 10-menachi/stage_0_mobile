import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stage_0_mobile/src/database.dart';
import 'package:stage_0_mobile/src/settings/riverpod/providers/todos_provider.dart';
import 'package:stage_0_mobile/src/widgets/modals/todos/create_todo_modal/modal_body.dart';
import 'package:stage_0_mobile/src/widgets/modals/todos/create_todo_modal/modal_header.dart';
import 'package:stage_0_mobile/src/helpers.dart';

class CreateTodoModal extends ConsumerStatefulWidget {
  final TodoItem? todo;

  const CreateTodoModal({super.key, this.todo});

  @override
  ConsumerState<CreateTodoModal> createState() => CreateTodoModalState();
}

class CreateTodoModalState extends ConsumerState<CreateTodoModal> {
  @override
  Widget build(BuildContext context) {
    final isEditing = widget.todo != null;

    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.08),
      decoration: const BoxDecoration(
        color: Color(0xFFF8F7F3),
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        children: [
          ModalHeader(title: isEditing ? 'Edit Task' : 'New Task'),
          ModalBody(
            initialData: widget.todo,
            onSubmit: (data) async {
              final navigator = Navigator.of(context);
              final messenger = ScaffoldMessenger.of(context);

              if (isEditing) {
                final updateTodo = ref.read(updateTodoProvider);
                await updateTodo(
                  widget.todo!.id,
                  data.title,
                  data.description,
                  data.priorityColor,
                  data.date,
                  combineDateAndTime(data.date, data.startTime),
                  combineDateAndTime(data.date, data.endTime),
                  data.category,
                );
              } else {
                final createTodo = ref.read(createTodoProvider);
                await createTodo(
                  data.title,
                  data.description,
                  data.priorityColor,
                  data.date,
                  combineDateAndTime(data.date, data.startTime),
                  combineDateAndTime(data.date, data.endTime),
                  data.category,
                );
              }

              navigator.pop();
              messenger.showSnackBar(
                SnackBar(
                  content: Text(isEditing ? 'Todo updated' : 'Todo created'),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
