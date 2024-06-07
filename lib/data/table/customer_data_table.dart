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
          columns: const [
            DataColumn(
              label: Expanded(
                child: Text(
                  "ID",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontStyle: FontStyle.normal),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text(
                  "Cliente",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontStyle: FontStyle.normal),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text(
                  "RFC",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontStyle: FontStyle.normal),
                ),
              ),
            ),
          ],
          source: CustomerData(
              context: context,
              customersNotifier: customersNotifier),
          rowsPerPage: 10,
        );
      },
    );
  }
}
