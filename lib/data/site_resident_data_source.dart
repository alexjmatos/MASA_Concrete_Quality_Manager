import 'package:flutter/material.dart';
import 'package:masa_epico_concrete_manager/utils/sequential_counter_generator.dart';

import '../models/site_resident.dart';

class SiteResidentData extends DataTableSource {
  List<SiteResident> siteResidents;

  SiteResidentData({required this.siteResidents});

  @override
  DataRow? getRow(int index) {
    return DataRow(
      cells: [
        DataCell(
          Text(
            SequentialIdGenerator.generatePadLeftNumber(
                siteResidents[index].id!),
            textAlign: TextAlign.center,
          ),
        ),
        DataCell(
          Text(
            "${siteResidents[index].lastName} ${siteResidents[index].firstName}",
            textAlign: TextAlign.center,
          ),
        ),
        DataCell(
          Text(
            siteResidents[index].jobPosition,
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => siteResidents.length;

  @override
  int get selectedRowCount => 0;
}
