import 'package:flutter/material.dart';
import 'package:stage_0_mobile/src/theme.dart';
import 'package:stage_0_mobile/src/widgets/navigation/custom_drawer/drawer_divider.dart';
import 'package:stage_0_mobile/src/widgets/navigation/custom_drawer/drawer_item.dart';
import 'package:stage_0_mobile/src/widgets/navigation/custom_drawer/drawer_stat.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.78,
      child: Container(
        color: const Color(0xFF1A1A2E),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 32, 24, 28),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 52,
                      width: 52,
                      decoration: BoxDecoration(
                        color: AppColors.backgroundColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Icon(
                        Icons.check_rounded,
                        size: 30,
                        color: Color(0xFF1A1A2E),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Stage 0',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -0.4,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Your productivity companion',
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.4),
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Quick stats
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.07),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.08),
                        ),
                      ),
                      child: Row(
                        children: [
                          DrawerStat(label: 'Tasks', value: '3'),
                          DrawerDivider(),
                          DrawerStat(label: 'Done', value: '1'),
                          DrawerDivider(),
                          DrawerStat(label: 'Left', value: '2'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  children: [
                    DrawerItem(
                      icon: Icons.check_circle_outline_rounded,
                      label: 'My Tasks',
                      isActive: true,
                      onTap: () => Navigator.pop(context),
                    ),
                    DrawerItem(
                      icon: Icons.book_outlined,
                      label: 'Journal',
                      onTap: () => Navigator.pop(context),
                    ),
                    DrawerItem(
                      icon: Icons.currency_exchange_rounded,
                      label: 'Converter',
                      onTap: () => Navigator.pop(context),
                    ),
                    DrawerItem(
                      icon: Icons.calendar_month_outlined,
                      label: 'Calendar',
                      onTap: () => Navigator.pop(context),
                    ),
                    DrawerItem(
                      icon: Icons.bar_chart_rounded,
                      label: 'Analytics',
                      onTap: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              Padding(
                padding: const EdgeInsets.fromLTRB(12, 0, 12, 24),
                child: Column(
                  children: [
                    Divider(color: Colors.white.withValues(alpha: 0.08)),
                    const SizedBox(height: 8),
                    DrawerItem(
                      icon: Icons.settings_outlined,
                      label: 'Settings',
                      onTap: () => Navigator.pop(context),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
