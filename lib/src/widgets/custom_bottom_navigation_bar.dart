import 'package:flutter/material.dart';
import 'package:stage_0_mobile/src/theme.dart';
import 'package:stage_0_mobile/src/widgets/nav_item.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int pageIndex;
  final ValueChanged<int> onDestinationSelected;

  const CustomBottomNavigationBar({
    super.key,
    required this.pageIndex,
    required this.onDestinationSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: const EdgeInsets.fromLTRB(24, 0, 24, 16),
      child: Container(
        height: 70, // 🔥 reduced from 86
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.tertiaryColor,
          borderRadius: BorderRadius.circular(28), // slightly tighter
          boxShadow: const [
            BoxShadow(
              blurRadius: 16,
              offset: Offset(0, 6),
              color: Colors.black12,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            NavItem(
              icon: Icons.checklist,
              isSelected: pageIndex == 0,
              selectedColor: AppColors.secondary,
              unselectedColor: Colors.grey,
              onTap: () => onDestinationSelected(0),
            ),
            NavItem(
              icon: Icons.currency_exchange,
              isSelected: pageIndex == 1,
              selectedColor: AppColors.secondary,
              unselectedColor: Colors.grey,
              onTap: () => onDestinationSelected(1),
            ),
            NavItem(
              icon: Icons.library_books,
              isSelected: pageIndex == 2,
              selectedColor: AppColors.secondary,
              unselectedColor: Colors.grey,
              onTap: () => onDestinationSelected(2),
            ),
          ],
        ),
      ),
    );
  }
}
