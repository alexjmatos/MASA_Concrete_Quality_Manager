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
    // DeviceOrientation.portraitUp,
    // DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight
  ]);
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
  Database db = await openDatabase(
    path,
    version: 1,
    onCreate: (db, version) async {
      await _executeSqlScript(db, 'init.sql');
    },
  );
  return db;
}

Future<void> _executeSqlScript(Database db, String path) async {
  String script = await rootBundle.loadString(path);
  List<String> statements = script.split(';');
  for (String statement in statements) {
    if (statement.trim().isNotEmpty) {
      await db.execute(statement);
    }
  }
}
