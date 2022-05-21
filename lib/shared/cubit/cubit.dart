//ignore_for_file: avoid_function_literals_in_foreach_calls

import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todoey_app/constants/colors.dart';
import 'package:todoey_app/models/models.dart';
import 'package:todoey_app/shared/cubit/states.dart';
import 'package:todoey_app/translations/locale_keys.g.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  Database? database;
  int personalDoneTasks = 0;
  int personalLeftTasks = 0;
  List<Task> personalTasks = [];
  int workDoneTasks = 0;
  int workLeftTasks = 0;
  List<Task> workTasks = [];
  int healthDoneTasks = 0;
  int healthLeftTasks = 0;
  List<Task> healthTasks = [];

  void createDataBase() {
    openDatabase('todoey.db', version: 1, onCreate: (database, version) {
      database
          .execute(
              'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, note TEXT, date TEXT, startTime TEXT, endTime TEXT, type TEXT, isDone BIT)')
          .then((value) {
        log('Table created successfully!');
      }).catchError((error) {
        log('Error in creating table : ${error.toString()}');
      });
    }, onOpen: (database) {
      log('database opened!');
      getDataFromDatabase(database);
    }).then((value) {
      database = value;
      emit(AppDatabaseCreateSuccessState());
    }).catchError((error) {
      log(error.toString());
      emit(AppDatabaseCreateErrorState());
    });
  }

  Future insertToDatabase({
    required String title,
    required String note,
    required String date,
    required String startTime,
    required String endTime,
    required String type,
    bool? isDone = false,
  }) {
    emit(AppInsertToDatabaseLoadingState());
    return database!.transaction((txn) async {
      await txn.rawInsert(
          'INSERT INTO tasks (title, note, date, startTime, endTime, type, isDone) VALUES ("$title", "$note", "$date", "$startTime", "$endTime", "$type", $isDone)');
    }).then((value) {
      emit(AppInsertToDatabaseSuccessState());
      getDataFromDatabase(database!);
    }).catchError((error) {
      log(error.toString());
      emit(AppInsertToDatabaseErrorState());
    });
  }

  List<TaskCategory> generateTasks() {
    return [
      TaskCategory(
        iconData: Icons.person_rounded,
        title: LocaleKeys.personal_category.tr(),
        bgColor: kYellowLight,
        iconColor: kYellowDark,
        btnColor: kYellow,
        left: personalLeftTasks,
        done: personalDoneTasks,
        tasks: personalTasks,
      ),
      TaskCategory(
        iconData: Icons.cases_rounded,
        title: LocaleKeys.work_category.tr(),
        bgColor: kRedLight,
        iconColor: kRedDark,
        btnColor: kRed,
        left: workLeftTasks,
        done: workDoneTasks,
        tasks: workTasks,
      ),
      TaskCategory(
        iconData: Icons.favorite_rounded,
        title: LocaleKeys.health_category.tr(),
        bgColor: kBlueLight,
        iconColor: kBlueDark,
        btnColor: kBlue,
        left: healthLeftTasks,
        done: healthDoneTasks,
        tasks: healthTasks,
      ),
      TaskCategory(
        isLast: true,
      ),
    ];
  }

  void getDataFromDatabase(Database database) async {
    emit(AppGetDataFromDatabaseLoadingState());
    await database
        .rawQuery('SELECT * FROM tasks ORDER BY startTime DESC')
        .then((value) {
      personalDoneTasks = 0;
      personalLeftTasks = 0;
      personalTasks = [];
      workDoneTasks = 0;
      workLeftTasks = 0;
      workTasks = [];
      healthDoneTasks = 0;
      healthLeftTasks = 0;
      healthTasks = [];
      value.forEach((element) {
        Task task = Task.fromJson(element);
        if (element['type'] == 'Personal') {
          if (!task.date!.isBefore(DateTime.parse(
              DateFormat('yyyy-MM-dd').format(DateTime.now())))) {
            personalTasks.add(task);
            if (task.isDone == false) {
              personalLeftTasks++;
            } else {
              personalDoneTasks++;
            }
          }
        } else if (element['type'] == 'Work') {
          if (!task.date!.isBefore(DateTime.parse(
              DateFormat('yyyy-MM-dd').format(DateTime.now())))) {
            workTasks.add(task);
            if (task.isDone == false) {
              workLeftTasks++;
            } else {
              workDoneTasks++;
            }
          }
        } else if (element['type'] == 'Health') {
          if (!task.date!.isBefore(DateTime.now())) {
            healthTasks.add(task);
            if (task.isDone == false) {
              healthLeftTasks++;
            } else {
              healthDoneTasks++;
            }
          }
        }
      });
      emit(AppGetDataFromDatabaseSuccessState());
    }).catchError((error) {
      log(error.toString());
      emit(AppGetDataFromDatabaseErrorState());
    });
  }

  void updateTask(int id) async {
    await database!
        .rawUpdate('UPDATE tasks SET isDone=True WHERE id=$id')
        .then((value) {
      selectedId = 0;
      getDataFromDatabase(database!);
      //emit(AppUpdateDatabaseSuccessState());
    }).catchError((error) {
      log(error.toString());
      emit(AppUpdateDatabaseErrorState());
    });
  }

  void dropTable({String? type}) async {
    await database!.delete('tasks', where: 'type = "$type"').then((value) {
      emit(AppCleanDatabaseSuccessState());
      getDataFromDatabase(database!);
    });
  }

  void deleteTask({int? taskId}) async {
    await database!
        .rawDelete('DELETE FROM tasks WHERE id = $taskId')
        .then((value) {
      getDataFromDatabase(database!);
    });
  }

  DateTime selectedDate = DateTime.now();
  void getSelectedDate(DateTime date) {
    selectedDate = date;
    emit(AppSelectScrollDateState());
  }

  int selectedId = 0;
  void selectTaskId(int id) {
    selectedId == id ? selectedId = 0 : selectedId = id;
    emit(AppSelectTaskState());
  }
}
