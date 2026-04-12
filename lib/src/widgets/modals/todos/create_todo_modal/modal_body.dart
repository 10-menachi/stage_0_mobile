import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:stage_0_mobile/src/features/todo_list/forms/create_task_form_data.dart';
import 'package:stage_0_mobile/src/helpers.dart';
import 'package:stage_0_mobile/src/widgets/modals/todos/create_todo_modal/modal_label.dart';
import 'package:stage_0_mobile/src/widgets/modals/todos/create_todo_modal/picker_tile.dart';

class ModalBody extends StatefulWidget {
  final void Function(CreateTaskFormData data)? onSubmit;

  const ModalBody({super.key, this.onSubmit});

  @override
  State<ModalBody> createState() => _ModalBodyState();
}

class _ModalBodyState extends State<ModalBody> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descController = TextEditingController();

  String _selectedCategory = 'Work';
  Color _selectedColor = const Color(0xFF7B6EF6);
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _startTime = const TimeOfDay(hour: 9, minute: 0);
  TimeOfDay _endTime = const TimeOfDay(hour: 10, minute: 30);

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
    );
    if (picked != null) setState(() => _selectedDate = picked);
  }

  Future<void> _pickTime({required bool isStart}) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: isStart ? _startTime : _endTime,
    );
    if (picked != null) {
      setState(() => isStart ? _startTime = picked : _endTime = picked);
    }
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;

    final data = CreateTaskFormData(
      title: _titleController.text.trim(),
      description: _descController.text.trim(),
      priorityColor: _selectedColor,
      date: _selectedDate,
      startTime: _startTime,
      endTime: _endTime,
      category: _selectedCategory,
    );
    widget.onSubmit?.call(data);
  }

  String _formatTime(TimeOfDay t) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, t.hour, t.minute);
    return DateFormat('hh:mm a').format(dt);
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Form(
        key: _formKey,
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
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(
                  hintText: 'e.g. Design sprint review',
                ),
                textInputAction: TextInputAction.next,
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? 'Title is required'
                    : null,
              ),
              const SizedBox(height: 20),
              ModalLabel(text: 'Description'),
              const SizedBox(height: 8),
              TextFormField(
                controller: _descController,
                decoration: const InputDecoration(
                  hintText: 'What does this task involve?',
                ),
                maxLines: 3,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 20),
              ModalLabel(text: 'Priority Color'),
              const SizedBox(height: 12),
              Row(
                children: priorityColorOptions.map((c) {
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
                value: DateFormat('EEEE, d MMMM y').format(_selectedDate),
                accentColor: _selectedColor,
                onTap: _pickDate,
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
                          value: _formatTime(_startTime),
                          accentColor: _selectedColor,
                          onTap: () => _pickTime(isStart: true),
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
                          value: _formatTime(_endTime),
                          accentColor: _selectedColor,
                          onTap: () => _pickTime(isStart: false),
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
                children: ['Work', 'Personal', 'Health', 'Study'].map((cat) {
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
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _submit,
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
    );
  }
}
