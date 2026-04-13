import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:stage_0_mobile/src/settings/riverpod/providers/todos/todos_count_provider.dart';
import 'package:stage_0_mobile/src/widgets/shared/animated_task_count.dart';

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
  late final DateTime _today;
  late final String _formattedDate;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _today = DateTime(now.year, now.month, now.day);
    _formattedDate = DateFormat('EEEE, d MMM').format(now);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, _) {
        final todosCount = ref.watch(todosCountProvider(_today));

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              DateFormat('MMMM').format(_today),
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 12),
            Text(
              _formattedDate,
              style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
            ),
            const SizedBox(height: 8),
            todosCount.when(
              data: (count) =>
                  AnimatedTaskCount(count: count, isLoading: false),
              loading: () => const AnimatedTaskCount.loading(),
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
            SizedBox(
              height: 38,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: widget.filters.length,
                separatorBuilder: (_, _) => const SizedBox(width: 10),
                itemBuilder: (context, index) {
                  final isSelected = widget.selectedFilterIndex == index;

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
