import 'package:flutter/material.dart';
import 'package:masa_epico_concrete_manager/utils/component_utils.dart';
import 'package:masa_epico_concrete_manager/utils/sequential_counter_generator.dart';

import '../../models/customer.dart';
import '../../views/details/customer_edit_view.dart';

class CustomerData extends DataTableSource {
  BuildContext context;
  final ValueNotifier<List<Customer>> customersNotifier;

  CustomerData({required this.context, required this.customersNotifier});

  @override
  DataRow? getRow(int index) {
    return DataRow(
      cells: [
        DataCell(
          Center(
            child: Text(
              SequentialFormatter.generatePadLeftNumber(
                  customersNotifier.value[index].id!),
              textAlign: TextAlign.center,
            ),
          ),
          onLongPress: () {
            int id = customersNotifier.value[index].id!;
            ComponentUtils.executeEditOrDelete(
              context,
              CustomerDetails(
                id: id,
                readOnly: true,
                customersNotifier: customersNotifier,
              ),
              CustomerDetails(
                id: id,
                readOnly: false,
                customersNotifier: customersNotifier,
              ),
            );
          },
        ),
        DataCell(
          Center(
            child: Text(
              customersNotifier.value[index].identifier,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        DataCell(
          Center(
            child: Text(
              customersNotifier.value[index].companyName,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }

  @override
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => false;

  @override
  // TODO: implement rowCount
  int get rowCount => customersNotifier.value.length;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => 0;
}
