import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stage_0_mobile/src/widgets/modals/todos/create_todo_modal/modal_label.dart';
import 'package:stage_0_mobile/src/widgets/modals/todos/create_todo_modal/styled_textfield.dart';
import 'package:stage_0_mobile/src/widgets/modals/todos/create_todo_modal/picker_tile.dart';

class CreateTodoModal extends StatefulWidget {
  const CreateTodoModal({super.key});

  @override
  State<CreateTodoModal> createState() => CreateTodoModalState();
}

class CreateTodoModalState extends State<CreateTodoModal> {
  String _selectedCategory = 'Work';
  String _selectedNotify = '15 min';
  Color _selectedColor = const Color(0xFF7B6EF6);

  final List<Color> _colorOptions = const [
    Color(0xFF7B6EF6),
    Color(0xFF2196F3),
    Color(0xFF10B981),
    Color(0xFFD6755B),
    Color(0xFFF59E0B),
    Color(0xFFEC4899),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.08),
      decoration: const BoxDecoration(
        color: Color(0xFFF8F7F3),
        borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
      ),
      child: Column(
        children: [
          // ── Header ──
          Container(
            padding: const EdgeInsets.fromLTRB(24, 14, 16, 18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(32),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              children: [
                Center(
                  child: Container(
                    height: 4,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.black12,
                      borderRadius: BorderRadius.circular(999),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Text(
                      'New Task',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.4,
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        height: 36,
                        width: 36,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF0F0F0),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.close,
                          size: 18,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // ── Body ──
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                left: 24,
                right: 24,
                top: 24,
                bottom: MediaQuery.of(context).viewInsets.bottom + 24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ModalLabel(text: 'Title'),
                  const SizedBox(height: 8),
                  StyledTextField(
                    hintText: 'e.g. Design sprint review',
                    fontSize: 16,
                  ),
                  const SizedBox(height: 20),
                  ModalLabel(text: 'Description'),
                  const SizedBox(height: 8),
                  StyledTextField(
                    hintText: 'What does this task involve?',
                    maxLines: 3,
                  ),
                  const SizedBox(height: 20),
                  ModalLabel(text: 'Priority Color'),
                  const SizedBox(height: 12),
                  Row(
                    children: _colorOptions.map((c) {
                      final bool sel = _selectedColor == c;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedColor = c),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 150),
                          margin: const EdgeInsets.only(right: 10),
                          height: sel ? 36 : 30,
                          width: sel ? 36 : 30,
                          decoration: BoxDecoration(
                            color: c,
                            shape: BoxShape.circle,
                            border: sel
                                ? Border.all(color: Colors.black, width: 2.5)
                                : null,
                            boxShadow: sel
                                ? [
                                    BoxShadow(
                                      color: c.withValues(alpha: 0.4),
                                      blurRadius: 8,
                                      offset: const Offset(0, 3),
                                    ),
                                  ]
                                : null,
                          ),
                          child: sel
                              ? const Icon(
                                  Icons.check,
                                  size: 16,
                                  color: Colors.white,
                                )
                              : null,
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  ModalLabel(text: 'Date'),
                  const SizedBox(height: 8),
                  PickerTile(
                    icon: Icons.calendar_today_outlined,
                    value: DateFormat('EEEE, d MMMM y').format(DateTime.now()),
                    accentColor: _selectedColor,
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ModalLabel(text: 'Start'),
                            const SizedBox(height: 8),
                            PickerTile(
                              icon: Icons.schedule_outlined,
                              value: '09:00 AM',
                              accentColor: _selectedColor,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ModalLabel(text: 'End'),
                            const SizedBox(height: 8),
                            PickerTile(
                              icon: Icons.schedule_outlined,
                              value: '10:30 AM',
                              accentColor: _selectedColor,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ModalLabel(text: 'Category'),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: ['Work', 'Personal', 'Health', 'Study'].map((
                      cat,
                    ) {
                      final bool sel = _selectedCategory == cat;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedCategory = cat),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 150),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 9,
                          ),
                          decoration: BoxDecoration(
                            color: sel ? _selectedColor : Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: sel ? _selectedColor : Colors.black12,
                            ),
                          ),
                          child: Text(
                            cat,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: sel ? Colors.white : Colors.black54,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 20),
                  ModalLabel(text: 'Remind Me'),
                  const SizedBox(height: 10),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: ['5 min', '15 min', '30 min', '1 hour'].map((n) {
                      final bool sel = _selectedNotify == n;
                      return GestureDetector(
                        onTap: () => setState(() => _selectedNotify = n),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 150),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 9,
                          ),
                          decoration: BoxDecoration(
                            color: sel ? Colors.black : Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                              color: sel ? Colors.black : Colors.black12,
                            ),
                          ),
                          child: Text(
                            n,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                              color: sel ? Colors.white : Colors.black54,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: double.infinity,
                    height: 56,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: _selectedColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.check_circle_outline, size: 20),
                          SizedBox(width: 8),
                          Text(
                            'Create Task',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              letterSpacing: -0.2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
