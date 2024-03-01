import 'package:flutter/material.dart';
import 'package:masa_epico_concrete_manager/quality_form.dart';

void main() => runApp(const MainApp());

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    const appTitle = "MASA Control y Calidad";
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            appTitle,
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.red[500],
        ),
        backgroundColor: Colors.white,
        body: const SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0),
              child: MasaForm(),
            ),
          ),
        ),
      ),
    );
  }
}
