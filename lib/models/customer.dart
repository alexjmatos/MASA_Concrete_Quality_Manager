import 'package:masa_epico_concrete_manager/models/manager.dart';

import 'location.dart';
import 'project_site.dart';

class Customer {
  int? id;
  String identifier;
  String companyName;
  Manager? manager;
  Location? mainLocation;
  List<ProjectSite> projects;

  Customer({
    this.id,
    required this.identifier,
    required this.companyName,
    this.manager,
    this.mainLocation,
    List<ProjectSite>? projects,
  }) : projects = projects ?? [];

  Map<String, Object?> toMap() {
    return {"id": id, "identifier": identifier, "company_name": companyName};
  }

  static Customer toModel(Map<String, Object?> map) {
    return Customer(
        id: map["id"] as int,
        identifier: map["identifier"] as String,
        companyName: map["company_name"] as String);
  }

  static Customer emptyModel() {
    return Customer(
        identifier: "",
        companyName: "",
        manager: Manager.emptyModel(),
        mainLocation: Location.emptyModel());
  }
}
