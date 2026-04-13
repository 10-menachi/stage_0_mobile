import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stage_0_mobile/src/database.dart';
import 'package:stage_0_mobile/src/settings/riverpod/providers/database_provider.dart';

final toggleTodoDoneProvider = Provider((ref) {
  final db = ref.watch(databaseProvider);

  return (TodoItem todo) async {
    await (db.update(db.todoItems)..where((t) => t.id.equals(todo.id))).write(
      TodoItemsCompanion(done: Value(!todo.done)),
    );
  };
});
