import 'package:flutter/material.dart';

class CreateTaskFormData {
  final String title;
  final String description;
  final Color priorityColor;
  final DateTime date;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final String category;
  final String remindBefore;

  const CreateTaskFormData({
    required this.title,
    required this.description,
    required this.priorityColor,
    required this.date,
    required this.startTime,
    required this.endTime,
    required this.category,
    required this.remindBefore,
  });
}
