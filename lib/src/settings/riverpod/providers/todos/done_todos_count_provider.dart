import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stage_0_mobile/src/settings/riverpod/providers/database_provider.dart';

final todosDoneCountProvider = FutureProvider.family<int, DateTime?>((
  ref,
  date,
) async {
  final db = ref.watch(databaseProvider);

  final query = db.select(db.todoItems);

  if (date != null) {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    query.where(
      (tbl) =>
          tbl.date.isBiggerOrEqualValue(startOfDay) &
          tbl.date.isSmallerThanValue(endOfDay) &
          tbl.done.equals(true),
    );
  } else {
    query.where((tbl) => tbl.done.equals(true));
  }

  return query.get().then((value) => value.length);
});
