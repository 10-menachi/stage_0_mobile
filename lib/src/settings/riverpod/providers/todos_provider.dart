import 'package:drift/drift.dart';
import 'package:flutter/animation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stage_0_mobile/src/database.dart';
import 'package:stage_0_mobile/src/settings/riverpod/providers/database_provider.dart';

final todosProvider = FutureProvider<List<TodoItem>>((ref) async {
  final db = ref.watch(databaseProvider);

  return (db.select(db.todoItems)..limit(20, offset: 0)).get();
});

final createTodoProvider = Provider((ref) {
  final db = ref.watch(databaseProvider);

  return (
    String title,
    String description,
    Color priorityColor,
    DateTime date,
    DateTime startTime,
    DateTime endTime,
    String category,
  ) async {
    await db
        .into(db.todoItems)
        .insert(
          TodoItemsCompanion.insert(
            title: title,
            createdAt: Value(DateTime.now()),
            description: description,
            priorityColor: priorityColor.toARGB32().toString(),
            date: date,
            startTime: startTime,
            endTime: endTime,
            category: category,
          ),
        );
  };
});

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
