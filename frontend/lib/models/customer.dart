import 'package:masa_epico_concrete_manager/models/manager.dart';

import 'location.dart';
import 'project_site.dart';

// Entidad - Cliente en el backend
class Customer {
  String? id;
  int? sequence;
  String identifier;
  String companyName;
  Manager manager;
  Location mainLocation;
  List<ProjectSite> projects;

  Customer({
    this.id,
    this.sequence,
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
        "consecutivo": sequence,
        "nombre_identificador": identifier,
        "razon_social": companyName,
        "direccion_id": mainLocation.id,
        "gerente_id": manager.id,
      };

  static Customer toModel(Map<String, dynamic> json) {
    String id = json['id'];
    int sequence = json['consecutivo'];
    String identifier = json['nombre_identificador'];
    String companyName = json['razon_social'];
    Map<String, Object?> expand = json['expand'];
    List<Map<String, dynamic>> obras =
        expand['obras'] as List<Map<String, dynamic>>;
    List<ProjectSite> projectSites =
        obras.map((e) => ProjectSite.toModel(e)).toList();

    // EMPTY LOCATION
    Location location = Location.emptyModel();

    // EMPTY MANAGER
    Manager manager = Manager.emptyModel();

    return Customer(
        id: id,
        sequence: sequence,
        identifier: identifier,
        companyName: companyName,
        mainLocation: location,
        manager: manager,
        projects: projectSites);
  }

  static Customer emptyModel() {
    return Customer(
        identifier: "",
        companyName: "",
        manager: Manager.emptyModel(),
        mainLocation: Location.emptyModel());
  }
}
