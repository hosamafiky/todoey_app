import 'package:dotted_border/dotted_border.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todoey_app/models/task_category_model.dart';
import 'package:todoey_app/modules/modules.dart';
import 'package:todoey_app/translations/locale_keys.g.dart';
import 'package:todoey_app/widgets/widgets.dart';

class Tasks extends StatelessWidget {
  const Tasks({
    Key? key,
    required this.categories,
  }) : super(key: key);

  final List<TaskCategory> categories;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 10.0,
        crossAxisSpacing: 10.0,
      ),
      itemBuilder: (context, index) {
        return categories[index].isLast
            ? _buildAddTask(context)
            : _buildTaskCategory(categories[index], context);
      },
      itemCount: categories.length,
    );
  }
}

Widget _buildAddTask(context) {
  return InkWell(
    onTap: () => showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return Wrap(
            children: const [ModalBottomSheet()],
          );
        }),
    child: DottedBorder(
      borderType: BorderType.RRect,
      radius: const Radius.circular(15.0),
      dashPattern: const [10.0, 10.0],
      color: Colors.grey,
      strokeWidth: 2.0,
      child: Center(
        child: Text(
          '+ ${LocaleKeys.add_button.tr()}',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18.0,
          ),
        ),
      ),
    ),
  );
}

Widget _buildTaskCategory(TaskCategory category, context) {
  return InkWell(
    onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailsModule(
            category: category,
          ),
        )),
    child: Container(
      padding: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        color: category.bgColor,
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            category.iconData,
            color: category.iconColor,
            size: 35.0,
          ),
          EasyLocalization.of(context)!.currentLocale == const Locale('ar')
              ? const SizedBox(height: 20.0)
              : const SizedBox(height: 30.0),
          Text(
            category.title!,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
          EasyLocalization.of(context)!.currentLocale == const Locale('ar')
              ? const SizedBox(height: 20.0)
              : const SizedBox(height: 30.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              _buildTaskCategoryStatus(
                category.btnColor!,
                category.iconColor!,
                '${category.left!} ${LocaleKeys.left.tr()}',
              ),
              const SizedBox(width: 5.0),
              _buildTaskCategoryStatus(
                Colors.white,
                category.iconColor!,
                '${category.done!} ${LocaleKeys.done.tr()}',
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget _buildTaskCategoryStatus(Color bgColor, Color txtColor, String text) {
  return Container(
    padding: const EdgeInsets.symmetric(
      horizontal: 15.0,
      vertical: 10.0,
    ),
    decoration: BoxDecoration(
      color: bgColor,
      borderRadius: BorderRadius.circular(20.0),
    ),
    child: Text(
      text,
      style: TextStyle(
        color: txtColor,
      ),
    ),
  );
}
