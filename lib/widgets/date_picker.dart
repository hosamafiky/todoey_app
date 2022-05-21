import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:todoey_app/shared/cubit/cubit.dart';

class CustomDatePicker extends StatelessWidget {
  const CustomDatePicker({
    Key? key,
    required this.cubit,
  }) : super(key: key);

  final AppCubit cubit;
  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 100.0,
      margin: const EdgeInsets.symmetric(
        vertical: 6.0,
        horizontal: 20.0,
      ),
      child: DatePicker(
        DateTime.now(),
        width: 60.0,
        dayTextStyle: const TextStyle(color: Colors.grey),
        dateTextStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 22.0,
          fontWeight: FontWeight.w500,
        ),
        monthTextStyle: const TextStyle(
          color: Colors.grey,
          fontSize: 12.0,
        ),
        initialSelectedDate: DateTime.now(),
        selectedTextColor: Colors.white,
        selectionColor: Colors.blueAccent,
        onDateChange: (DateTime value) {
          cubit.getSelectedDate(value);
        },
      ),
    );
  }
}
