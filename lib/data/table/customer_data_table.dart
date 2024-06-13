import 'package:flutter/material.dart';

import '../../models/customer.dart';
import '../source/customer_data_source.dart';

class CustomerDataTable extends StatelessWidget {
  final ValueNotifier<List<Customer>> customersNotifier;

  const CustomerDataTable({super.key, required this.customersNotifier});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: customersNotifier,
      builder: (context, value, child) {
        return PaginatedDataTable(
          showCheckboxColumn: false,
          columns: const [
            DataColumn(
              label: Expanded(
                child: Text(
                  "ID",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontStyle: FontStyle.normal, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text(
                  "Cliente",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontStyle: FontStyle.normal, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text(
                  "RFC",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontStyle: FontStyle.normal, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
          source: CustomerData(
              context: context, customersNotifier: customersNotifier),
          rowsPerPage: 10,
        );
      },
    );
  }
}
