import 'package:flutter/material.dart';
import 'package:stage_0_mobile/src/widgets/modals/todos/create_todo_modal/modal_label.dart';

class CategoryInput extends StatelessWidget {
  final String? selectedCategory;
  final Color selectedColor;
  final ValueChanged<String> onCategorySelected;

  const CategoryInput({
    super.key,
    required this.selectedCategory,
    required this.selectedColor,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    const categories = ['Work', 'Personal', 'Health', 'Study'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ModalLabel(text: 'Category'),
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: categories.map((cat) {
            final bool sel = selectedCategory == cat;

            return GestureDetector(
              onTap: () => onCategorySelected(cat),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 9,
                ),
                decoration: BoxDecoration(
                  color: sel ? selectedColor : Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: sel ? selectedColor : Colors.black12,
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
      ],
    );
  }
}
