import 'package:flutter/material.dart';

class CustomTimePicker extends StatefulWidget {
  final TimeOfDay initialTime;

  const CustomTimePicker({super.key, required this.initialTime});

  @override
  State<CustomTimePicker> createState() => _CustomTimePickerState();
}

class _CustomTimePickerState extends State<CustomTimePicker> {
  late int _hour;
  late int _minute;
  late String _period;

  final FixedExtentScrollController _hourController =
      FixedExtentScrollController();
  final FixedExtentScrollController _minuteController =
      FixedExtentScrollController();
  final FixedExtentScrollController _periodController =
      FixedExtentScrollController();

  @override
  void initState() {
    super.initState();

    final hour = widget.initialTime.hour;
    final minute = widget.initialTime.minute;

    _period = hour >= 12 ? 'PM' : 'AM';

    final hour12 = hour == 0
        ? 12
        : hour > 12
        ? hour - 12
        : hour;

    _hour = hour12;
    _minute = minute;

    _hourController.jumpToItem(_hour - 1);
    _minuteController.jumpToItem(_minute);
    _periodController.jumpToItem(_period == 'AM' ? 0 : 1);
  }

  @override
  void dispose() {
    _hourController.dispose();
    _minuteController.dispose();
    _periodController.dispose();
    super.dispose();
  }

  TimeOfDay _buildTime() {
    int hour24;

    if (_period == 'AM') {
      hour24 = _hour == 12 ? 0 : _hour;
    } else {
      hour24 = _hour == 12 ? 12 : _hour + 12;
    }

    return TimeOfDay(hour: hour24, minute: _minute);
  }

  String _formatPreview() {
    final minuteText = _minute.toString().padLeft(2, '0');
    return '$_hour:$minuteText $_period';
  }

  Widget _buildPickerColumn({
    required FixedExtentScrollController controller,
    required int itemCount,
    required String Function(int index) labelBuilder,
    required ValueChanged<int> onSelectedItemChanged,
  }) {
    return Expanded(
      child: Container(
        height: 220,
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.black12),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 52,
              margin: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.black,
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            ListWheelScrollView.useDelegate(
              controller: controller,
              itemExtent: 52,
              perspective: 0.003,
              diameterRatio: 1.25,
              physics: const FixedExtentScrollPhysics(),
              onSelectedItemChanged: onSelectedItemChanged,
              childDelegate: ListWheelChildBuilderDelegate(
                childCount: itemCount,
                builder: (context, index) {
                  return Center(
                    child: Text(
                      labelBuilder(index),
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  );
                },
              ),
            ),
            IgnorePointer(
              child: Column(
                children: [
                  Container(
                    height: 84,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.white,
                          Colors.white.withValues(alpha: 0.0),
                        ],
                      ),
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(18),
                      ),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    height: 84,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.white.withValues(alpha: 0.0),
                          Colors.white,
                        ],
                      ),
                      borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
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
                      'Select time',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        height: 1,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      final now = TimeOfDay.now();
                      final hour12 = now.hour == 0
                          ? 12
                          : now.hour > 12
                          ? now.hour - 12
                          : now.hour;

                      setState(() {
                        _hour = hour12;
                        _minute = now.minute;
                        _period = now.hour >= 12 ? 'PM' : 'AM';
                      });

                      _hourController.jumpToItem(_hour - 1);
                      _minuteController.jumpToItem(_minute);
                      _periodController.jumpToItem(_period == 'AM' ? 0 : 1);
                    },
                    child: const Text(
                      'Now',
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
              const SizedBox(height: 20),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  vertical: 14,
                  horizontal: 16,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: Colors.black12),
                ),
                child: Text(
                  _formatPreview(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Row(
                children: [
                  _buildPickerColumn(
                    controller: _hourController,
                    itemCount: 12,
                    labelBuilder: (index) => '${index + 1}',
                    onSelectedItemChanged: (index) {
                      setState(() {
                        _hour = index + 1;
                      });
                    },
                  ),
                  const SizedBox(width: 10),
                  _buildPickerColumn(
                    controller: _minuteController,
                    itemCount: 60,
                    labelBuilder: (index) => index.toString().padLeft(2, '0'),
                    onSelectedItemChanged: (index) {
                      setState(() {
                        _minute = index;
                      });
                    },
                  ),
                  const SizedBox(width: 10),
                  _buildPickerColumn(
                    controller: _periodController,
                    itemCount: 2,
                    labelBuilder: (index) => index == 0 ? 'AM' : 'PM',
                    onSelectedItemChanged: (index) {
                      setState(() {
                        _period = index == 0 ? 'AM' : 'PM';
                      });
                    },
                  ),
                ],
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
                      onPressed: () => Navigator.pop(context, _buildTime()),
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
