import 'package:flutter/material.dart';

import 'customer_data_source.dart';

class CustomerDataTable extends StatelessWidget {
  final CustomerData customerData;

  const CustomerDataTable({super.key, required this.customerData});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: customerData.customersNotifier,
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
              customersNotifier: customerData.customersNotifier),
          rowsPerPage: 10,
          showCheckboxColumn: true,
        );
      },
    );
  }
}
