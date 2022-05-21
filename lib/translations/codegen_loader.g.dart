// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader {
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String, dynamic> ar = {
    "welcomeTitle": "مرحبًا",
    "nameHint": "ماهو إسمك ؟",
    "nameError": "دعنا نعرف إسمك",
    "start": "إبدأ",
    "welcome": "مرحبًا بك يا",
    "personal_category": "شخصي",
    "work_category": "العمل",
    "health_category": "صحي",
    "left": "متبقي",
    "done": "تم",
    "add_button": "إضافة",
    "go_premium": "احصل على الاشتراك الرئيسي!",
    "go_premium_description": "احصل على وصول غير محدود\nإلى جميع ميزاتنا.",
    "tasks": "المهام",
    "title": "العنوان",
    "titleHint": "أدخل العنوان هنا",
    "titleError": "العنوان مطلوب",
    "note": "ملحوطة",
    "noteHint": "أدخل ملحوظة هنا",
    "date": "التاريخ",
    "dateError": "التاريخ مطلوب",
    "startTime": "وقت البدء",
    "startTimeError": "وقت البدء مطلوب",
    "endTime": "وقت الانتهاء",
    "endTimeError": "وقت الانتهاء مطلوب",
    "task_type": "نوع المهمة",
    "add": "إضافة"
  };
  static const Map<String, dynamic> en = {
    "welcomeTitle": "WELCOME",
    "nameHint": "What's your name?",
    "nameError": "Let us know your name",
    "start": "START",
    "welcome": "Hi,",
    "personal_category": "Personal",
    "work_category": "Work",
    "health_category": "Health",
    "left": "left",
    "done": "done",
    "add_button": "Add",
    "go_premium": "Go Premium!",
    "go_premium_description": "Get unlimited access\nto all our features. ",
    "tasks": "Tasks",
    "title": "Title",
    "titleHint": "Enter title here",
    "titleError": "Title is required",
    "note": "Note",
    "noteHint": "Enter Note here",
    "date": "Date",
    "dateError": "Date is required",
    "startTime": "Start Time",
    "startTimeError": "Start Time is required",
    "endTime": "End Time",
    "endTimeError": "End Time is required",
    "task_type": "Task Type",
    "add": "Add"
  };
  static const Map<String, Map<String, dynamic>> mapLocales = {
    "ar": ar,
    "en": en
  };
}
