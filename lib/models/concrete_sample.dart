import 'package:flutter/material.dart';
import 'package:masa_epico_concrete_manager/dto/input/concrete_cylinder_input_dto.dart';
import 'package:masa_epico_concrete_manager/models/concrete_testing_order.dart';
import 'package:masa_epico_concrete_manager/models/concrete_volumetric_weight.dart';
import 'package:masa_epico_concrete_manager/models/site_resident.dart';

import '../utils/utils.dart';
import 'building_site.dart';
import 'concrete_sample_cylinder.dart';
import 'customer.dart';

class ConcreteSample {
  int? id;
  String? remission;
  num? volume;
  TimeOfDay? plantTime;
  TimeOfDay? buildingSiteTime;
  num? realSlumping;
  num? temperature;
  String? location;
  ConcreteTestingOrder concreteTestingOrder;
  ConcreteVolumetricWeight? concreteVolumetricWeight;
  List<ConcreteCylinder> concreteCylinders;

  ConcreteSample(
      {this.id,
      this.remission,
      this.volume,
      this.plantTime,
      this.buildingSiteTime,
      this.realSlumping,
      this.temperature,
      this.location,
      required this.concreteTestingOrder,
      required this.concreteCylinders});

  Map<String, Object?> toMap() {
    return {
      "id": id,
      "remission": remission,
      "volume": volume,
      "plant_time": Utils.formatTimeOfDay(plantTime!),
      "building_site_time": Utils.formatTimeOfDay(buildingSiteTime!),
      "real_slumping_cm": realSlumping,
      "temperature_celsius": temperature,
      "location": location,
      "concrete_testing_order_id": concreteTestingOrder.id
    };
  }

  static ConcreteSample toModel(Map<String, Object?> map) {
    List<ConcreteCylinder> concreteSamples = [];
    Customer customer = Customer(
      id: (map["customer_id"] ?? 0) as int,
      identifier: (map["customer_identifier"] ?? "") as String,
      companyName: (map["customer_company_name"] ?? "") as String,
    );

    SiteResident siteResident = SiteResident(
        id: (map["site_resident_id"] ?? 0) as int,
        firstName: (map["site_resident_first_name"] ?? "") as String,
        lastName: (map["site_resident_last_name"] ?? "") as String,
        jobPosition: (map["site_resident_job_position"] ?? "") as String);

    BuildingSite buildingSite = BuildingSite(
        id: (map["building_site_id"] ?? 0) as int,
        siteName: (map["building_site_name"] ?? "") as String,
        customer: customer,
        siteResident: siteResident);

    ConcreteTestingOrder concreteTestingOrder = ConcreteTestingOrder(
        id: (map["concrete_testing_order_id"] ?? 0) as int,
        designResistance: (map["design_resistance"] ?? "") as String,
        slumping: (map["slumping_cm"] ?? 0) as int,
        volume: (map["volume_m3"] ?? 0) as int,
        tma: (map["tma_mm"] ?? 0) as int,
        designAge: (map["design_age"] ?? "") as String,
        testingDate: DateTime.fromMillisecondsSinceEpoch(
            (map["order_testing_date"] ?? DateTime.now().millisecondsSinceEpoch)
                as int),
        customer: customer,
        buildingSite: buildingSite,
        siteResident: siteResident);

    return ConcreteSample(
        id: map["id"] as int,
        remission: map["remission"] as String?,
        volume: map["volume"] as num?,
        plantTime: Utils.convertStringToTimeOfDay((map["plant_time"] ?? "") as String),
        buildingSiteTime: Utils.convertStringToTimeOfDay(
            (map["building_site_time"] ?? "") as String),
        realSlumping: (map["real_slumping_cm"] ?? 0) as num,
        temperature: (map["temperature_celsius"] ?? 0) as num,
        location: (map["location"] ?? "") as String,
        concreteTestingOrder: concreteTestingOrder,
        concreteCylinders: concreteSamples);
  }

  @override
  String toString() {
    return 'ConcreteSample{id: $id, remission: $remission, volume: $volume, plantTime: $plantTime, buildingSiteTime: $buildingSiteTime, realSlumping: $realSlumping, temperature: $temperature, location: $location, concreteTestingOrder: $concreteTestingOrder, concreteVolumetricWeight: $concreteVolumetricWeight, concreteCylinders: $concreteCylinders}';
  }
}
