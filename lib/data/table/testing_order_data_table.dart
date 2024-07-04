import 'package:flutter/material.dart';
import 'package:masa_epico_concrete_manager/data/source/testing_order_data_source.dart';
import 'package:masa_epico_concrete_manager/dto/concrete_testing_order_dto.dart';
import 'package:masa_epico_concrete_manager/elements/value_notifier_list.dart';

class ConcreteTestingDataTable extends StatelessWidget {
  final ValueNotifierList<ConcreteTestingOrderDTO>
      concreteTestingOrdersNotifier;

  const ConcreteTestingDataTable(
      {super.key, required this.concreteTestingOrdersNotifier});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: concreteTestingOrdersNotifier,
      builder: (context, value, child) {
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
