import 'package:flutter/material.dart';
import 'package:stage_0_mobile/src/theme.dart';

class DrawerItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const DrawerItem({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    final Color textColor = isActive
        ? AppColors.secondary
        : Colors.white.withValues(alpha: 0.75);

    return Container(
      margin: const EdgeInsets.only(bottom: 2),
      decoration: BoxDecoration(
        color: isActive
            ? AppColors.secondary.withValues(alpha: 0.12)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(14),
      ),
      child: ListTile(
        onTap: onTap,
        dense: true,
        leading: Icon(icon, color: textColor, size: 22),
        title: Text(
          label,
          style: TextStyle(
            color: textColor,
            fontSize: 15,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
        trailing: isActive
            ? Container(
                height: 8,
                width: 8,
                decoration: BoxDecoration(
                  color: AppColors.secondary,
                  shape: BoxShape.circle,
                ),
              )
            : null,
      ),
    );
  }
}
