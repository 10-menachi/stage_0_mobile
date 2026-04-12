import 'package:flutter/material.dart';

class ModalHeader extends StatelessWidget {
  const ModalHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 14, 16, 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(32)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Center(
            child: Container(
              height: 4,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.circular(999),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Text(
                'New Task',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.4,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: Container(
                  height: 36,
                  width: 36,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF0F0F0),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.close,
                    size: 18,
                    color: Colors.black54,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
