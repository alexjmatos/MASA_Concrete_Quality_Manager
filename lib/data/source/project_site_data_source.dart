import 'package:flutter/material.dart';
import 'package:masa_epico_concrete_manager/models/project_site.dart';
import 'package:masa_epico_concrete_manager/utils/sequential_counter_generator.dart';
import 'package:masa_epico_concrete_manager/views/edit/project_site_edit_view.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

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
            executeEditOrDelete(context, projectSiteNotifier.value[index].id!);
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
            "${projectSiteNotifier.value[index].siteResident!.lastName} ${projectSiteNotifier.value[index].siteResident!.firstName}",
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

  void executeEditOrDelete(BuildContext context, int id) {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.custom,
      confirmBtnText: "Cancelar",
      confirmBtnColor: Colors.black,
      title: "Operaciones",
      widget: Column(
        children: [
          ElevatedButton.icon(
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => ProjectSiteDetails(
                  id: id,
                  readOnly: true,
                  projectSitesNotifier: projectSiteNotifier,
                ),
              ));
            },
            icon: const Icon(
              Icons.details_rounded,
              color: Colors.white,
            ),
            label: const Text(
              'Detalles',
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.lightGreen,
              textStyle: const TextStyle(fontSize: 16),
            ),
          ),
          ElevatedButton.icon(
            onPressed: () async {
              await Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => ProjectSiteDetails(
                    id: id,
                    readOnly: false,
                    projectSitesNotifier: projectSiteNotifier,
                  ),
                ),
              );
            },
            icon: const Icon(
              Icons.edit,
              color: Colors.white,
            ),
            label: const Text(
              'Editar',
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.lightBlue,
              textStyle: const TextStyle(fontSize: 16),
            ),
          ),
          ElevatedButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.delete, color: Colors.white),
            label: const Text(
              'Eliminar',
              style: TextStyle(color: Colors.white),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              textStyle: const TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
