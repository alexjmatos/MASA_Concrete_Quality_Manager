import 'package:flutter/material.dart';

class ConcreteTestingSampleForm extends StatefulWidget {
  const ConcreteTestingSampleForm({super.key});

  @override
  State<ConcreteTestingSampleForm> createState() => _ConcreteTestingSampleFormState();
}

class _ConcreteTestingSampleFormState extends State<ConcreteTestingSampleForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text(
          'Registro de ensaye',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                
              ],
            ),
          ),
        ),
      ),
    );
  }
}
