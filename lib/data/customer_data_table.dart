import 'package:flutter/material.dart';

import '../constants/constants.dart';
import 'customer_data_source.dart';

class CustomerDataTable extends StatelessWidget {
  final CustomerData customerData;

  const CustomerDataTable({super.key, required this.customerData});

  @override
  Widget build(BuildContext context) {
    return PaginatedDataTable(
      columns: const [
        DataColumn(
          label: Expanded(
            child: Text(
              "ID",
              style: TextStyle(fontStyle: FontStyle.normal),
            ),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Text(
              "Cliente",
              style: TextStyle(fontStyle: FontStyle.normal),
            ),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Text(
              "RFC",
              style: TextStyle(fontStyle: FontStyle.normal),
            ),
          ),
        ),
      ],
      source: customerData,
    );
  }
}
