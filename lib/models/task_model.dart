import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Task {
  int? id;
  String? title;
  String? note;
  DateTime? date;
  TimeOfDay? startTime;
  TimeOfDay? endTime;
  String? taskType;
  bool? isDone;

  Task(
    this.id,
    this.title,
    this.note,
    this.date,
    this.startTime,
    this.endTime,
    this.taskType,
    this.isDone,
  );

  Task.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    note = json['note'];
    date = DateTime.parse(json['date']);
    startTime =
        TimeOfDay.fromDateTime(DateFormat.jm().parse(json['startTime']));
    endTime = TimeOfDay.fromDateTime(DateFormat.jm().parse(json['endTime']));
    taskType = json['taskType'];
    isDone = json['isDone'] == 0 ? false : true;
  }
}
