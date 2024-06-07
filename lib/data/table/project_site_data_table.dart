import 'package:flutter/material.dart';
import 'package:masa_epico_concrete_manager/data/source/project_site_data_source.dart';
import 'package:masa_epico_concrete_manager/models/project_site.dart';

class ProjectSiteDataTable extends StatelessWidget {
  final ValueNotifier<List<ProjectSite>> projectSitesNotifier;

  const ProjectSiteDataTable({super.key, required this.projectSitesNotifier});

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
      source: ProjectSiteData(
          context: context, projectSiteNotifier: projectSitesNotifier),
      rowsPerPage: 10,
    );
  }
}
