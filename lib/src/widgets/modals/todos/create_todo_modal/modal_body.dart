import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stage_0_mobile/src/database.dart';
import 'package:stage_0_mobile/src/forms/todos/create_todo_form.dart';
import 'package:stage_0_mobile/src/helpers.dart';
import 'package:stage_0_mobile/src/settings/riverpod/providers/todos/create_todo_provider.dart';
import 'package:stage_0_mobile/src/settings/riverpod/providers/todos/update_todo_provider.dart';

class ModalBody extends ConsumerStatefulWidget {
  final TodoItem? todo;
  const ModalBody({super.key, required this.todo});

  @override
  ConsumerState<ModalBody> createState() => _ModalBodyState();
}

class _ModalBodyState extends ConsumerState<ModalBody> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CreateTodoForm(
        initialData: widget.todo,
        onSubmit: (data) async {
          final navigator = Navigator.of(context);
          final messenger = ScaffoldMessenger.of(context);

          if (widget.todo != null) {
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
              content: Text(
                widget.todo != null ? 'Todo updated' : 'Todo created',
              ),
            ),
          );
        },
      ),
    );
  }
}
