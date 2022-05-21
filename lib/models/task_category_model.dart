import 'package:flutter/material.dart';
import 'package:todoey_app/models/models.dart';

class TaskCategory {
  final IconData? iconData;
  final String? title;
  final Color? bgColor;
  final Color? iconColor;
  final Color? btnColor;
  final int? left;
  final int? done;
  final List<Task>? tasks;
  final bool isLast;

  TaskCategory({
    this.iconData,
    this.title,
    this.bgColor,
    this.iconColor,
    this.btnColor,
    this.left,
    this.done,
    this.tasks,
    this.isLast = false,
  });
}
