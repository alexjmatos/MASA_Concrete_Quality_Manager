import 'package:flutter/material.dart';
import 'package:masa_epico_concrete_manager/data/source/concrete_sample_data_source.dart';
import 'package:masa_epico_concrete_manager/dto/concrete_sample_dto.dart';
import 'package:masa_epico_concrete_manager/elements/value_notifier_list.dart';

class ConcreteSamplesDataTable extends StatelessWidget {
  final ValueNotifierList<ConcreteSampleDTO>
      concreteTestingSampleNotifier;
  final int rowsPerPage;

  const ConcreteSamplesDataTable(
      {super.key, required this.concreteTestingSampleNotifier, this.rowsPerPage = 10});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: concreteTestingSampleNotifier,
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
          source: ConcreteSamplesData(
              context: context,
              concreteTestingSamplesNotifier:
                  concreteTestingSampleNotifier),
        );
      },
    );
  }
}
