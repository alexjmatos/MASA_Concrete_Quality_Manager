import 'package:flutter/material.dart';
import 'package:masa_epico_concrete_manager/elements/custom_expansion_tile.dart';

import '../dto/home_view_dto.dart';

class HomeView extends StatefulWidget {

  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String name = "";
  Text text = const Text(
    "Bienvenido",
    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
  );

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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CustomExpansionTile(
                title: "Trabajo pendiente",
                children:  [],
                onExpand: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
