import 'package:flutter/material.dart';
import 'package:stage_0_mobile/src/database.dart';
import 'package:stage_0_mobile/src/features/todo_list/forms/create_task_form_data.dart';
import 'package:stage_0_mobile/src/helpers.dart';
import 'package:stage_0_mobile/src/widgets/shared/input_field.dart';
import 'package:stage_0_mobile/src/widgets/todos/forms/priority_color_input.dart';
import 'package:stage_0_mobile/src/widgets/todos/forms/category_input.dart';

class CreateTodoForm extends StatefulWidget {
  final void Function(CreateTaskFormData data)? onSubmit;
  final TodoItem? initialData;

  const CreateTodoForm({
    super.key,
    required this.onSubmit,
    required this.initialData,
  });

  @override
  State<CreateTodoForm> createState() => _CreateTodoFormState();
}

class _CreateTodoFormState extends State<CreateTodoForm> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descController = TextEditingController();

  String _selectedCategory = 'Work';
  Color _selectedColor = const Color(0xFF7B6EF6);
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _startTime = const TimeOfDay(hour: 9, minute: 0);
  TimeOfDay _endTime = const TimeOfDay(hour: 10, minute: 30);

  @override
  void initState() {
    super.initState();
    final todo = widget.initialData;
    if (todo != null) {
      _titleController.text = todo.title;
      _descController.text = todo.description;
      _selectedCategory = todo.category;
      _selectedColor = parseColor(todo.priorityColor);
      _selectedDate = todo.date;
      _startTime = TimeOfDay.fromDateTime(todo.startTime);
      _endTime = TimeOfDay.fromDateTime(todo.endTime);
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
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

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.initialData != null;

    return Form(
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
            InputField.text(
              label: 'Title',
              controller: _titleController,
              hintText: 'e.g. Design sprint review',
              accentColor: _selectedColor,
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Title is required' : null,
            ),
            const SizedBox(height: 20),
            InputField.text(
              label: 'Description',
              controller: _descController,
              hintText: 'What does this task involve?',
              accentColor: _selectedColor,
              maxLines: 3,
              textInputAction: TextInputAction.done,
            ),
            const SizedBox(height: 20),
            PriorityColorInput(
              selectedColor: _selectedColor,
              onColorSelected: (color) {
                setState(() => _selectedColor = color);
              },
            ),
            const SizedBox(height: 20),
            InputField.date(
              label: 'Date',
              dateValue: _selectedDate,
              accentColor: _selectedColor,
              onDateChanged: (d) => setState(() => _selectedDate = d),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: InputField.time(
                    label: 'Start',
                    timeValue: _startTime,
                    accentColor: _selectedColor,
                    onTimeChanged: (t) => setState(() => _startTime = t),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: InputField.time(
                    label: 'End',
                    timeValue: _endTime,
                    accentColor: _selectedColor,
                    onTimeChanged: (t) => setState(() => _endTime = t),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            CategoryInput(
              selectedCategory: _selectedCategory,
              selectedColor: _selectedColor,
              onCategorySelected: (category) {
                setState(() => _selectedCategory = category);
              },
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
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.check_circle_outline, size: 20),
                    const SizedBox(width: 8),
                    Text(
                      isEditing ? 'Update Task' : 'Create Task',
                      style: const TextStyle(
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
    );
  }
}
