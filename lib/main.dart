import 'package:dandia_driver/app.dart';
import 'package:dandia_driver/core/locator.dart';
import 'package:dandia_driver/core/models/app_user_model.dart';
import 'package:dandia_driver/core/models/car_model.dart';
import 'package:dandia_driver/firebase_options.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await setupLocator();

  Hive.registerAdapter(AppUserModelAdapter());
  Hive.registerAdapter(CarModelAdapter());
  if (!kIsWeb) {
    final appDocumentDirectory = await getApplicationDocumentsDirectory();
    Hive.init(appDocumentDirectory.path);
  }

  SystemChannels.textInput.invokeMethod('TextInput.hide');
  runApp(const MyApp());
}
