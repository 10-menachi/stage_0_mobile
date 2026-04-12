import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stage_0_mobile/src/database.dart';
import 'package:stage_0_mobile/src/theme.dart';
import 'package:stage_0_mobile/src/settings/riverpod/providers/todos_provider.dart';
import 'package:stage_0_mobile/src/widgets/modals/todos/create_todo_modal/create_todo_modal.dart';
import 'package:stage_0_mobile/src/widgets/modals/todos/task_detail_modal/task_detail_modal.dart';
import 'package:stage_0_mobile/src/widgets/navigation/app_bar/custom_app_bar.dart';
import 'package:stage_0_mobile/src/widgets/navigation/custom_drawer/custom_drawer.dart';
import 'package:stage_0_mobile/src/widgets/todos/task_list.dart';
import 'package:stage_0_mobile/src/widgets/todos/todos_page_header.dart';

class TodoListScreen extends ConsumerStatefulWidget {
  const TodoListScreen({super.key});

  @override
  ConsumerState<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends ConsumerState<TodoListScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final List<String> _filters = ['Today', 'Tomorrow', 'Upcoming'];
  int selectedFilterIndex = 0;

  void _openCreateTodoModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const CreateTodoModal(),
    ).then((_) {
      ref.invalidate(todosProvider);
    });
  }

  void _openTaskDetail(TodoItem todo, int index) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => TaskDetailModal(
        todo: todo,
        onToggleDone: () {},
        onEditComplete: () => ref.invalidate(todosProvider),
      ),
    ).then((_) {
      ref.invalidate(todosProvider);
    });
  }

  void _updateFilterIndex(int index) {
    setState(() => selectedFilterIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: AppColors.backgroundColor,
      drawer: const AppDrawer(),
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(
                scaffoldKey: _scaffoldKey,
                openCreateTodoModal: _openCreateTodoModal,
              ),
              const SizedBox(height: 20),
              TodosPageHeader(
                filters: _filters,
                selectedFilterIndex: selectedFilterIndex,
                updateFilterIndex: _updateFilterIndex,
              ),
              const SizedBox(height: 16),
              TaskList(openTaskDetail: _openTaskDetail),
            ],
          ),
        ),
      ),
    );
  }
}
