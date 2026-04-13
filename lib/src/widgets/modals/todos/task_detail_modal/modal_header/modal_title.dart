import 'package:flutter/material.dart';
import 'package:stage_0_mobile/src/database.dart';

class ModalTitle extends StatelessWidget {
  final TodoItem todo;

  const ModalTitle({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Text(
      todo.title,
      style: TextStyle(
        color: Colors.white,
        fontSize: 26,
        fontWeight: FontWeight.w700,
        height: 1.15,
        decoration: todo.done
            ? TextDecoration.lineThrough
            : TextDecoration.none,
        decorationColor: Colors.white54,
      ),
    );
  }
}
