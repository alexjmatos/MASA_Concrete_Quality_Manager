import 'package:flutter/material.dart';
import 'package:masa_epico_concrete_manager/utils/component_utils.dart';
import 'package:masa_epico_concrete_manager/utils/sequential_counter_generator.dart';
import 'package:masa_epico_concrete_manager/views/edit/customer_edit_view.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../../models/customer.dart';

class CustomerData extends DataTableSource {
  BuildContext context;
  final ValueNotifier<List<Customer>> customersNotifier;

  CustomerData({required this.context, required this.customersNotifier});

  @override
  DataRow? getRow(int index) {
    return DataRow(cells: [
      DataCell(
        Text(
          SequentialFormatter.generatePadLeftNumber(
              customersNotifier.value[index].id!),
          textAlign: TextAlign.center,
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
        Text(
          customersNotifier.value[index].identifier,
          textAlign: TextAlign.center,
        ),
      ),
      DataCell(
        Text(
          customersNotifier.value[index].companyName,
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
  int get rowCount => customersNotifier.value.length;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => 0;
}
