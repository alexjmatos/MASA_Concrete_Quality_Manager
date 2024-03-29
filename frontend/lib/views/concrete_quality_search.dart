import 'package:flutter/material.dart';

class ConcreteQualitySearch extends StatefulWidget {
  const ConcreteQualitySearch({super.key});

  @override
  State<ConcreteQualitySearch> createState() => _ConcreteQualitySearchState();
}

class _ConcreteQualitySearchState extends State<ConcreteQualitySearch> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Buscar, editar o eliminar',
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
