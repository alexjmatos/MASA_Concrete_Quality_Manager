import 'package:flutter/material.dart';
import 'package:masa_epico_concrete_manager/data/testing_order_data_source.dart';

import '../constants/constants.dart';

class ConcreteTestingDataTable extends StatelessWidget {
  final ConcreteTestingOrderData concreteTestingOrderData;

  const ConcreteTestingDataTable({super.key, required this.concreteTestingOrderData});

  @override
  Widget build(BuildContext context) {
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
      source: concreteTestingOrderData,
    );
  }
}