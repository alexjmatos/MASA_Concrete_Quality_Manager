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
          "CREATE TABLE IF NOT EXISTS project_sites (id INTEGER PRIMARY KEY AUTOINCREMENT, site_name VARCHAR(255), customer_id INTEGER REFERENCES customers(id));");
      await db.execute(
          "CREATE TABLE IF NOT EXISTS project_site_resident (project_site_id INTEGER REFERENCES project_sites(id), site_resident_id INTEGER REFERENCES site_residents(id));");
      await db.execute("""
        CREATE TABLE IF NOT EXISTS concrete_volumetric_weight
        (
            id             INTEGER PRIMARY KEY AUTOINCREMENT,
            tare_weight_gr REAL,
            material_tare_weight_gr REAL,
            material_weight_gr REAL,
            tare_volume_cm3 REAL,
            volumetric_weight_gr_cm3 REAL,
            volume_load_m3 REAL,
            cement_quantity_kg REAL,
            coarse_aggregate_kg REAL,
            fine_aggregate_kg REAL,
            water_kg REAL,
            retardant_additive_lt REAL,
            other_additive_lt REAL,
            total_load_kg REAL,
            total_load_volumetric_weight_relation REAL,
            percentage REAL
        );
        """);
      await db.execute("""
        CREATE TABLE IF NOT EXISTS concrete_testing_orders
        (
            id                INTEGER PRIMARY KEY AUTOINCREMENT,
            design_resistance VARCHAR(255),
            slumping_cm       INTEGER,
            volume_m3         INTEGER,
            tma_mm            INTEGER,
            design_age        VARCHAR(255),
            testing_date      INTEGER,
            customer_id       INTEGER REFERENCES customers (id),
            project_site_id   INTEGER REFERENCES project_sites (id),
            site_resident_id  INTEGER REFERENCES site_residents (id),
            concrete_volumetric_weight_id INTEGER REFERENCES concrete_volumetric_weight(id)
        );
        """);
      await db.execute(
          "INSERT INTO customers (id, identifier, company_name) VALUES (NULL, 'SEDENA', 'MAPA750127PD2');");
      await db.execute(
          "INSERT INTO project_sites (id, site_name, customer_id) VALUES (NULL, 'LA MOLINA', 1);");
      await db.execute(
          "INSERT INTO project_sites (id, site_name, customer_id) VALUES (NULL, 'BECAN', 1);");
      await db.execute(
          "INSERT INTO site_residents (id, first_name, last_name, job_position) VALUES (NULL, 'EDUARDO', 'PAZ', 'INGENIERO');");
      await db.execute(
          "INSERT INTO site_residents (id, first_name, last_name, job_position) VALUES (NULL, 'ALEJANDRO', 'MATOS', 'INGENIERO');");
      await db.execute(
          "INSERT INTO project_site_resident (project_site_id, site_resident_id) VALUES (1, 1);");
      await db.execute(
          "INSERT INTO project_site_resident (project_site_id, site_resident_id) VALUES (2, 1);");
      await db.execute(
          "INSERT INTO project_site_resident (project_site_id, site_resident_id) VALUES (2, 2);");
      await db.execute(
          "INSERT INTO concrete_testing_orders(id, design_resistance, slumping_cm, volume_m3, tma_mm, design_age, testing_date, customer_id, project_site_id, site_resident_id, concrete_volumetric_weight_id) VALUES (1, '250', 14, 7, 20, '28', 1716319147750, 1, 1, 1, NULL);");
    },
    version: 1,
  );
}
