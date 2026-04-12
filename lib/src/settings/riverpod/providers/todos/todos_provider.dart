import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stage_0_mobile/src/database.dart';
import 'package:stage_0_mobile/src/settings/riverpod/providers/database_provider.dart';

final todosProvider = FutureProvider<List<TodoItem>>((ref) async {
  final db = ref.watch(databaseProvider);

  return (db.select(db.todoItems)..limit(20, offset: 0)).get();
});
