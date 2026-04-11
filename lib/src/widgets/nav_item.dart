import 'package:flutter/material.dart';

class NavItem extends StatelessWidget {
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;
  final Color selectedColor;
  final Color unselectedColor;

  const NavItem({
    super.key,
    required this.icon,
    required this.isSelected,
    required this.onTap,
    required this.selectedColor,
    required this.unselectedColor,
  });

  @override
  Widget build(BuildContext context) {
    final Color iconColor = isSelected ? selectedColor : unselectedColor;

    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 26, // 🔥 reduced from 30
              color: iconColor,
            ),
            const SizedBox(height: 6), // 🔥 reduced spacing
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: 3, // 🔥 thinner indicator
              width: isSelected ? 32 : 0, // 🔥 shorter line
              decoration: BoxDecoration(
                color: selectedColor,
                borderRadius: BorderRadius.circular(999),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
