// Entidad - Obra en backend
import 'package:masa_epico_concrete_manager/models/customer.dart';
import 'package:masa_epico_concrete_manager/models/site_resident.dart';

class ProjectSite {
  int? id;
  String? siteName;

  // MANY TO MANY
  List<SiteResident?> residents = [];

  // ONE TO MANY
  Customer? customer;

  ProjectSite({
    this.id,
    this.siteName,
    this.customer,
  });

  Map<String, Object?> toMap() {
    return {"id": id, "site_name": siteName, "customer_id": customer?.id};
  }

  static ProjectSite toModel(Map<String, Object?>? map) {
    return ProjectSite(
        id: map?["id"] as int,
        siteName: map?["site_name"] as String,
        customer: Customer(
            id: (map?["customer_id"] ?? 0) as int,
            identifier: (map?["identifier"] ?? "") as String,
            companyName: (map?["company_name"] ?? "") as String));
  }
}
