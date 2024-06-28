import 'package:flutter/material.dart';
import 'package:masa_epico_concrete_manager/models/building_site.dart';
import 'package:masa_epico_concrete_manager/utils/component_utils.dart';
import 'package:masa_epico_concrete_manager/utils/sequential_counter_generator.dart';
import 'package:masa_epico_concrete_manager/views/edit/project_site_edit_view.dart';

class BuildingSiteData extends DataTableSource {
  final BuildContext context;
  final ValueNotifier<List<BuildingSite>> buildingSiteNotifier;

  BuildingSiteData({required this.context, required this.buildingSiteNotifier});

  @override
  DataRow? getRow(int index) {
    return DataRow(
      cells: [
        DataCell(
          Center(
            child: Text(
              SequentialFormatter.generatePadLeftNumber(
                  buildingSiteNotifier.value[index].id!),
            ),
          ),
          onLongPress: () {
            int id = buildingSiteNotifier.value[index].id!;
            ComponentUtils.executeEditOrDelete(
                context,
                BuildingSiteDetails(
                    id: id,
                    readOnly: true,
                    projectSitesNotifier: buildingSiteNotifier),
                BuildingSiteDetails(
                    id: id,
                    readOnly: false,
                    projectSitesNotifier: buildingSiteNotifier));
          },
        ),
        DataCell(
          Center(
            child: Text(
              buildingSiteNotifier.value[index].siteName!,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        DataCell(
          Center(
            child: Text(
              buildingSiteNotifier.value[index].customer!.identifier,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        DataCell(
          Center(
            child: Text(
              buildingSiteNotifier.value[index].siteResident != null
                  ? "${buildingSiteNotifier.value[index].siteResident!.lastName} ${buildingSiteNotifier.value[index].siteResident!.firstName}"
                  : "",
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => buildingSiteNotifier.value.length;

  @override
  int get selectedRowCount => 0;
}
