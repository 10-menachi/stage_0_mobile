import 'package:flutter/material.dart';
import 'package:stage_0_mobile/src/database.dart';

class CategoryBadge extends StatelessWidget {
  const CategoryBadge({super.key, required this.todo});

  final TodoItem todo;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        todo.category,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
