// Entidad - Obra en backend
import 'package:masa_epico_concrete_manager/models/customer.dart';
import 'package:masa_epico_concrete_manager/models/location.dart';
import 'package:masa_epico_concrete_manager/models/site_resident.dart';

class ProjectSite {
  String? id;
  String siteName;
  Location location;
  List<SiteResident> residents;
  List<Customer> customers;

  ProjectSite(
      {this.id,
      required this.siteName,
      required this.location,
      required this.residents,
      required this.customers});

  @override
  String toString() {
    return 'ProjectSite: { siteName: $siteName, location: $location, customer: $customers }';
  }

  Map<String, dynamic> toMap() => <String, dynamic>{
        "nombre_identificador": siteName,
        "direccion_id": location.id,
        "clientes_asignados": customers.map((e) => e.id).toList(),
        "residentes_asignados": residents.map((e) => e.id).toList(),
      };
}
