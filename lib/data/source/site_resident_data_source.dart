import 'package:flutter/material.dart';
import 'package:masa_epico_concrete_manager/utils/component_utils.dart';
import 'package:masa_epico_concrete_manager/utils/sequential_counter_generator.dart';
import 'package:masa_epico_concrete_manager/views/edit/site_resident_edit_view.dart';

import '../../models/site_resident.dart';

class SiteResidentData extends DataTableSource {
  final BuildContext context;
  final ValueNotifier<List<SiteResident>> siteResidentNotifier;

  SiteResidentData({required this.context, required this.siteResidentNotifier});

  @override
  DataRow? getRow(int index) {
    return DataRow(
      cells: [
        DataCell(
          Text(
            SequentialFormatter.generatePadLeftNumber(
                siteResidentNotifier.value[index].id!),
            textAlign: TextAlign.center,
          ),
          onLongPress: () {
            int id = siteResidentNotifier.value[index].id!;
            ComponentUtils.executeEditOrDelete(
              context,
              SiteResidentDetails(
                  id: id,
                  readOnly: true,
                  siteResidentNotifier: siteResidentNotifier),
              SiteResidentDetails(
                  id: id,
                  readOnly: false,
                  siteResidentNotifier: siteResidentNotifier),
            );
          },
        ),
        DataCell(
          Text(
            "${siteResidentNotifier.value[index].lastName} ${siteResidentNotifier.value[index].firstName}",
            textAlign: TextAlign.center,
          ),
        ),
        DataCell(
          Text(
            siteResidentNotifier.value[index].jobPosition,
            textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => siteResidentNotifier.value.length;

  @override
  int get selectedRowCount => 0;
}
