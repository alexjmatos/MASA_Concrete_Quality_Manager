import 'package:flutter/material.dart';
import 'package:masa_epico_concrete_manager/data/source/site_resident_data_source.dart';
import 'package:masa_epico_concrete_manager/dto/site_resident_dto.dart';

class SiteResidentDataTable extends StatelessWidget {
  final ValueNotifier<List<SiteResidentDTO>> siteResidentNotifier;

  const SiteResidentDataTable({super.key, required this.siteResidentNotifier});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: siteResidentNotifier,
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
                  "Nombre",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontStyle: FontStyle.normal),
                ),
              ),
            ),
            DataColumn(
              label: Expanded(
                child: Text(
                  "Apellidos",
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
          source: SiteResidentData(
              context: context, siteResidentNotifier: siteResidentNotifier),
        );
      },
    );
  }
}
