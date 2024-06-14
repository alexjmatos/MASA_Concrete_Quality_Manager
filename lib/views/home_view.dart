import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String name = "";
  Text text = const Text("Bienvenido",
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16));

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: text,
      ),
      body: const SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Text("Estos son los ensayos que tienes pendiente hoy")),
      ),
    );
  }
}
