import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoey_app/shared/cubit/cubit.dart';
import 'package:todoey_app/shared/cubit/states.dart';
import 'package:todoey_app/translations/locale_keys.g.dart';

class ModalBottomSheet extends StatefulWidget {
  const ModalBottomSheet({Key? key}) : super(key: key);

  @override
  State<ModalBottomSheet> createState() => _ModalBottomSheetState();
}

class _ModalBottomSheetState extends State<ModalBottomSheet> {
  final titleController = TextEditingController();

  final noteController = TextEditingController();

  final dateController = TextEditingController();

  final startTimeController = TextEditingController();

  final endTimeController = TextEditingController();

  final taskTypeController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  var dropDownValue = LocaleKeys.personal_category.tr();

  List<String> taskTypeOptions = [
    LocaleKeys.personal_category.tr(),
    LocaleKeys.work_category.tr(),
    LocaleKeys.health_category.tr(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = AppCubit.get(context);
          return Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 12.0, vertical: 15.0),
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(30.0),
              ),
            ),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      width: double.infinity,
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20.0),
                              color: Colors.black26,
                            ),
                            height: 5.0,
                            width: 200.0,
                          ),
                          const SizedBox(height: 10.0),
                          Center(
                              child: Text(
                            '${LocaleKeys.add.tr()} ${LocaleKeys.tasks.tr()}'
                                .toUpperCase(),
                            style: const TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                        ],
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    Text(
                      LocaleKeys.title.tr(),
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    TextFormField(
                      controller: titleController,
                      decoration: InputDecoration(
                        hintText: LocaleKeys.titleHint.tr(),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                      ),
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return LocaleKeys.titleError.tr();
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 5.0),
                    Text(
                      LocaleKeys.note.tr(),
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    TextFormField(
                      controller: noteController,
                      decoration: InputDecoration(
                        hintText: LocaleKeys.noteHint.tr(),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    Text(
                      LocaleKeys.date.tr(),
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    TextFormField(
                      controller: dateController,
                      readOnly: true,
                      onTap: () => showDatePicker(
                        context: context,
                        helpText: 'SELECT TASK DATE',
                        confirmText: 'Select',
                        cancelText: 'Not now',
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2030),
                      ).then((value) {
                        if (value != null) {
                          dateController.text =
                              DateFormat('yyyy-MM-dd').format(value);
                        }
                      }),
                      decoration: InputDecoration(
                        suffixIcon: const Icon(Icons.date_range),
                        hintText:
                            DateFormat('yyyy-MM-dd').format(DateTime.now()),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10.0),
                          ),
                        ),
                      ),
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return LocaleKeys.dateError.tr();
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 5.0),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                LocaleKeys.startTime.tr(),
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5.0),
                              TextFormField(
                                controller: startTimeController,
                                readOnly: true,
                                onTap: () => showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                ).then((value) => {
                                      if (value != null)
                                        {
                                          startTimeController.text =
                                              value.format(context)
                                        }
                                    }),
                                decoration: InputDecoration(
                                  suffixIcon: const Icon(Icons.timer_outlined),
                                  hintText:
                                      DateFormat.jm().format(DateTime.now()),
                                  border: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.0),
                                    ),
                                  ),
                                ),
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return LocaleKeys.startTimeError.tr();
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 15.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                LocaleKeys.endTime.tr(),
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 5.0),
                              TextFormField(
                                controller: endTimeController,
                                readOnly: true,
                                onTap: () => showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                ).then((value) => {
                                      if (value != null)
                                        {
                                          endTimeController.text =
                                              value.format(context)
                                        }
                                    }),
                                decoration: InputDecoration(
                                  suffixIcon: const Icon(Icons.timer_outlined),
                                  hintText: DateFormat.jm().format(
                                    DateTime.now().add(
                                      const Duration(hours: 1),
                                    ),
                                  ),
                                  border: const OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.0),
                                    ),
                                  ),
                                ),
                                validator: (String? value) {
                                  if (value!.isEmpty) {
                                    return LocaleKeys.endTimeError.tr();
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10.0),
                    Text(
                      LocaleKeys.taskType.tr(),
                      style: const TextStyle(
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 5.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: FormField<String>(
                            builder: (FormFieldState<String> state) {
                              return InputDecorator(
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(10.0),
                                    ),
                                  ),
                                ),
                                child: DropdownButtonHideUnderline(
                                    child: DropdownButton(
                                  value: dropDownValue,
                                  isDense: true,
                                  items: taskTypeOptions
                                      .map(
                                        (item) => DropdownMenuItem(
                                          value: item,
                                          child: Text(item),
                                        ),
                                      )
                                      .toList(),
                                  onChanged: (String? value) {
                                    setState(() {
                                      dropDownValue = value!;
                                    });
                                  },
                                )),
                              );
                            },
                          ),
                        ),
                        const SizedBox(width: 10.0),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 15.0,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: TextButton(
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                cubit
                                    .insertToDatabase(
                                  title: titleController.text,
                                  note: noteController.text == ''
                                      ? 'Note isn\'t specified yet.'
                                      : noteController.text,
                                  date: dateController.text,
                                  startTime: startTimeController.text,
                                  endTime: endTimeController.text,
                                  type: dropDownValue,
                                )
                                    .then((value) {
                                  Navigator.pop(context);
                                });
                              }
                            },
                            child: Text(
                              LocaleKeys.add.tr().toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
