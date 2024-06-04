import 'package:flutter/material.dart';
import 'package:masa_epico_concrete_manager/service/customer_dao.dart';
import 'package:masa_epico_concrete_manager/utils/sequential_counter_generator.dart';

import '../models/customer.dart';

class CustomerData extends DataTableSource {
  List<Customer> customers;

  CustomerData({required this.customers});

  @override
  DataRow? getRow(int index) {
    return DataRow(cells: [
      DataCell(
        Text(
          SequentialIdGenerator.generatePadLeftNumber(customers[index].id!),
          textAlign: TextAlign.center,
        ),
      ),
      DataCell(
        Text(
          customers[index].identifier,
          textAlign: TextAlign.center,
        ),
      ),
      DataCell(
        Text(
          customers[index].companyName,
          textAlign: TextAlign.center,
        ),
      ),
    ]);
  }

  @override
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => false;

  @override
  // TODO: implement rowCount
  int get rowCount => customers.length;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => 0;
}
