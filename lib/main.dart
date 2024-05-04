import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injector/injector.dart';
import 'package:masa_epico_concrete_manager/utils/sequential_counter_generator.dart';
import 'package:masa_epico_concrete_manager/views/menu.dart';
import 'package:pocketbase/pocketbase.dart';
import 'package:sqflite/sqflite.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Use this static instance
  final injector = Injector.appInstance;
  await dotenv.load(fileName: "dev.env");

  Database database = await openDatabase(
    dotenv.get("DATABASE_PATH"), 
    onCreate: (db, version) {
      return db.execute(
        """
          CREATE TABLE customers (id INTEGER PRIMARY KEY AUTOINCREMENT, identifier VARCHAR(255), company_name VARCHAR(255));
          CREATE TABLE site_residents (id INTEGER PRIMARY KEY AUTOINCREMENT, first_name VARCHAR(255), last_name VARCHAR(255), job_position VARCHAR(255));
        """
      );
    },
    version: 1
  );

  injector.registerSingleton(() => database);
  injector.registerSingleton(() => PocketBase(dotenv.get("BACKEND_URL")));
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
