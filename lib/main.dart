import 'package:flutter/material.dart';
import 'package:stage_0_mobile/src/pages/home_page.dart';

void main(List<String> args) {
  runApp(UtilityApplication());
}

class UtilityApplication extends StatelessWidget {
  const UtilityApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: HomePage());
  }
}
