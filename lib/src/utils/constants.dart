import 'package:flutter/material.dart';

final List<IconData> bottomNavbarcons = [
  Icons.checklist,
  Icons.currency_exchange,
  Icons.library_books,
];

final List<Map<String, dynamic>> todos = [
  {
    'title': 'Finish mobile dashboard UI',
    'description':
        'Polish the task cards and align spacing properly. Make sure everything is pixel-perfect before the design review.',
    'date': DateTime.now(),
    'startTime': '09:00 AM',
    'endTime': '10:30 AM',
    'priorityColor': const Color(0xFF7B6EF6),
    'category': 'Work',
    'done': false,
  },
  {
    'title': 'Prepare Flutter navigation refactor',
    'description':
        'Clean up the custom bottom navigation and reduce repetition. Extract reusable components.',
    'date': DateTime.now(),
    'startTime': '11:00 AM',
    'endTime': '12:00 PM',
    'priorityColor': const Color(0xFF2196F3),
    'category': 'Work',
    'done': false,
  },
  {
    'title': 'Write journal flow ideas',
    'description':
        'Draft how journaling and todos can work together in one app. Think about transitions and shared state.',
    'date': DateTime.now(),
    'startTime': '03:00 PM',
    'endTime': '04:00 PM',
    'priorityColor': const Color(0xFF10B981),
    'category': 'Personal',
    'done': true,
  },
];
