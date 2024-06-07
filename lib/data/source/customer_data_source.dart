import 'package:flutter/material.dart';
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
          SequentialIdGenerator.generatePadLeftNumber(customersNotifier.value[index].id!),
          textAlign: TextAlign.center,
        ),
        onLongPress: () {
          executeEditOrDelete(context, customersNotifier.value[index].id!);
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

  void executeEditOrDelete(BuildContext context, int id) {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.custom,
      confirmBtnText: "Cancelar",
      confirmBtnColor: Colors.black,
      title: "Operaciones",
      widget: Column(
        children: [
          ElevatedButton.icon(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => CustomerDetails(
                  id: id,
                  readOnly: true,
                  customersNotifier: customersNotifier,
                ),
              ));
            },
            icon: const Icon(
              Icons.details_rounded,
              color: Colors.white,
            ),
            label: const Text(
              'Detalles',
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.lightGreen,
              textStyle: const TextStyle(fontSize: 16),
            ),
          ),
          ElevatedButton.icon(
            onPressed: () async {
              await Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => CustomerDetails(
                    id: id,
                    readOnly: false,
                    customersNotifier: customersNotifier,
                  ),
                ),
              );
            },
            icon: const Icon(
              Icons.edit,
              color: Colors.white,
            ),
            label: const Text(
              'Editar',
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.lightBlue,
              textStyle: const TextStyle(fontSize: 16),
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.delete, color: Colors.white),
            label: const Text(
              'Eliminar',
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              textStyle: const TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
