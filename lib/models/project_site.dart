// Entidad - Obra en backend
import 'package:masa_epico_concrete_manager/models/customer.dart';
import 'package:masa_epico_concrete_manager/models/site_resident.dart';
import 'package:masa_epico_concrete_manager/service/site_resident_dao.dart';

class ProjectSite {
  int? id;
  String? siteName;
  SiteResident? resident;
  Customer? customer;

  ProjectSite({
    this.id,
    this.siteName,
    this.resident,
    this.customer,
  });

  Map<String, Object?> toMap() {
    return {
      "id": id,
      "site_name": siteName,
      "site_resident_id": resident?.id,
      "customer_id": customer?.id
    };
  }

  static ProjectSite toModel(Map<String, Object?> map) {
    print(map["customer"]);
    print(map["site_resident"]);

    return ProjectSite(
        id: map["id"] as int, siteName: map["site_name"] as String);
  }
}
