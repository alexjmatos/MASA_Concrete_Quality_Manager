import 'package:flutter/material.dart';

class ConcreteQualitySampleForm extends StatefulWidget {
  const ConcreteQualitySampleForm({super.key});

  @override
  State<ConcreteQualitySampleForm> createState() => _ConcreteQualitySampleFormState();
}

class _ConcreteQualitySampleFormState extends State<ConcreteQualitySampleForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
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
