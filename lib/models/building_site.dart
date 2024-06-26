// Entidad - Obra en backend
import 'package:masa_epico_concrete_manager/models/customer.dart';
import 'package:masa_epico_concrete_manager/models/site_resident.dart';

class BuildingSite {
  int? id;
  String? siteName;

  // ONE TO MANY
  SiteResident? siteResident;

  // ONE TO MANY
  Customer? customer;

  BuildingSite({this.id, this.siteName, this.customer, this.siteResident});

  Map<String, Object?> toMap() {
    return {
      "id": id,
      "site_name": siteName,
      "customer_id": customer?.id,
      "site_resident_id": siteResident?.id
    };
  }

  static BuildingSite toModel(Map<String, Object?>? map) {
    return BuildingSite(
        id: map?["id"] as int,
        siteName: map?["site_name"] as String,
        customer: Customer(
            id: (map?["customer_id"] ?? 0) as int,
            identifier: (map?["identifier"] ?? "") as String,
            companyName: (map?["company_name"] ?? "") as String),
    siteResident: SiteResident(
      id: (map?["site_resident_id"] ?? 0) as int,
      firstName: (map?["first_name"] ?? "") as String,
      lastName: (map?["last_name"] ?? "") as String,
      jobPosition: (map?["job_position"] ?? "") as String
    ));
  }

  @override
  String toString() {
    return 'BuildingSite{id: $id, siteName: $siteName, siteResident: $siteResident, customer: $customer}';
  }
}
