// Entidad - Obra en backend
import 'package:masa_epico_concrete_manager/models/customer.dart';
import 'package:masa_epico_concrete_manager/models/location.dart';

class ProjectSite {
  String? id;
  String siteName;
  Location? location;
  Customer? company;

  ProjectSite({this.id, required this.siteName, this.location, this.company});

  @override
  String toString() {
    return 'ProjectSite: { siteName: $siteName, location: $location, company: $company }';
  }
}
