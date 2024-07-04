import 'package:flutter/material.dart';
import 'package:masa_epico_concrete_manager/dto/concrete_sample_dto.dart';

import '../../elements/value_notifier_list.dart';
import '../../utils/sequential_counter_generator.dart';

class ConcreteSamplesData extends DataTableSource {
  final BuildContext context;
  final ValueNotifierList<ConcreteSampleDTO> concreteTestingSamplesNotifier;

  ConcreteSamplesData(
      {required this.context, required this.concreteTestingSamplesNotifier});

  @override
  DataRow? getRow(int index) {
    final concreteSample = concreteTestingSamplesNotifier.value[index];
    return DataRow(
      cells: [
        DataCell(
          Center(
            child: Text(
              "MASA - ${SequentialFormatter.generatePadLeftNumber(concreteSample.id ?? 0)}",
              textAlign: TextAlign.center,
            ),
          ),
        ),
        DataCell(
          Center(
            child: Text(
              concreteSample.testingOrder?.buildingSite?.siteName ?? 'N/A',
              textAlign: TextAlign.center,
            ),
          ),
        ),
        DataCell(
          Center(
            child: Text(
              concreteSample.testingOrder?.designAge ?? 'N/A',
              textAlign: TextAlign.center,
            ),
          ),
        ),
        DataCell(
          Center(
            child: Text(
              concreteSample.testingOrder?.designResistance ?? 'N/A',
              textAlign: TextAlign.center,
            ),
          ),
        ),
        DataCell(
          Center(
            child: Text(
              concreteSample.plantTime.toString(),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        DataCell(
          Center(
            child: Text(
              "${concreteSample.realSlumpingCm ?? 'N/A'}",
              textAlign: TextAlign.center,
            ),
          ),
        ),
        DataCell(
          Center(
            child: Text(
              "${concreteSample.temperatureCelsius ?? 'N/A'}",
              textAlign: TextAlign.center,
            ),
          ),
        ),
        DataCell(
          Center(
            child: Text(
              concreteSample.location ?? 'N/A',
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => concreteTestingSamplesNotifier.value.length;

  @override
  int get selectedRowCount => 0;
}
