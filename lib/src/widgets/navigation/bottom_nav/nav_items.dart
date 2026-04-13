import 'package:flutter/material.dart';
import 'package:stage_0_mobile/src/theme.dart';
import 'package:stage_0_mobile/src/utils/constants.dart';
import 'package:stage_0_mobile/src/widgets/navigation/bottom_nav/nav_item.dart';

class NavItems extends StatelessWidget {
  const NavItems({
    super.key,
    required this.pageIndex,
    required this.onDestinationSelected,
  });

  final int pageIndex;
  final ValueChanged<int> onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(bottomNavbarcons.length, (index) {
        return NavItem(
          icon: bottomNavbarcons[index],
          isSelected: pageIndex == index,
          selectedColor: AppColors.secondary,
          unselectedColor: Colors.grey,
          onTap: () => onDestinationSelected(index),
        );
      }),
    );
  }
}
