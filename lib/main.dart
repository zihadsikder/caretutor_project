
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'app/app.dart';
import 'app/core/utils/logging/loggerformain.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await AuthService.init();
  //await StorageService.initialize(); // Initialize Hive
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]).then(
        (value) {
      Logger.init(kReleaseMode ? LogMode.live : LogMode.debug);
      runApp(const MyApp());
    },
  );
}


