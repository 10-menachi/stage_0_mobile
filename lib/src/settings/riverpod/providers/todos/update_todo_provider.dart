import 'package:drift/drift.dart';
import 'package:flutter/animation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stage_0_mobile/src/database.dart';
import 'package:stage_0_mobile/src/settings/riverpod/providers/database_provider.dart';

final updateTodoProvider = Provider((ref) {
  final db = ref.watch(databaseProvider);

  return (
    int id,
    String title,
    String description,
    Color priorityColor,
    DateTime date,
    DateTime startTime,
    DateTime endTime,
    String category,
  ) async {
    await (db.update(db.todoItems)..where((t) => t.id.equals(id))).write(
      TodoItemsCompanion(
        title: Value(title),
        description: Value(description),
        priorityColor: Value(priorityColor.toARGB32().toString()),
        date: Value(date),
        startTime: Value(startTime),
        endTime: Value(endTime),
        category: Value(category),
      ),
    );
  };
});
