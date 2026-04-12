import 'package:flutter/material.dart';
import 'package:stage_0_mobile/src/helpers.dart';
import 'package:stage_0_mobile/src/widgets/modals/todos/create_todo_modal/modal_label.dart';

class PriorityColorInput extends StatelessWidget {
  final Color? selectedColor;
  final ValueChanged<Color> onColorSelected;

  const PriorityColorInput({
    super.key,
    required this.selectedColor,
    required this.onColorSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ModalLabel(text: 'Priority Color'),
        const SizedBox(height: 12),
        Row(
          children: priorityColorOptions.map((c) {
            final bool sel = selectedColor == c;

            return GestureDetector(
              onTap: () => onColorSelected(c),
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
                    ? const Icon(Icons.check, size: 16, color: Colors.white)
                    : null,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
