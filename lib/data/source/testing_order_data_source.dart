import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:masa_epico_concrete_manager/utils/component_utils.dart';

import '../../elements/value_notifier_list.dart';
import '../../models/concrete_testing_order.dart';
import '../../utils/sequential_counter_generator.dart';
import '../../views/details/concrete_testing_order_details.dart';

class ConcreteTestingOrderData extends DataTableSource {
  final BuildContext context;
  final ValueNotifierList<ConcreteTestingOrder> concreteTestingOrdersNotifier;

  ConcreteTestingOrderData(
      {required this.context, required this.concreteTestingOrdersNotifier});

  @override
  DataRow? getRow(int index) {
    final order = concreteTestingOrdersNotifier.value[index];
    return DataRow(
      cells: [
        DataCell(
          Center(
            child: Text(
              "MASA - ${SequentialFormatter.generatePadLeftNumber(order.id ?? 0)}",
              textAlign: TextAlign.center,
            ),
          ),
          onLongPress: () {
            int id = order.id!;
            ComponentUtils.executeEditOrDelete(
              context,
              ConcreteTestingOrderDetails(
                id: id,
                readOnly: true,
                concreteTestingOrdersNotifier: concreteTestingOrdersNotifier,
              ),
              ConcreteTestingOrderDetails(
                id: id,
                readOnly: false,
                concreteTestingOrdersNotifier: concreteTestingOrdersNotifier,
              ),
            );
          },
        ),
        DataCell(
          Center(
            child: Text(
              DateFormat("dd-MM-yyyy").format(order.testingDate ?? DateTime.now()),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        DataCell(
          Center(
            child: Text(
              order.buildingSite.siteName ?? 'N/A',
              textAlign: TextAlign.center,
            ),
          ),
        ),
        DataCell(
          Center(
            child: Text(
              "F'C - ${order.designResistance ?? 'N/A'}",
              textAlign: TextAlign.center,
            ),
          ),
        ),
        DataCell(
          Center(
            child: Text(
              "${order.designAge ?? 'N/A'} días",
              textAlign: TextAlign.center,
            ),
          ),
        ),
        DataCell(
          Center(
            child: Text(
              "${order.slumping ?? 'N/A'} cm",
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
  int get rowCount => concreteTestingOrdersNotifier.value.length;

  @override
  int get selectedRowCount => 0;
}