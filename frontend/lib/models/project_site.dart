
// Entidad - Obra en backend
import 'package:masa_epico_concrete_manager/models/company.dart';
import 'package:masa_epico_concrete_manager/models/location.dart';

class ProjectSite {
  int id;
  String siteName;
  Location? location;
  Customer? company;

  ProjectSite(
      {required this.id, required this.siteName, this.location, this.company});

  @override
  String toString() {
    return 'ProjectSite: { siteName: $siteName, location: $location, company: $company }';
  }
}
