import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stage_0_mobile/src/database.dart';
import 'package:stage_0_mobile/src/settings/riverpod/providers/todos/delete_todos_provider.dart';
import 'package:stage_0_mobile/src/widgets/modals/todos/create_todo_modal/create_todo_modal.dart';
import 'package:stage_0_mobile/src/widgets/modals/todos/delete_todo_modal/delete_todo_dialog.dart';

class TaskDetailActions extends ConsumerStatefulWidget {
  final TodoItem todo;
  final Color color;
  final VoidCallback onToggleDone;
  final VoidCallback onEditComplete;

  const TaskDetailActions({
    super.key,
    required this.todo,
    required this.color,
    required this.onToggleDone,
    required this.onEditComplete,
  });

  @override
  ConsumerState<TaskDetailActions> createState() => _TaskDetailActionsState();
}

class _TaskDetailActionsState extends ConsumerState<TaskDetailActions> {
  bool _isDeleting = false;

  void _openEditModal(BuildContext context) {
    if (_isDeleting) return;

    Navigator.pop(context);
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => CreateTodoModal(todo: widget.todo),
    ).then((_) => widget.onEditComplete());
  }

  Future<void> _deleteTodo() async {
    final deleteTodo = ref.read(deleteTodoProvider);
    await deleteTodo(widget.todo.id);
  }

  Future<void> _handleDelete(BuildContext context) async {
    if (_isDeleting) return;

    setState(() => _isDeleting = true);

    try {
      final deleted = await showDialog<bool>(
        context: context,
        barrierDismissible: false,
        builder: (dialogContext) {
          return DeleteTodoDialog(todo: widget.todo, deleteTodo: _deleteTodo);
        },
      );

      if (!mounted) return;

      if (deleted == true) {
        Navigator.pop(context);
        widget.onEditComplete();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Todo deleted successfully')),
        );
      }
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to delete todo: $e')));
    } finally {
      if (mounted) {
        setState(() => _isDeleting = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool actionsDisabled = _isDeleting;

    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: actionsDisabled
                ? null
                : () {
                    widget.onToggleDone();
                    Navigator.pop(context);
                  },
            child: Opacity(
              opacity: actionsDisabled ? 0.6 : 1,
              child: Container(
                height: 54,
                decoration: BoxDecoration(
                  color: widget.todo.done
                      ? const Color(0xFFF0F0F0)
                      : widget.color,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      widget.todo.done
                          ? Icons.refresh_rounded
                          : Icons.check_rounded,
                      color: widget.todo.done ? Colors.black54 : Colors.white,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      widget.todo.done ? 'Mark Undone' : 'Mark Done',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: widget.todo.done ? Colors.black54 : Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        GestureDetector(
          onTap: actionsDisabled ? null : () => _openEditModal(context),
          child: Opacity(
            opacity: actionsDisabled ? 0.6 : 1,
            child: Container(
              height: 54,
              width: 54,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.black12),
              ),
              child: const Icon(
                Icons.edit_outlined,
                size: 20,
                color: Colors.black54,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        GestureDetector(
          onTap: () => _handleDelete(context),
          child: Container(
            height: 54,
            width: 54,
            decoration: BoxDecoration(
              color: const Color(0xFFFFEEEE),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Center(
              child: _isDeleting
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2.2),
                    )
                  : const Icon(
                      Icons.delete_outline_rounded,
                      size: 20,
                      color: Color(0xFFE53935),
                    ),
            ),
          ),
        ),
      ],
    );
  }
}
