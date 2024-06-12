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
  BuildingSite buildingSite;
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
      required this.buildingSite,
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
      "building_site_id": buildingSite.id!,
      "site_resident_id": siteResident.id!,
      "concrete_volumetric_weight_id": concreteVolumetricWeight?.id!
    };
  }

  static ConcreteTestingOrder toModel(Map<String, Object?> source) {
    Customer customer = Customer(
        id: (source["customer_id"] ?? 0) as int,
        identifier: (source["customer_identifier"] ?? "") as String,
        companyName: (source["customer_company_name"] ?? "") as String);

    SiteResident siteResident = SiteResident(
        id: (source["site_resident_id"] ?? 0) as int,
        firstName: (source["site_resident_first_name"] ?? "") as String,
        lastName: (source["site_resident_last_name"] ?? "") as String,
        jobPosition: (source["site_resident_job_position"] ?? "") as String);

    BuildingSite buildingSite = BuildingSite(
        id: (source["building_site_id"] ?? 0) as int,
        siteName: (source["building_site_name"] ?? "") as String,
        customer: customer,
        siteResident: siteResident);

    ConcreteVolumetricWeight concreteVolumetricWeight =
        ConcreteVolumetricWeight(
            (source["concrete_volumetric_weight_id"] ?? 0) as int?,
            (source["tare_weight_gr"] ?? 0) as num?,
            (source["material_tare_weight_gr"] ?? 0) as num?,
            (source["material_weight_gr"] ?? 0) as num?,
            (source["tare_volume_cm3"] ?? 0) as num?,
            (source["volumetric_weight_gr_cm3"] ?? 0) as num?,
            (source["volume_load_m3"] ?? 0) as num?,
            (source["cement_quantity_kg"] ?? 0) as num?,
            (source["coarse_aggregate_kg"] ?? 0) as num?,
            (source["fine_aggregate_kg"] ?? 0) as num?,
            (source["water_kg"] ?? 0) as num?,
            (source["retardant_additive_lt"] ?? 0) as num?,
            (source["other_additive_lt"] ?? 0) as num?,
            (source["total_load_kg"] ?? 0) as num?,
            (source["total_load_volumetric_weight_relation"] ?? 0) as num?,
            (source["percentage"] ?? 0) as num?);

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
        customer: customer,
        buildingSite: buildingSite,
        siteResident: siteResident,
        concreteVolumetricWeight: concreteVolumetricWeight);
  }
}
