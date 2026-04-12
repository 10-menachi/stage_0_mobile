import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:stage_0_mobile/src/database.dart';
import 'package:stage_0_mobile/src/helpers.dart';

class DeleteTodoDialog extends StatefulWidget {
  final TodoItem todo;
  final Future<void> Function() deleteTodo;

  const DeleteTodoDialog({
    super.key,
    required this.todo,
    required this.deleteTodo,
  });

  @override
  State<DeleteTodoDialog> createState() => _DeleteTodoDialogState();
}

class _DeleteTodoDialogState extends State<DeleteTodoDialog> {
  bool _isDeleting = false;

  Future<void> _handleDelete() async {
    if (_isDeleting) return;

    setState(() => _isDeleting = true);

    try {
      await widget.deleteTodo();

      if (!mounted) return;
      Navigator.of(context).pop(true);
    } catch (e) {
      if (!mounted) return;

      setState(() => _isDeleting = false);

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Failed to delete todo: $e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final title = truncateText(widget.todo.title, max: 20);

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: Colors.red.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(
                CupertinoIcons.delete,
                color: Colors.red,
                size: 26,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Delete Todo?',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              'Are you sure you want to delete "$title"? This action cannot be undone.',
              style: TextStyle(
                fontSize: 14,
                height: 1.45,
                color: Colors.grey.shade700,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 22),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: _isDeleting
                        ? null
                        : () => Navigator.of(context).pop(false),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _isDeleting ? null : _handleDelete,
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      minimumSize: const Size.fromHeight(50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: _isDeleting
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2.2),
                          )
                        : const Text(
                            'Delete',
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
