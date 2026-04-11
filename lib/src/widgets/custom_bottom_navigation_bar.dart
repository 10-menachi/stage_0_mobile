import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatefulWidget {
  final int pageIndex;
  final Function(int) onDestinationSelected;
  const CustomBottomNavigationBar({
    super.key,
    required this.pageIndex,
    required this.onDestinationSelected,
  });

  @override
  State<CustomBottomNavigationBar> createState() => _BottomNavigationBarState();
}

class _BottomNavigationBarState extends State<CustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      onDestinationSelected: widget.onDestinationSelected,
      indicatorColor: Colors.amber,
      selectedIndex: widget.pageIndex,
      destinations: const <Widget>[
        NavigationDestination(
          selectedIcon: Icon(Icons.home),
          icon: Icon(Icons.checklist),
          label: 'Todo List',
        ),
        NavigationDestination(
          icon: Icon(Icons.currency_exchange),
          label: 'Currency Converter',
        ),
        NavigationDestination(
          icon: Icon(Icons.library_books),
          label: 'Journaling',
        ),
      ],
    );
  }
}
