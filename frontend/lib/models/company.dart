import 'location.dart';
import 'site_resident.dart';
import 'project_site.dart';

// Entidad - Cliente en el backend
class Customer {
  int id;
  String companyName;
  SiteResident? manager;
  Location? mainLocation;
  List<ProjectSite> projects;

  Customer({
    required this.id,
    required this.companyName,
    this.manager,
    this.mainLocation,
    List<ProjectSite>? projects,
  }) : projects = projects ?? [];

  @override
  String toString() {
    return 'Company: { companyName: $companyName, manager: $manager, mainLocation: $mainLocation, projects: $projects }';
  }

  factory Customer.fromMap(Map<String, dynamic> map) {
    return Customer(id: map["id"], companyName: map["company_name"]);
  }

  Map<String, dynamic> toMap() => {"id": id, "company_name": companyName};
}
