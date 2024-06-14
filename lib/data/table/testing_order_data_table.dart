import 'package:flutter/material.dart';
import 'package:masa_epico_concrete_manager/data/source/testing_order_data_source.dart';
import 'package:masa_epico_concrete_manager/models/concrete_testing_order.dart';

class ConcreteTestingDataTable extends StatelessWidget {
  final ValueNotifier<List<ConcreteTestingOrder>> concreteTestingOrdersNotifier;

  const ConcreteTestingDataTable(
      {super.key, required this.concreteTestingOrdersNotifier});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: concreteTestingOrdersNotifier,
      builder: (BuildContext context, List<ConcreteTestingOrder> value,
          Widget? child) {
        return PaginatedDataTable(
          columns: const [
            DataColumn(
              label: Expanded(
                child: Text(
                  "Identificador",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontStyle: FontStyle.normal),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text(
                  "Fecha",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontStyle: FontStyle.normal),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text(
                  "Obra",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontStyle: FontStyle.normal),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text(
                  "Resistencia",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontStyle: FontStyle.normal),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text(
                  "Edad de \ndiseño",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontStyle: FontStyle.normal),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text(
                  "Revenimiento",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontStyle: FontStyle.normal),
                ),
              ),
            ),
          ],
          source: ConcreteTestingOrderData(
              context: context,
              concreteTestingOrdersNotifier: concreteTestingOrdersNotifier),
        );
      },
    );
  }
}
