import 'package:flutter/material.dart';
import 'package:stage_0_mobile/src/screens/currency_converter_screen.dart';
import 'package:stage_0_mobile/src/screens/journaling_screen.dart';
import 'package:stage_0_mobile/src/screens/todo_list_screen.dart';
import 'package:stage_0_mobile/src/widgets/navigation/bottom_nav/custom_bottom_navigation_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _pageIndex = 0;

  void _nextPage(int index) {
    setState(() {
      _pageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomBottomNavigationBar(
        pageIndex: _pageIndex,
        onDestinationSelected: _nextPage,
      ),
      body: <Widget>[
        const TodoListScreen(),
        const CurrencyConverterScreen(),
        const JournalingScreen(),
      ][_pageIndex],
    );
  }
}
