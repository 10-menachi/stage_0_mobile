import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:stage_0_mobile/src/settings/riverpod/providers/todos/create_todo_provider.dart';
import 'package:stage_0_mobile/src/settings/riverpod/providers/todos/todos_provider.dart';
import 'package:stage_0_mobile/src/utils/constants.dart';

class TodosPageHeader extends StatefulWidget {
  final int selectedFilterIndex;
  final List<String> filters;
  final void Function(int index) updateFilterIndex;

  const TodosPageHeader({
    super.key,
    required this.selectedFilterIndex,
    required this.filters,
    required this.updateFilterIndex,
  });

  @override
  State<TodosPageHeader> createState() => _TodosPageHeaderState();
}

class _TodosPageHeaderState extends State<TodosPageHeader> {
  final String formattedDate = DateFormat('EEEE, d MMM').format(DateTime.now());

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final todos = ref.watch(todosProvider);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat('MMMM').format(DateTime.now()),
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            Text(
              formattedDate,
              style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
            ),
            const SizedBox(height: 8),
            todos.when(
              data: (data) => Text(
                'You Have ${data.length} Tasks Today',
                style: const TextStyle(
                  fontSize: 24,
                  height: 1.05,
                  fontWeight: FontWeight.w500,
                ),
              ),
              loading: () => const Text(
                'Loading tasks...',
                style: TextStyle(
                  fontSize: 24,
                  height: 1.05,
                  fontWeight: FontWeight.w500,
                ),
              ),
              error: (error, stackTrace) => const Text(
                'Failed to load tasks',
                style: TextStyle(
                  fontSize: 24,
                  height: 1.05,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 12),
            Container(
              height: 52,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: Colors.black12),
              ),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Search task, project, etc...',
                  hintStyle: TextStyle(color: Colors.grey.shade500),
                  prefixIcon: const Icon(Icons.search),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(vertical: 15),
                ),
              ),
            ),
            const SizedBox(height: 18),
            // ── Filter chips ──
            SizedBox(
              height: 38,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: widget.filters.length,
                separatorBuilder: (_, _) => const SizedBox(width: 10),
                itemBuilder: (context, index) {
                  final bool isSelected = widget.selectedFilterIndex == index;
                  return GestureDetector(
                    onTap: () => widget.updateFilterIndex(index),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.black : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected ? Colors.black : Colors.black12,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        widget.filters[index],
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: isSelected ? Colors.white : Colors.black87,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 14),
            Text(
              "It's a good day to make progress on your tasks.",
              style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
            ),
          ],
        );
      },
    );
  }
}
