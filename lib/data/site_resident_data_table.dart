import 'package:flutter/material.dart';
import 'package:masa_epico_concrete_manager/data/site_resident_data_source.dart';

import '../constants/constants.dart';

class SiteResidentDataTable extends StatelessWidget {
  final SiteResidentData siteResidentData;

  const SiteResidentDataTable({super.key, required this.siteResidentData});

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
              "Nombre Completo",
              textAlign: TextAlign.center,
              style: TextStyle(fontStyle: FontStyle.normal),
            ),
          ),
        ),
        DataColumn(
          label: Expanded(
            child: Text(
              "Puesto",
              textAlign: TextAlign.center,
              style: TextStyle(fontStyle: FontStyle.normal),
            ),
          ),
        )
      ],
      source: siteResidentData,
    );
  }
}
