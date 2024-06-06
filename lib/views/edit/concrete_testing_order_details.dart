import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../elements/custom_text_form_field.dart';

class ConcreteTestingOrderDetails extends StatefulWidget {
  final int id;
  final bool readOnly;

  const ConcreteTestingOrderDetails(
      {super.key, required this.id, required this.readOnly});

  @override
  State<StatefulWidget> createState() => _ConcreteTestingOrderDetailsState();
}

class _ConcreteTestingOrderDetailsState
    extends State<ConcreteTestingOrderDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          widget.readOnly ? "Detalles de la muestra" : "Editar la muestra",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: const SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
            ],
          ),
        ),
      ),
    );
  }
}
