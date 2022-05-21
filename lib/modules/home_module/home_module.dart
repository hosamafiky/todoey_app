import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoey_app/shared/cubit/cubit.dart';
import 'package:todoey_app/shared/cubit/states.dart';
import 'package:todoey_app/translations/locale_keys.g.dart';
import 'package:todoey_app/widgets/widgets.dart';

class HomeModule extends StatelessWidget {
  const HomeModule({
    Key? key,
    required this.name,
  }) : super(key: key);

  final String? name;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = AppCubit.get(context);
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: _buildAppBar(context, name),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const GoPremium(),
              Container(
                padding: EasyLocalization.of(context)!.currentLocale ==
                        const Locale('ar')
                    ? const EdgeInsets.all(10)
                    : const EdgeInsets.all(15),
                child: Text(
                  LocaleKeys.tasks.tr(),
                  style: const TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Expanded(
                child: Tasks(
                  categories: cubit.generateTasks(),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

AppBar _buildAppBar(context, String? name) {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0.0,
    title: Row(
      children: [
        Container(
          width: 45.0,
          height: 45.0,
          color: Colors.grey[100],
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.asset('assets/images/avatar.jpg'),
          ),
        ),
        const SizedBox(width: 10.0),
        Text(
          '${LocaleKeys.welcome.tr()} $name',
          style: const TextStyle(
            color: Colors.black,
            fontSize: 28.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
    actions: [
      IconButton(
        onPressed: () {
          EasyLocalization.of(context)!.currentLocale == const Locale('en')
              ? EasyLocalization.of(context)!.setLocale(const Locale('ar'))
              : EasyLocalization.of(context)!.setLocale(const Locale('en'));
        },
        icon: Icon(
          EasyLocalization.of(context)!.currentLocale == const Locale('ar')
              ? Icons.change_circle
              : Icons.change_circle_outlined,
        ),
        color: Colors.black,
        iconSize: 35.0,
      ),
    ],
  );
}
