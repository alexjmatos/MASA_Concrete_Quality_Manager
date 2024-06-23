import 'package:masa_epico_concrete_manager/models/concrete_testing_order.dart';
import 'package:masa_epico_concrete_manager/models/building_site.dart';
import 'package:masa_epico_concrete_manager/models/site_resident.dart';

import 'concrete_testing_sample.dart';
import 'customer.dart';

class ConcreteTestingRemission {
  int? id;
  DateTime? plantTime;
  num? realSlumping;
  num? temperature;
  String? location;
  ConcreteTestingOrder concreteTestingOrder;
  List<ConcreteTestingSample> concreteSampleCylinders;

  ConcreteTestingRemission(
      {this.id,
      this.plantTime,
      this.realSlumping,
      this.temperature,
      this.location,
      required this.concreteTestingOrder,
      required this.concreteSampleCylinders});

  Map<String, Object?> toMap() {
    return {
      "id": id,
      "plant_time": plantTime?.millisecondsSinceEpoch,
      "real_slumping_cm": realSlumping,
      "temperature": temperature,
      "location": location,
      "concrete_testing_order_id": concreteTestingOrder.id
    };
  }

  static ConcreteTestingRemission toModel(Map<String, Object?> map) {
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
        id: (map["order_id"] ?? 0) as int,
        designResistance: (map["design_resistance"] ?? "") as String,
        slumping: (map["slumping_cm"] ?? "") as int,
        volume: (map["volume_m3"] ?? "") as int,
        tma: (map["tma_mm"] ?? "") as int,
        designAge: (map["design_age"] ?? "") as String,
        testingDate: DateTime.fromMillisecondsSinceEpoch(
            (map["order_testing_date"] ?? DateTime.now().millisecondsSinceEpoch)
                as int),
        customer: customer,
        buildingSite: buildingSite,
        siteResident: siteResident);

    List<ConcreteTestingSample> concreteSamples = [];
    return ConcreteTestingRemission(
        id: map["id"] as int,
        plantTime: DateTime.fromMillisecondsSinceEpoch((map["plant_time"] ??
            DateTime.now().millisecondsSinceEpoch) as int),
        realSlumping: (map["real_slumping_cm"] ?? 0) as num,
        temperature: (map["temperature_celsius"] ?? 0) as num,
        location: (map["location"] ?? "") as String,
        concreteTestingOrder: concreteTestingOrder,
        concreteSampleCylinders: concreteSamples);
  }
}
