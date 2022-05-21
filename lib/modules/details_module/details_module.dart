// ignore_for_file: unrelated_type_equality_checks

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:todoey_app/models/models.dart';
import 'package:todoey_app/shared/cubit/cubit.dart';
import 'package:todoey_app/shared/cubit/states.dart';
import 'package:todoey_app/translations/locale_keys.g.dart';
import 'package:todoey_app/widgets/widgets.dart';

class DetailsModule extends StatelessWidget {
  const DetailsModule({
    Key? key,
    required this.category,
  }) : super(key: key);

  final TaskCategory category;
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarColor: Colors.black,
      ),
    );
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.black,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              onPressed: () => Navigator.pop(context),
            ),
            centerTitle: true,
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  '${category.title}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24.0,
                  ),
                ),
                const SizedBox(height: 5.0),
                Text(
                  'You\'ve ${category.left! > 1 ? '' : 'a'} ${category.left!} ${category.left! > 1 ? 'tasks' : 'task'} to do!',
                  style: TextStyle(
                    fontSize: 15.0,
                    color: Colors.grey[700],
                  ),
                ),
              ],
            ),
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.more_vert_rounded,
                  size: 30.0,
                ),
                onPressed: () => {},
              ),
            ],
          ),
          body: Container(
            margin: const EdgeInsets.only(top: 10.0),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(40.0),
              ),
            ),
            child: Column(
              children: [
                CustomDatePicker(cubit: cubit),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 20.0,
                  ),
                  child: Text(
                    LocaleKeys.tasks.tr(),
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 22.0,
                      letterSpacing: -1.1,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    itemBuilder: (context, index) {
                      var task = category.tasks![index];
                      if (DateFormat('yyyy-MM-dd').format(task.date!) ==
                          DateFormat('yyyy-MM-dd').format(cubit.selectedDate)) {
                        return _TaskCard(
                          cubit: cubit,
                          task: task,
                          category: category,
                        );
                      } else {
                        return const SizedBox.shrink();
                      }
                    },
                    itemCount: category.tasks!.length,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _TaskCard extends StatelessWidget {
  const _TaskCard({
    Key? key,
    required this.cubit,
    required this.task,
    required this.category,
  }) : super(key: key);
  final AppCubit cubit;
  final Task task;
  final TaskCategory category;
  @override
  Widget build(BuildContext context) {
    return TimelineTile(
      isFirst: true,
      lineXY: 0,
      indicatorStyle: IndicatorStyle(
        indicatorXY: 0,
        width: 20.0,
        height: 20.0,
        indicator: Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            border: Border.all(
              width: 5.0,
              color: category.bgColor!,
            ),
          ),
        ),
      ),
      afterLineStyle: LineStyle(color: category.bgColor!),
      beforeLineStyle: LineStyle(color: category.bgColor!),
      endChild: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 70.0,
                padding: const EdgeInsets.only(left: 5.0, bottom: 5.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(task.startTime!.format(context)),
                    Text(task.endTime!.format(context))
                  ],
                ),
              ),
              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 15.0,
                    vertical: 5.0,
                  ),
                  padding: const EdgeInsets.all(15.0),
                  decoration: BoxDecoration(
                    color: !task.isDone! ? category.bgColor : Colors.grey[300],
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                      bottomRight: Radius.circular(10.0),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              task.title!,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20.0,
                                color: !task.isDone!
                                    ? Colors.black
                                    : Colors.black45,
                              ),
                            ),
                            if (task.isDone!)
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Text(
                                  '(Completed)',
                                  style: TextStyle(
                                    color: !task.isDone!
                                        ? Colors.black
                                        : Colors.black45,
                                  ),
                                ),
                              ),
                            const SizedBox(height: 10.0),
                            Text(
                              '${task.startTime!.format(context)} to ${task.endTime!.format(context)}',
                              style: TextStyle(
                                color: !task.isDone!
                                    ? Colors.grey[700]
                                    : Colors.grey[400],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 30.0,
                        height: 30.0,
                        child: !task.isDone!
                            ? IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: () => cubit.selectTaskId(task.id!),
                                icon: const Icon(
                                  Icons.more_vert_rounded,
                                ),
                                iconSize: 20.0,
                              )
                            : IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: () =>
                                    cubit.deleteTask(taskId: task.id),
                                icon: const Icon(Icons.close),
                                iconSize: 20.0,
                              ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          if (cubit.selectedId == task.id)
            Positioned(
              right: 60.0,
              top: 20.0,
              child: Container(
                width: 100.0,
                height: 50.0,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: const [
                    BoxShadow(
                      offset: Offset(1, 3),
                      blurRadius: 5.0,
                      color: Colors.black54,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: IconButton(
                        icon: const Icon(Icons.check),
                        onPressed: () => cubit.updateTask(task.id!),
                      ),
                    ),
                    const VerticalDivider(color: Colors.black),
                    Expanded(
                      child: IconButton(
                        icon: const Icon(Icons.close),
                        onPressed: () => cubit.deleteTask(taskId: task.id),
                      ),
                    )
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
