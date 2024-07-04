import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injector/injector.dart';
import 'package:masa_epico_concrete_manager/utils/sequential_counter_generator.dart';
import 'package:masa_epico_concrete_manager/views/menu.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'database/app_database.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Use this static instance
  final injector = Injector.appInstance;
  await dotenv.load(fileName: "dev.env");

  initializeDb().then((value) => injector.registerSingleton(() => value));
  injector.registerSingleton(() => SequentialFormatter());

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  static const appTitle = 'MASA Control y Calidad';

  @override
  Widget build(BuildContext context) {
    // Initialize ScreenUtil
    ScreenUtil.init(context);

    // Determine if the device is a tablet
    bool isTablet = ScreenUtil().screenWidth > 600;

    // Set orientation based on device type
    if (isTablet) {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeRight,
        DeviceOrientation.landscapeLeft,
      ]);
    } else {
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    }

    return MaterialApp(
      title: appTitle,
      home: MenuPage(title: appTitle, isTablet: isTablet),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      locale: const Locale("es"),
    );
  }
}

Future<AppDatabase> initializeDb() async {
  final database = AppDatabase();
  return database;
}nch v
