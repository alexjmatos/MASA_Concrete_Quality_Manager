import 'package:flutter/material.dart';

class ConcreteTestingRemissionForm extends StatefulWidget {
  const ConcreteTestingRemissionForm({super.key});

  @override
  State<ConcreteTestingRemissionForm> createState() =>
      _ConcreteTestingRemissionFormState();
}

class _ConcreteTestingRemissionFormState
    extends State<ConcreteTestingRemissionForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text(
          'Registrar remisión',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: const Column(
              children: [
                Text("HELLO")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
