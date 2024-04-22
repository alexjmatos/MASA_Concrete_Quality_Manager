import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injector/injector.dart';
import 'package:masa_epico_concrete_manager/login.dart';
import 'package:masa_epico_concrete_manager/utils/sequential_counter_generator.dart';
import 'package:pocketbase/pocketbase.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "dev.env");
  // Use this static instance
  final injector = Injector.appInstance;

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
      home: const Login(title: appTitle),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      locale: const Locale("es"),
    );
  }
}
