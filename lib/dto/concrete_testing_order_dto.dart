import 'building_site_dto.dart';
import 'concrete_sample_dto.dart';
import 'customer_dto.dart';

class ConcreteTestingOrderDTO {
  int? id;
  String? designResistance;
  int? slumpingCm;
  int? volumeM3;
  int? tmaMm;
  String? designAge;
  DateTime? testingDate;
  BuildingSiteDTO? buildingSite;
  CustomerDTO? customer;
  List<ConcreteSampleDTO>? concreteSamples;

  ConcreteTestingOrderDTO(
      {this.id,
      this.designResistance,
      this.slumpingCm,
      this.volumeM3,
      this.tmaMm,
      this.designAge,
      this.testingDate,
      this.buildingSite,
      this.customer,
      this.concreteSamples});
}
