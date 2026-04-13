import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stage_0_mobile/src/screens/todo_list_screen.dart';
import 'package:stage_0_mobile/src/settings/riverpod/providers/todos/done_todos_count_provider.dart';
import 'package:stage_0_mobile/src/settings/riverpod/providers/todos/todos_count_provider.dart';
import 'package:stage_0_mobile/src/settings/riverpod/providers/todos/undone_todos_count_provider.dart';
import 'package:stage_0_mobile/src/theme.dart';
import 'package:stage_0_mobile/src/widgets/navigation/custom_drawer/drawer_divider.dart';
import 'package:stage_0_mobile/src/widgets/navigation/custom_drawer/drawer_item.dart';
import 'package:stage_0_mobile/src/widgets/navigation/custom_drawer/drawer_stat.dart';

class AppDrawer extends ConsumerStatefulWidget {
  const AppDrawer({super.key});

  @override
  ConsumerState<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends ConsumerState<AppDrawer> {
  @override
  Widget build(BuildContext context) {
    final todos = ref.watch(
      todosCountProvider(
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
      ),
    );
    final done = ref.watch(
      todosDoneCountProvider(
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
      ),
    );
    final left = ref.watch(
      todosLeftCountProvider(
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day),
      ),
    );
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.78,
      child: Container(
        color: AppColors.tertiaryColor,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 32, 24, 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 52,
                      width: 52,
                      decoration: BoxDecoration(
                        color: AppColors.backgroundColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(
                        Icons.check_rounded,
                        size: 30,
                        color: AppColors.textColor,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Utility App',
                      style: TextStyle(
                        color: AppColors.textColor,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.4,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Your productivity companion',
                      style: TextStyle(
                        color: AppColors.textColor.withValues(alpha: 0.4),
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 24),

                    todos.when(
                      data: (data) {
                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 14,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.secondary,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(
                              color: AppColors.textColor.withValues(
                                alpha: 0.08,
                              ),
                            ),
                          ),
                          child: Row(
                            children: [
                              DrawerStat(
                                label: 'Tasks',
                                value: data.toString(),
                              ),
                              DrawerDivider(),
                              DrawerStat(
                                label: 'Done',
                                value: done.value.toString(),
                              ),
                              DrawerDivider(),
                              DrawerStat(
                                label: 'Left',
                                value: left.value.toString(),
                              ),
                            ],
                          ),
                        );
                      },
                      loading: () =>
                          const Center(child: CircularProgressIndicator()),
                      error: (error, stackTrace) =>
                          Center(child: Text(error.toString())),
                    ),

                    // Quick stats
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  children: [
                    DrawerItem(
                      icon: Icons.check_circle_outline_rounded,
                      label: 'TODO List',
                      isActive: true,
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const TodoListScreen(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 24),
                child: Column(
                  children: [
                    Divider(color: AppColors.textColor.withValues(alpha: 0.08)),
                    const SizedBox(height: 8),
                    DrawerItem(
                      icon: Icons.settings_outlined,
                      label: 'Settings',
                      onTap: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
