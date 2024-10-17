// ignore_for_file: avoid_print
import 'dart:developer';
import 'package:delivery/common/utils/global.dart';
import 'package:delivery/myapp.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:timeago/timeago.dart' as timeago;

// Use This Command To Generate Transitions
// dart run easy_localization:generate -S "assets/translations" -O "lib/translations" -o "locale_keys.g.dart" -f keys

void main() async {

  setup();

  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  timeago.setLocaleMessages('ar', timeago.ArMessages());

  FlutterError.onError = (FlutterErrorDetails details) {
    // Handle the error here (e.g., log it, show an error screen)
    print("Caught Flutter Error: ${details.exception}");
    log("Caught Flutter Error: ${details.exception}");
    FlutterError.presentError(details); // Optionally show the default error screen
  };

  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale('ar', ''),
        Locale('en', ''),
      ],
      path: 'assets/translations',
      startLocale: const Locale('en', ''),
      fallbackLocale: const Locale('en', ''),
      child: const MyApp(),
    )
  );
}