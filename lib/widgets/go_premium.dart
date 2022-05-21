import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:todoey_app/translations/locale_keys.g.dart';

class GoPremium extends StatelessWidget {
  const GoPremium({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin:
              EasyLocalization.of(context)!.currentLocale == const Locale('ar')
                  ? const EdgeInsets.all(10)
                  : const EdgeInsets.all(15),
          padding:
              EasyLocalization.of(context)!.currentLocale == const Locale('ar')
                  ? const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 15.0)
                  : const EdgeInsets.fromLTRB(15.0, 15.0, 15.0, 30.0),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  color: Colors.grey[600],
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.star,
                  color: Colors.white,
                  size: 20.0,
                ),
              ),
              const SizedBox(width: 15.0),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    LocaleKeys.go_premium.tr(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    LocaleKeys.go_premium_description.tr(),
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        EasyLocalization.of(context)!.currentLocale == const Locale('ar')
            ? Positioned(
                bottom: 15.0,
                left: 15.0,
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: const Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
                ),
              )
            : Positioned(
                bottom: 15.0,
                right: 15.0,
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  child: const Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
                ),
              ),
      ],
    );
  }
}
