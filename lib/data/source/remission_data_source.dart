import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:masa_epico_concrete_manager/utils/component_utils.dart';

import '../../elements/value_notifier_list.dart';
import '../../models/concrete_testing_order.dart';
import '../../models/concrete_testing_sample.dart';
import '../../utils/sequential_counter_generator.dart';
import '../../views/edit/concrete_testing_order_details.dart';

class ConcreteRemissionData extends DataTableSource {
  final BuildContext context;
  final ValueNotifierList<ConcreteTestingSample>
      concreteTestingRemissionNotifier;

  ConcreteRemissionData(
      {required this.context, required this.concreteTestingRemissionNotifier});

  @override
  DataRow? getRow(int index) {
    final remission = concreteTestingRemissionNotifier.value[index];
    return DataRow(
      cells: [
        DataCell(
          Center(
            child: Text(
              "REM - ${SequentialFormatter.generatePadLeftNumber(remission.id ?? 0)}",
              textAlign: TextAlign.center,
            ),
          ),
        ),
        DataCell(
          Center(
            child: Text(
              remission.concreteTestingOrder.buildingSite.siteName ?? 'N/A',
              textAlign: TextAlign.center,
            ),
          ),
        ),
        DataCell(
          Center(
            child: Text(
              remission.concreteTestingOrder.designAge ?? 'N/A',
              textAlign: TextAlign.center,
            ),
          ),
        ),
        DataCell(
          Center(
            child: Text(
              remission.concreteTestingOrder.designResistance ?? 'N/A',
              textAlign: TextAlign.center,
            ),
          ),
        ),
        DataCell(
          Center(
            child: Text(
              DateFormat("hh:mm").format(remission.plantTime ?? DateTime.now()),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        DataCell(
          Center(
            child: Text(
              "${remission.realSlumping ?? 'N/A'}",
              textAlign: TextAlign.center,
            ),
          ),
        ),
        DataCell(
          Center(
            child: Text(
              "${remission.temperature ?? 'N/A'}",
              textAlign: TextAlign.center,
            ),
          ),
        ),
        DataCell(
          Center(
            child: Text(
              remission.location ?? 'N/A',
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
  int get rowCount => concreteTestingRemissionNotifier.value.length;

  @override
  int get selectedRowCount => 0;
}
