import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoey_app/constants/colors.dart';
import 'package:todoey_app/modules/modules.dart';
import 'package:todoey_app/shared/cubit/bloc_observer.dart';
import 'package:todoey_app/shared/cubit/cubit.dart';
import 'package:todoey_app/shared/network/local/cache_helper/cache_helper.dart';
import 'package:todoey_app/translations/codegen_loader.g.dart';

void main() {
  BlocOverrides.runZoned(
    () async {
      WidgetsFlutterBinding.ensureInitialized();
      await EasyLocalization.ensureInitialized();
      await CacheHelper.init();
      username = CacheHelper.getString(key: 'username');
      runApp(
        EasyLocalization(
          path: 'assets/translations/',
          supportedLocales: const [Locale('en', ''), Locale('ar', '')],
          fallbackLocale: const Locale('en', ''),
          assetLoader: const CodegenLoader(),
          child: const MyApp(),
        ),
      );
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return BlocProvider(
      create: (context) => AppCubit()..createDataBase(),
      child: MaterialApp(
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        localizationsDelegates: context.localizationDelegates,
        debugShowCheckedModeBanner: false,
        title: 'Flutter Todoey App',
        home: username == '' || username == null
            ? WelcomeScreen()
            : HomeModule(name: username),
      ),
    );
  }
}
