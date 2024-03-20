import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:masa_epico_concrete_manager/views/app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: "dev.env");
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  static const appTitle = 'MASA Control y Calidad';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: appTitle,
      home: const HomePage(title: appTitle),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      locale: const Locale("es"),
    );
  }
}
