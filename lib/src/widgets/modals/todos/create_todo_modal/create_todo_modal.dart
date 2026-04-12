import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stage_0_mobile/src/settings/riverpod/providers/todos_provider.dart';
import 'package:stage_0_mobile/src/widgets/modals/todos/create_todo_modal/modal_body.dart';
import 'package:stage_0_mobile/src/widgets/modals/todos/create_todo_modal/modal_header.dart';
import 'package:stage_0_mobile/src/helpers.dart';

class CreateTodoModal extends ConsumerStatefulWidget {
  const CreateTodoModal({super.key});

  @override
  ConsumerState<CreateTodoModal> createState() => CreateTodoModalState();
}

class CreateTodoModalState extends ConsumerState<CreateTodoModal> {
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
          ModalHeader(),
          ModalBody(
            onSubmit: (data) async {
              final createTodo = ref.read(createTodoProvider);
              final navigator = Navigator.of(context);
              final messenger = ScaffoldMessenger.of(context);

              await createTodo(
                data.title,
                data.description,
                data.priorityColor,
                data.date,
                combineDateAndTime(data.date, data.startTime),
                combineDateAndTime(data.date, data.endTime),
                data.category,
              );

              navigator.pop();
              messenger.showSnackBar(
                const SnackBar(content: Text('Todo created')),
              );
            },
          ),
        ],
      ),
    );
  }
}
