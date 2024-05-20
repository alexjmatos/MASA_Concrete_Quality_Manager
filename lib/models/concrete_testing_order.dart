import 'package:masa_epico_concrete_manager/models/project_site.dart';
import 'package:masa_epico_concrete_manager/models/site_resident.dart';

import 'customer.dart';

class ConcreteTestingOrder {
  int? id;
  String? designResistance;
  int? slumping;
  int? volume;
  int? tma;
  String? designAge;
  DateTime? testingDate;
  Customer customer;
  ProjectSite projectSite;
  SiteResident siteResident;

  ConcreteTestingOrder({
    this.id,
    this.designResistance,
    this.slumping,
    this.volume,
    this.tma,
    this.designAge,
    this.testingDate,
    required this.customer,
    required this.projectSite,
    required this.siteResident,
  });

  Map<String, Object?> toMap() {
    return {
      "id": id,
      "design_resistance": designResistance,
      "slumping_cm": slumping,
      "volume_m3": volume,
      "tma_mm": tma,
      "design_age": designAge,
      "testing_date": testingDate?.toIso8601String(),
      "customer_id": customer.id!,
      "project_site_id": projectSite.id!,
      "site_resident_id": siteResident.id!
    };
  }

  static ConcreteTestingOrder toModel(
    Map<String, Object?> source,
    Map<String, Object?> customerMap,
    Map<String, Object?> projectSiteMap,
    Map<String, Object?> siteResidentMap,
  ) {
    return ConcreteTestingOrder(
        id: source["id"] as int,
        designResistance: source["design_resistance"] as String,
        slumping: source["slumping_cm"] as int,
        volume: source["volume_m3"] as int,
        tma: source["tma_mm"] as int,
        designAge: source["design_age"] as String,
        testingDate: DateTime.parse(source["testing_date"] as String),
        customer: Customer.toModel(customerMap),
        projectSite: ProjectSite.toModel(projectSiteMap),
        siteResident: SiteResident.toModel(siteResidentMap));
  }
}
