import 'package:flutter/material.dart';
import 'package:masa_epico_concrete_manager/data/project_site_data_source.dart';

import '../constants/constants.dart';

class ProjectSiteDataTable extends StatelessWidget {
  final ProjectSiteData projectSiteData;

  const ProjectSiteDataTable({super.key, required this.projectSiteData});

  @override
  Widget build(BuildContext context) {
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
              "Obra",
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
      ],
      source: projectSiteData,
    );
  }
}
