import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stage_0_mobile/src/database.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  return AppDatabase();
});