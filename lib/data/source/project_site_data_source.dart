import 'package:flutter/material.dart';
import 'package:masa_epico_concrete_manager/models/project_site.dart';
import 'package:masa_epico_concrete_manager/utils/component_utils.dart';
import 'package:masa_epico_concrete_manager/utils/sequential_counter_generator.dart';
import 'package:masa_epico_concrete_manager/views/edit/project_site_edit_view.dart';

class ProjectSiteData extends DataTableSource {
  final BuildContext context;
  final ValueNotifier<List<BuildingSite>> projectSiteNotifier;

  ProjectSiteData({required this.context, required this.projectSiteNotifier});

  @override
  DataRow? getRow(int index) {
    return DataRow(
      cells: [
        DataCell(
          Text(
            SequentialIdGenerator.generatePadLeftNumber(
                projectSiteNotifier.value[index].id!),
          ),
          onLongPress: () {
            int id = projectSiteNotifier.value[index].id!;
            ComponentUtils.executeEditOrDelete(context, ProjectSiteDetails(
                id: id,
                readOnly: true,
                projectSitesNotifier: projectSiteNotifier), ProjectSiteDetails(
                id: id,
                readOnly: false,
                projectSitesNotifier: projectSiteNotifier));
          },
        ),
        DataCell(
          Text(
            projectSiteNotifier.value[index].siteName!,
            textAlign: TextAlign.center,
          ),
        ),
        DataCell(
          Text(
            projectSiteNotifier.value[index].customer!.identifier,
            textAlign: TextAlign.center,
          ),
        ),
        DataCell(
          Text(
            "${projectSiteNotifier.value[index].siteResident!
                .lastName} ${projectSiteNotifier.value[index].siteResident!
                .firstName}",
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => projectSiteNotifier.value.length;

  @override
  int get selectedRowCount => 0;
}
