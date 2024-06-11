import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:masa_epico_concrete_manager/utils/component_utils.dart';

import '../../models/concrete_testing_order.dart';
import '../../utils/sequential_counter_generator.dart';
import '../../views/edit/concrete_testing_order_details.dart';

class ConcreteTestingOrderData extends DataTableSource {
  final BuildContext context;
  final ValueNotifier<List<ConcreteTestingOrder>> concreteTestingOrdersNotifier;

  ConcreteTestingOrderData(
      {required this.context, required this.concreteTestingOrdersNotifier});

  @override
  DataRow? getRow(int index) {
    return DataRow(
      cells: [
        DataCell(
            Text(
              "M - ${SequentialFormatter.generatePadLeftNumber(concreteTestingOrdersNotifier.value[index].id!)}",
              textAlign: TextAlign.center,
            ), onLongPress: () {
          int id = concreteTestingOrdersNotifier.value[index].id!;
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
        }),
        DataCell(
          Text(
            DateFormat("dd-MM-yyy").format(
                concreteTestingOrdersNotifier.value[index].testingDate!),
            textAlign: TextAlign.center,
          ),
        ),
        DataCell(
          Text(
            concreteTestingOrdersNotifier.value[index].buildingSite.siteName!,
            textAlign: TextAlign.center,
          ),
        ),
        DataCell(
          Text(
            "F'C - ${concreteTestingOrdersNotifier.value[index].designResistance!}",
            textAlign: TextAlign.center,
          ),
        ),
        DataCell(
          Text(
            "${concreteTestingOrdersNotifier.value[index].designAge!} días",
            textAlign: TextAlign.center,
          ),
        ),
        DataCell(
          Text(
            "${concreteTestingOrdersNotifier.value[index].slumping!} cm",
            textAlign: TextAlign.center,
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
