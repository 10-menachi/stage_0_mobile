import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum InputFieldType { text, date, time }

class InputField extends StatelessWidget {
  final String label;
  final InputFieldType type;

  // Text
  final TextEditingController? controller;
  final String? hintText;
  final int maxLines;
  final TextInputAction textInputAction;
  final String? Function(String?)? validator;

  // Date
  final DateTime? dateValue;
  final ValueChanged<DateTime>? onDateChanged;

  // Time
  final TimeOfDay? timeValue;
  final ValueChanged<TimeOfDay>? onTimeChanged;

  // Shared
  final Color accentColor;

  const InputField.text({
    super.key,
    required this.label,
    required this.controller,
    this.hintText,
    this.maxLines = 1,
    this.textInputAction = TextInputAction.next,
    this.validator,
    this.accentColor = Colors.black,
  }) : type = InputFieldType.text,
       dateValue = null,
       onDateChanged = null,
       timeValue = null,
       onTimeChanged = null;

  const InputField.date({
    super.key,
    required this.label,
    required this.dateValue,
    required this.onDateChanged,
    required this.accentColor,
  }) : type = InputFieldType.date,
       controller = null,
       hintText = null,
       maxLines = 1,
       textInputAction = TextInputAction.next,
       validator = null,
       timeValue = null,
       onTimeChanged = null;

  const InputField.time({
    super.key,
    required this.label,
    required this.timeValue,
    required this.onTimeChanged,
    required this.accentColor,
  }) : type = InputFieldType.time,
       controller = null,
       hintText = null,
       maxLines = 1,
       textInputAction = TextInputAction.next,
       validator = null,
       dateValue = null,
       onDateChanged = null;

  Future<void> _handleTap(BuildContext context) async {
    if (type == InputFieldType.date) {
      final picked = await showDatePicker(
        context: context,
        initialDate: dateValue ?? DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365 * 2)),
      );
      if (picked != null) onDateChanged?.call(picked);
    } else if (type == InputFieldType.time) {
      final picked = await showTimePicker(
        context: context,
        initialTime: timeValue ?? TimeOfDay.now(),
      );
      if (picked != null) onTimeChanged?.call(picked);
    }
  }

  String _formatDate(DateTime date) =>
      DateFormat('EEEE, d MMMM y').format(date);

  String _formatTime(TimeOfDay time) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat('hh:mm a').format(dt);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: Colors.black54,
          ),
        ),
        const SizedBox(height: 8),
        if (type == InputFieldType.text)
          TextFormField(
            controller: controller,
            decoration: InputDecoration(
              hintText: hintText,
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 13,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: Colors.black12),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: Colors.black12),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(color: accentColor),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(color: Colors.redAccent),
              ),
              hintStyle: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: Colors.black38,
              ),
            ),
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
            maxLines: maxLines,
            textInputAction: textInputAction,
            validator: validator,
          )
        else
          GestureDetector(
            onTap: () => _handleTap(context),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 13),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: Colors.black12),
              ),
              child: Row(
                children: [
                  Icon(
                    type == InputFieldType.date
                        ? Icons.calendar_today_outlined
                        : Icons.schedule_outlined,
                    size: 16,
                    color: accentColor,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      type == InputFieldType.date
                          ? _formatDate(dateValue!)
                          : _formatTime(timeValue!),
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const Icon(
                    Icons.keyboard_arrow_down,
                    size: 18,
                    color: Colors.black38,
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}
