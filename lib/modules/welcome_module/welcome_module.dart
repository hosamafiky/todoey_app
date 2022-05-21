import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todoey_app/constants/colors.dart';
import 'package:todoey_app/modules/modules.dart';
import 'package:todoey_app/shared/network/local/cache_helper/cache_helper.dart';
import 'package:todoey_app/translations/locale_keys.g.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({Key? key}) : super(key: key);

  final nameController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      LocaleKeys.welcomeTitle.tr(),
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 40.0,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        hintText: LocaleKeys.nameHint.tr(),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0),
                          borderSide: const BorderSide(
                            width: 3.0,
                            color: Colors.blueAccent,
                          ),
                        ),
                      ),
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return LocaleKeys.nameError.tr();
                        }
                        return null;
                      },
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  InkWell(
                    onTap: () {
                      if (formKey.currentState!.validate()) {
                        CacheHelper.setString(
                          key: 'username',
                          value: nameController.text,
                        ).then((value) {
                          username = nameController.text;
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeModule(
                                name: nameController.text,
                              ),
                            ),
                            (route) => false,
                          );
                        });
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10.0,
                            horizontal: 15.0,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius:
                                EasyLocalization.of(context)!.currentLocale ==
                                        const Locale('ar')
                                    ? const BorderRadius.horizontal(
                                        right: Radius.circular(10.0),
                                      )
                                    : const BorderRadius.horizontal(
                                        left: Radius.circular(10.0),
                                      ),
                          ),
                          child: Text(
                            LocaleKeys.start.tr(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                            ),
                          ),
                        ),
                        Container(
                          height: 70.0,
                          width: 70.0,
                          padding: const EdgeInsets.all(10.0),
                          decoration: BoxDecoration(
                            color: Colors.blueAccent,
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: const Icon(
                            Icons.arrow_forward,
                            color: Colors.white,
                            size: 40.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
