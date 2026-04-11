import 'package:flutter/material.dart';

class DrawerDivider extends StatelessWidget {
  const DrawerDivider({super.key});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 28,
      width: 1,
      color: Colors.white.withValues(alpha: 0.1),
    );
  }
}
