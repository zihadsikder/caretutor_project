import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:get_storage/get_storage.dart';

import 'firebase_options.dart';
import 'app/app.dart';
import 'app/core/utils/logging/loggerformain.dart';
import 'app/services/auth_services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e, stack) {
    debugPrint('Firebase init failed: $e\n$stack');
    // Optionally show an error screen or exit the app
    runApp(ErrorApp(error: 'Failed to initialize Firebase: $e'));
    return;
  }

  await AuthService.init();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  Logger.init(kReleaseMode ? LogMode.live : LogMode.debug);

  runApp(MyApp());
}

class ErrorApp extends StatelessWidget {
  final String error;
  const ErrorApp({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Initialization Error: $error'),
        ),
      ),
    );
  }
}