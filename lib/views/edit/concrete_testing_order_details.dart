import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:masa_epico_concrete_manager/service/concrete_testing_order_dao.dart';

import '../../models/concrete_testing_order.dart';

class ConcreteTestingOrderDetails extends StatefulWidget {
  final int id;
  final bool readOnly;
  final ValueNotifier<List<ConcreteTestingOrder>> concreteTestingOrdersNotifier;

  const ConcreteTestingOrderDetails(
      {super.key,
      required this.id,
      required this.readOnly,
      required this.concreteTestingOrdersNotifier});

  @override
  State<StatefulWidget> createState() => _ConcreteTestingOrderDetailsState();
}

class _ConcreteTestingOrderDetailsState
    extends State<ConcreteTestingOrderDetails> {
  ConcreteTestingOrderDao concreteTestingOrderDao = ConcreteTestingOrderDao();

  @override
  void initState() {
    concreteTestingOrderDao.findById(widget.id).then(
          (value) {},
        );
  }

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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: const [
            ExpansionTile(
              title: Text("Prueba 1"),
              children: [
                ListTile(
                  title: Text(
                    "Prueba 1.1",
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
