import 'package:masa_epico_concrete_manager/models/manager.dart';

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

  static Customer toModel(Map<String, dynamic> json) {
    String id = json['id'];
    String identifier = json['nombre_identificador'];
    String companyName = json['razon_social'];
    String direccionId = json['direccion_id'];
    String gerenteId = json['gerente_id'];

    // EMPTY LOCATION
    Location location = Location(
        id: direccionId,
        district: "",
        street: "",
        number: "",
        city: "",
        state: "",
        zipCode: "");

    // EMPTY MANAGER
    Manager manager =
        Manager(id: gerenteId, lastName: "", jobPosition: "", firstName: '');

    return Customer(
        id: id,
        identifier: identifier,
        companyName: companyName,
        mainLocation: location,
        manager: manager);
  }
}
