
import 'package:masa_epico_concrete_manager/models/project_site.dart';
import 'package:masa_epico_concrete_manager/models/site_resident.dart';

import 'concrete_volumetric_weight.dart';
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
  ConcreteVolumetricWeight? concreteVolumetricWeight;

  ConcreteTestingOrder(
      {this.id,
      this.designResistance,
      this.slumping,
      this.volume,
      this.tma,
      this.designAge,
      this.testingDate,
      required this.customer,
      required this.projectSite,
      required this.siteResident,
      this.concreteVolumetricWeight});

  Map<String, Object?> toMap() {
    return {
      "id": id,
      "design_resistance": designResistance,
      "slumping_cm": slumping,
      "volume_m3": volume,
      "tma_mm": tma,
      "design_age": designAge,
      "testing_date": testingDate?.millisecondsSinceEpoch,
      "customer_id": customer.id!,
      "project_site_id": projectSite.id!,
      "site_resident_id": siteResident.id!,
      "concrete_volumetric_weight_id": concreteVolumetricWeight?.id!
    };
  }

  static ConcreteTestingOrder toModel(
      Map<String, Object?> source,
      Map<String, Object?>? customerMap,
      Map<String, Object?>? projectSiteMap,
      Map<String, Object?>? siteResidentMap,
      Map<String, Object?>? volumetricWeightMap) {
    return ConcreteTestingOrder(
        id: (source["id"] ?? 0) as int,
        designResistance: (source["design_resistance"] ?? "") as String,
        slumping: (source["slumping_cm"] ?? 0) as int,
        volume: (source["volume_m3"] ?? 0) as int,
        tma: (source["tma_mm"] ?? 0) as int,
        designAge: (source["design_age"] ?? 0) as String,
        testingDate: DateTime.fromMillisecondsSinceEpoch(
            (source["testing_date"] ?? DateTime.now().millisecondsSinceEpoch)
                as int),
        customer: Customer.toModel(customerMap),
        projectSite: ProjectSite.toModel(projectSiteMap),
        siteResident: SiteResident.toModel(siteResidentMap),
        concreteVolumetricWeight:
            ConcreteVolumetricWeight.toModel(volumetricWeightMap));
  }
}
