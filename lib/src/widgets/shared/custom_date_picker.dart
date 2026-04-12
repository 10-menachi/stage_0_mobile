import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDatePicker extends StatefulWidget {
  final DateTime initialDate;

  const CustomDatePicker({super.key, required this.initialDate});

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  late DateTime _selectedDate;
  late DateTime _currentMonth;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime(
      widget.initialDate.year,
      widget.initialDate.month,
      widget.initialDate.day,
    );
    _currentMonth = DateTime(widget.initialDate.year, widget.initialDate.month);
  }

  void _goToPreviousMonth() {
    final now = DateTime.now();
    final firstAllowedMonth = DateTime(now.year, now.month);

    final previous = DateTime(_currentMonth.year, _currentMonth.month - 1);
    if (previous.isBefore(firstAllowedMonth)) return;

    setState(() {
      _currentMonth = previous;
    });
  }

  void _goToNextMonth() {
    final lastAllowed = DateTime.now().add(const Duration(days: 365 * 2));
    final lastAllowedMonth = DateTime(lastAllowed.year, lastAllowed.month);

    final next = DateTime(_currentMonth.year, _currentMonth.month + 1);
    if (next.isAfter(lastAllowedMonth)) return;

    setState(() {
      _currentMonth = next;
    });
  }

  bool _isSameDate(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  List<DateTime?> _buildCalendarDays(DateTime month) {
    final firstDayOfMonth = DateTime(month.year, month.month, 1);
    final lastDayOfMonth = DateTime(month.year, month.month + 1, 0);

    final firstWeekday = firstDayOfMonth.weekday % 7;
    final totalDays = lastDayOfMonth.day;

    final days = <DateTime?>[];

    for (int i = 0; i < firstWeekday; i++) {
      days.add(null);
    }

    for (int day = 1; day <= totalDays; day++) {
      days.add(DateTime(month.year, month.month, day));
    }

    while (days.length % 7 != 0) {
      days.add(null);
    }

    return days;
  }

  bool _isDisabled(DateTime date) {
    final today = DateTime.now();
    final minDate = DateTime(today.year, today.month, today.day);
    final maxDate = minDate.add(const Duration(days: 365 * 2));

    return date.isBefore(minDate) || date.isAfter(maxDate);
  }

  @override
  Widget build(BuildContext context) {
    final days = _buildCalendarDays(_currentMonth);
    final weekDays = ['S', 'M', 'T', 'W', 'T', 'F', 'S'];

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Container(
          padding: const EdgeInsets.fromLTRB(20, 14, 20, 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(28),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 46,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(999),
                ),
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  const Expanded(
                    child: Text(
                      'Select a date',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        height: 1,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      final today = DateTime.now();
                      setState(() {
                        _selectedDate = DateTime(
                          today.year,
                          today.month,
                          today.day,
                        );
                        _currentMonth = DateTime(today.year, today.month);
                      });
                    },
                    child: const Text(
                      'Today',
                      style: TextStyle(
                        color: Colors.black87,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 14),
              Container(
                height: 3,
                width: double.infinity,
                alignment: Alignment.centerLeft,
                child: Container(
                  width: 96,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ),
              const SizedBox(height: 22),
              Row(
                children: [
                  IconButton(
                    onPressed: _goToPreviousMonth,
                    icon: const Icon(Icons.chevron_left_rounded),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        DateFormat('MMMM yyyy').format(_currentMonth),
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: _goToNextMonth,
                    icon: const Icon(Icons.chevron_right_rounded),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Row(
                children: weekDays
                    .map(
                      (day) => Expanded(
                        child: Center(
                          child: Text(
                            day,
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 12),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: days.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 7,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 1,
                ),
                itemBuilder: (context, index) {
                  final date = days[index];

                  if (date == null) {
                    return const SizedBox.shrink();
                  }

                  final isSelected = _isSameDate(date, _selectedDate);
                  final isToday = _isSameDate(date, DateTime.now());
                  final isDisabled = _isDisabled(date);

                  return GestureDetector(
                    onTap: isDisabled
                        ? null
                        : () {
                            setState(() {
                              _selectedDate = date;
                            });
                          },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 160),
                      decoration: BoxDecoration(
                        color: isSelected ? Colors.black : Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(
                          color: isSelected
                              ? Colors.black
                              : isToday
                              ? Colors.black54
                              : Colors.black12,
                          width: isToday ? 1.4 : 1,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          '${date.day}',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: isDisabled
                                ? Colors.black26
                                : isSelected
                                ? Colors.white
                                : Colors.black87,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        minimumSize: const Size.fromHeight(54),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        side: const BorderSide(color: Colors.black12),
                      ),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context, _selectedDate),
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                        minimumSize: const Size.fromHeight(54),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      child: const Text(
                        'Confirm',
                        style: TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
