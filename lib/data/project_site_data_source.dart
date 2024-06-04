import 'package:flutter/material.dart';
import 'package:masa_epico_concrete_manager/models/project_site.dart';
import 'package:masa_epico_concrete_manager/utils/sequential_counter_generator.dart';

class ProjectSiteData extends DataTableSource {
  List<ProjectSite> projectSites;

  ProjectSiteData({required this.projectSites});

  @override
  DataRow? getRow(int index) {
    return DataRow(
      cells: [
        DataCell(
          Text(
            SequentialIdGenerator.generatePadLeftNumber(
                projectSites[index].id!),
          ),
        ),
        DataCell(
          Text(
            projectSites[index].siteName!,
            textAlign: TextAlign.center,
          ),
        ),
        DataCell(
          Text(
            projectSites[index].customer!.identifier,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => projectSites.length;

  @override
  int get selectedRowCount => 0;
}
