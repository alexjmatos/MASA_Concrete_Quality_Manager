import 'package:flutter/material.dart';
import 'package:injector/injector.dart';
import 'package:masa_epico_concrete_manager/constants/constants.dart';
import 'package:pocketbase/pocketbase.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late final PocketBase pb;
  String name = "";
  Text text = const Text("Bienvenido",
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16));

  _HomeViewState() {
    final injector = Injector.appInstance;
    pb = injector.get<PocketBase>();
  }

  @override
  void initState() {
    super.initState();
    // // Get the user information
    // final recordFuture = pb.collection(Constants.USERS).getOne(
    //       pb.authStore.model.id,
    //       expand: 'name',
    //     );
    //
    // recordFuture.then((value) {
    //   name = value.getStringValue("name");
    //   setState(() {
    //     text = Text(
    //       "Bienvenido $name",
    //       style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    //     );
    //   });
    // });
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
