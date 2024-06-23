import 'package:flutter/material.dart';
import 'package:masa_epico_concrete_manager/data/source/remission_data_source.dart';
import 'package:masa_epico_concrete_manager/elements/value_notifier_list.dart';
import 'package:masa_epico_concrete_manager/models/concrete_testing_remission.dart';

class ConcreteRemissionDataTable extends StatelessWidget {
  final ValueNotifierList<ConcreteTestingRemission>
      concreteTestingRemissionNotifier;
  final int rowsPerPage;

  const ConcreteRemissionDataTable(
      {super.key, required this.concreteTestingRemissionNotifier, this.rowsPerPage = 10});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: concreteTestingRemissionNotifier,
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
                  "Obra",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontStyle: FontStyle.normal),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text(
                  "Edad de\ndiseño",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontStyle: FontStyle.normal),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text(
                  "Resistencia \nde diseño F'C",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontStyle: FontStyle.normal),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text(
                  "Hora en\nplanta",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontStyle: FontStyle.normal),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text(
                  "Revenimiento \nreal (cm)",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontStyle: FontStyle.normal),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text(
                  "Temperatura (°C)",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontStyle: FontStyle.normal),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text(
                  "Ubicación",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontStyle: FontStyle.normal),
                ),
              ),
            ),
          ],
          rowsPerPage: rowsPerPage,
          source: ConcreteRemissionData(
              context: context,
              concreteTestingRemissionNotifier:
                  concreteTestingRemissionNotifier),
        );
      },
    );
  }
}
