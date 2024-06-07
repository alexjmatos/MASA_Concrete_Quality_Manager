import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../../models/concrete_testing_order.dart';
import '../../utils/component_utils.dart';
import '../../utils/sequential_counter_generator.dart';
import '../../views/edit/concrete_testing_order_details.dart';

class ConcreteTestingOrderData extends DataTableSource {
  final ValueNotifier<List<ConcreteTestingOrder>> concreteTestingOrdersNotifier;
  BuildContext context;

  ConcreteTestingOrderData(
      {required this.context, required this.concreteTestingOrdersNotifier});

  @override
  DataRow? getRow(int index) {
    return DataRow(
      cells: [
        DataCell(
          Text(
            "M - ${SequentialIdGenerator.generatePadLeftNumber(concreteTestingOrdersNotifier.value[index].id!)}",
            textAlign: TextAlign.center,
          ),
          onLongPress: () =>
              executeEditOrDelete(context, concreteTestingOrdersNotifier.value[index].id!),
        ),
        DataCell(
          Text(
            DateFormat("dd-MM-yyy")
                .format(concreteTestingOrdersNotifier.value[index].testingDate!),
            textAlign: TextAlign.center,
          ),
          onLongPress: () =>
              executeEditOrDelete(context, concreteTestingOrdersNotifier.value[index].id!),
        ),
        DataCell(
          Text(
            concreteTestingOrdersNotifier.value[index].projectSite.siteName!,
            textAlign: TextAlign.center,
          ),
          onLongPress: () =>
              executeEditOrDelete(context, concreteTestingOrdersNotifier.value[index].id!),
        ),
        DataCell(
          Text(
            "F'C - ${concreteTestingOrdersNotifier.value[index].designResistance!}",
            textAlign: TextAlign.center,
          ),
          onLongPress: () =>
              executeEditOrDelete(context, concreteTestingOrdersNotifier.value[index].id!),
        ),
        DataCell(
          Text(
            "${concreteTestingOrdersNotifier.value[index].designAge!} días",
            textAlign: TextAlign.center,
          ),
          onLongPress: () =>
              executeEditOrDelete(context, concreteTestingOrdersNotifier.value[index].id!),
        ),
        DataCell(
          Text(
            "${concreteTestingOrdersNotifier.value[index].slumping!} cm",
            textAlign: TextAlign.center,
          ),
          onLongPress: () =>
              executeEditOrDelete(context, concreteTestingOrdersNotifier.value[index].id!),
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

  void executeEditOrDelete(BuildContext context, int id) {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.custom,
      confirmBtnText: "Cancelar",
      confirmBtnColor: Colors.black,
      title: "Operaciones",
      autoCloseDuration: const Duration(seconds: 30),
      widget: Column(
        children: [
          ElevatedButton.icon(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ConcreteTestingOrderDetails(
                  id: id,
                  readOnly: true,
                ),
              ),
            ),
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
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ConcreteTestingOrderDetails(
                  id: id,
                  readOnly: true,
                ),
              ),
            ),
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
