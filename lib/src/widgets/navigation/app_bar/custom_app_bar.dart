import 'package:flutter/material.dart';
import 'package:stage_0_mobile/src/theme.dart';

class CustomAppBar extends StatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;
  final VoidCallback openCreateTodoModal;
  const CustomAppBar({
    super.key,
    required this.scaffoldKey,
    required this.openCreateTodoModal,
  });

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () => widget.scaffoldKey.currentState?.openDrawer(),
          child: Container(
            height: 46,
            width: 46,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: const Icon(Icons.menu, size: 22),
          ),
        ),
        const Spacer(),
        IconButton(
          onPressed: widget.openCreateTodoModal,
          icon: const Icon(Icons.add),
          style: IconButton.styleFrom(
            backgroundColor: AppColors.tertiaryColor,
            foregroundColor: Colors.black,
            padding: const EdgeInsets.all(14),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
      ],
    );
  }
}
