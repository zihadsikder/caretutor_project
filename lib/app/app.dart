import 'package:caretutor_project/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'core/utils/constants/app_sizer.dart';
import 'core/utils/constants/app_sizes.dart';
import 'core/utils/theme/theme.dart';

class PlatformUtils {
  static bool get isIOS =>
      foundation.defaultTargetPlatform == TargetPlatform.iOS;

  static bool get isAndroid =>
      foundation.defaultTargetPlatform == TargetPlatform.android;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    AppSizes().init(context);
    return Sizer(
      builder: (context, orientation, deviceType) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Application",
          initialRoute: AppPages.INITIAL,
          getPages: AppPages.routes,
          themeMode: ThemeMode.system,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          defaultTransition:
          PlatformUtils.isIOS ? Transition.cupertino : Transition.fade,
          locale: Get.deviceLocale,
          builder:
              (context, child) =>
          PlatformUtils.isIOS
              ? CupertinoTheme(
            data: const CupertinoThemeData(),
            child: child!,
          )
              : child!,
        );
      },
    );
  }
}
