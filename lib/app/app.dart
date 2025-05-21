import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' as foundation;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:go_router/go_router.dart';

import 'core/utils/constants/app_sizer.dart';
import 'core/utils/constants/app_sizes.dart';
import 'core/utils/theme/theme.dart';
import 'modules/add_note/bindings/add_note_binding.dart';
import 'modules/add_note/views/add_note_view.dart';
import 'services/auth_services.dart';

import 'modules/auth/bindings/auth_binding.dart';
import 'modules/auth/views/auth_view.dart';
import 'modules/home/bindings/home_binding.dart';
import 'modules/home/views/home_view.dart';
import 'modules/splash/bindings/splash_binding.dart';
import 'modules/splash/views/splash_view.dart';

class PlatformUtils {
  static bool get isIOS => foundation.defaultTargetPlatform == TargetPlatform.iOS;
  static bool get isAndroid => foundation.defaultTargetPlatform == TargetPlatform.android;
}

class MyApp extends StatelessWidget {
  MyApp({super.key}) {
    SplashBinding().dependencies();
    AuthBinding().dependencies();
    HomeBinding().dependencies();
  }

  final _router = GoRouter(
    initialLocation: '/auth',
    routes: [
      GoRoute(
        path: '/',
        name: 'splash',
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: '/auth',
        name: 'auth',
        builder: (context, state) => AuthView(),
      ),
      GoRoute(
        path: '/home',
        name: 'home',
        builder: (context, state) => const HomeView(),
      ),
      GoRoute(
        path: '/add-note',
        builder: (context, state) {
          Get.put(AddNoteBinding().dependencies());
          return AddNoteView();
        },
      ),
      GoRoute(
        path: '/edit-note/:id',
        builder: (context, state) {
          final noteId = state.pathParameters['id']!;
          Get.put(AddNoteBinding().dependencies());
          return AddNoteView(noteId: noteId);
        },
      ),
    ],
    redirect: (context, state) {
      final bool isLoggedIn = AuthService.hasToken();
      final bool isGoingToLogin = state.matchedLocation == '/auth';
      final bool isGoingToSplash = state.matchedLocation == '/';

      if (!isLoggedIn && !isGoingToLogin && !isGoingToSplash) {
        return '/auth';
      }

      if (isLoggedIn && isGoingToLogin) {
        return '/home';
      }

      return null;
    },
    errorBuilder: (context, state) => Scaffold(
      body: Center(child: Text('Routing Error: ${state.error}')),
    ),
  );

  @override
  Widget build(BuildContext context) {
    AppSizes().init(context);
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: "Notes App",
          themeMode: ThemeMode.system,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          routerConfig: _router,
          builder: (context, child) {
            final content = child!;
            return PlatformUtils.isIOS
                ? CupertinoTheme(data: const CupertinoThemeData(), child: content)
                : Theme(data: Theme.of(context).copyWith(useMaterial3: true), child: content);
          },
        );
      },
    );
  }
}
