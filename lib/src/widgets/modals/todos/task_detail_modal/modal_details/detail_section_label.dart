import 'package:flutter/material.dart';

class DetailSectionLabel extends StatelessWidget {
  final String text;
  const DetailSectionLabel({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: Colors.black45,
        letterSpacing: 0.4,
      ),
    );
  }
}
