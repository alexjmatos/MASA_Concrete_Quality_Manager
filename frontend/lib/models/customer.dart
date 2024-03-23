import 'package:masa_epico_concrete_manager/models/manager.dart';
import 'package:masa_epico_concrete_manager/utils/uuid_utils.dart';

import 'location.dart';
import 'project_site.dart';

// Entidad - Cliente en el backend
class Customer {
  String? id;
  String identifier;
  String companyName;
  Manager manager;
  Location mainLocation;
  List<ProjectSite> projects;

  Customer({
    this.id,
    required this.identifier,
    required this.companyName,
    required this.manager,
    required this.mainLocation,
    List<ProjectSite>? projects,
  }) : projects = projects ?? [];

  @override
  String toString() {
    return 'Company: { companyName: $companyName, manager: $manager, mainLocation: $mainLocation, projects: $projects }';
  }

  Map<String, dynamic> toMap() => <String, dynamic>{
        "nombre_identificador": identifier,
        "razon_social": companyName,
        "direccion_id": mainLocation.id,
        "gerente_id": manager.id,
      };
}
