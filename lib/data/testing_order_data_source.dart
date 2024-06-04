import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/concrete_testing_order.dart';
import '../utils/sequential_counter_generator.dart';

class ConcreteTestingOrderData extends DataTableSource {
  List<ConcreteTestingOrder> concreteTestingOrders = [];

  ConcreteTestingOrderData({required this.concreteTestingOrders});

  @override
  DataRow? getRow(int index) {
    return DataRow(
      cells: [
        DataCell(
          Text(
            "M - ${SequentialIdGenerator.generatePadLeftNumber(
                concreteTestingOrders[index].id!)}",
            textAlign: TextAlign.center,
          ),
        ),
        DataCell(
          Text(
            DateFormat("dd-MM-yyy").format(concreteTestingOrders[index].testingDate!),
            textAlign: TextAlign.center,
          ),
        ),
        DataCell(
          Text(
            concreteTestingOrders[index].projectSite.siteName!,
            textAlign: TextAlign.center,
          ),
        ),
        DataCell(
          Text(
            "F'C - ${concreteTestingOrders[index].designResistance!}",
            textAlign: TextAlign.center,
          ),
        ),
        DataCell(
          Text(
            "${concreteTestingOrders[index].designAge!} días",
            textAlign: TextAlign.center,
          ),
        ),
        DataCell(
          Text(
            "${concreteTestingOrders[index].slumping!} cm",
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => concreteTestingOrders.length;

  @override
  int get selectedRowCount => 0;
}
