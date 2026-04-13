import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stage_0_mobile/src/pages/home_page.dart';
import 'package:stage_0_mobile/src/theme.dart';

void main(List<String> args) {
  runApp(ProviderScope(child: UtilityApplication()));
}

class UtilityApplication extends StatelessWidget {
  const UtilityApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: HomePage(), theme: appTheme);
  }
}
