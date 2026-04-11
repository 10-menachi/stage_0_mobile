import 'package:flutter/material.dart';
import 'package:stage_0_mobile/src/theme.dart';
import 'package:stage_0_mobile/src/widgets/navigation/bottom_nav/nav_items.dart';

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
        height: 70,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: AppColors.tertiaryColor,
          borderRadius: BorderRadius.circular(28),
          boxShadow: const [
            BoxShadow(
              blurRadius: 16,
              offset: Offset(0, 6),
              color: Colors.black12,
            ),
          ],
        ),
        child: NavItems(
          pageIndex: pageIndex,
          onDestinationSelected: onDestinationSelected,
        ),
      ),
    );
  }
}
