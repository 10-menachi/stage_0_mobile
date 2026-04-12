import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stage_0_mobile/src/settings/riverpod/providers/database_provider.dart';

final deleteTodoProvider = Provider((ref) {
  final db = ref.watch(databaseProvider);

  return (int id) async {
    await (db.delete(db.todoItems)..where((t) => t.id.equals(id))).go();
  };
});
