import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injector/injector.dart';
import 'package:masa_epico_concrete_manager/utils/sequential_counter_generator.dart';
import 'package:masa_epico_concrete_manager/views/menu.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  // Use this static instance
  final injector = Injector.appInstance;
  await dotenv.load(fileName: "dev.env");

  initializeDb().then((value) => injector.registerSingleton(() => value));
  injector.registerSingleton(() => SequentialIdGenerator());

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  static const appTitle = 'MASA Control y Calidad';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      home: const MenuPage(title: appTitle),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      locale: const Locale("es"),
    );
  }
}

Future<Database> initializeDb() async {
  String path = join(await getDatabasesPath(), dotenv.get("DATABASE_PATH"));
  await deleteDatabase(path);
  return openDatabase(
    path,
    onCreate: (db, version) async {
      await db.execute(
          "CREATE TABLE IF NOT EXISTS customers (id INTEGER PRIMARY KEY AUTOINCREMENT, identifier VARCHAR(255), company_name VARCHAR(255));");
      await db.execute(
          "CREATE TABLE IF NOT EXISTS site_residents (id INTEGER PRIMARY KEY AUTOINCREMENT, first_name VARCHAR(255), last_name VARCHAR(255), job_position VARCHAR(255));");
      await db.execute(
          "CREATE TABLE IF NOT EXISTS project_sites (id INTEGER PRIMARY KEY AUTOINCREMENT, site_name VARCHAR(255), site_resident_id INTEGER REFERENCES site_residents(id), customer_id INTEGER REFERENCES customers(id));");
    },
    version: 1,
  );
}
