import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stage_0_mobile/src/database.dart';
import 'package:stage_0_mobile/src/settings/riverpod/providers/database_provider.dart';

final todosProvider = FutureProvider.family<List<TodoItem>, int?>((
  ref,
  selectedIndex,
) async {
  final db = ref.watch(databaseProvider);

  final now = DateTime.now();
  final todayStart = DateTime(now.year, now.month, now.day);
  final tomorrowStart = todayStart.add(const Duration(days: 1));
  final dayAfterTomorrowStart = todayStart.add(const Duration(days: 2));

  final query = db.select(db.todoItems);

  switch (selectedIndex) {
    case 0:
      query.where(
        (tbl) =>
            tbl.date.isBiggerOrEqual(Variable(todayStart)) &
            tbl.date.isSmallerThan(Variable(tomorrowStart)),
      );
      query.orderBy([
        (tbl) => OrderingTerm(expression: tbl.date, mode: OrderingMode.asc),
      ]);
      break;

    case 1:
      query.where(
        (tbl) =>
            tbl.date.isBiggerOrEqual(Variable(tomorrowStart)) &
            tbl.date.isSmallerThan((Variable(dayAfterTomorrowStart))),
      );
      query.orderBy([
        (tbl) => OrderingTerm(expression: tbl.date, mode: OrderingMode.asc),
      ]);
      break;

    case 2:
      query.where(
        (tbl) => tbl.date.isBiggerOrEqual((Variable(dayAfterTomorrowStart))),
      );
      query.orderBy([
        (tbl) => OrderingTerm(expression: tbl.date, mode: OrderingMode.asc),
      ]);
      break;

    case 3:
      query.where((tbl) => tbl.date.isSmallerThan(Variable(todayStart)));
      query.orderBy([
        (tbl) => OrderingTerm(expression: tbl.date, mode: OrderingMode.desc),
      ]);
      break;

    case null:
    default:
      query
        ..orderBy([
          (tbl) => OrderingTerm(expression: tbl.date, mode: OrderingMode.desc),
        ])
        ..limit(20);
      break;
  }

  return query.get();
});
