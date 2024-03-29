// Entidad - Obra en backend
import 'package:masa_epico_concrete_manager/models/customer.dart';
import 'package:masa_epico_concrete_manager/models/location.dart';
import 'package:masa_epico_concrete_manager/models/site_resident.dart';
import 'package:masa_epico_concrete_manager/service/location_dao.dart';
import 'package:masa_epico_concrete_manager/service/site_resident_dao.dart';

class ProjectSite {
  static final LocationDao locationDao = LocationDao();
  static final SiteResidentDao siteResidentDao = SiteResidentDao();

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

  static ProjectSite toModel(Map<String, dynamic> json) {
    String id = json['id'];
    String siteName = json['nombre_identificador'];
    Map<String, Object?> expand = json['expand'];
    Map<String, dynamic> direccion =
        expand['direccion_id'] as Map<String, dynamic>;
    Location location = Location.toModel(direccion);
    List<SiteResident> siteResidents = [];

    List<Customer> customers = [];

    return ProjectSite(
        id: id,
        siteName: siteName,
        location: location,
        residents: siteResidents,
        customers: customers);
  }
}
