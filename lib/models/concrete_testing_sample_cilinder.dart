import 'package:masa_epico_concrete_manager/models/concrete_testing_sample.dart';

class ConcreteTestingSampleCylinder {
  int? id;
  int testingAge;
  DateTime testingDate;
  int? totalLoad;
  int? designResistance;
  num? median;
  num? percentage;
  ConcreteTestingSample concreteTestingRemission;

  ConcreteTestingSampleCylinder(
      {this.id,
      required this.testingAge,
      required this.testingDate,
      required this.totalLoad,
      required this.designResistance,
      this.median,
      this.percentage,
      required this.concreteTestingRemission});

  Map<String, Object?> toMap() {
    return {
      "id": id,
      "testing_age_days": testingAge,
      "testing_date": testingDate.millisecondsSinceEpoch,
      "total_load_kg": totalLoad,
      "resistance_kgf_cm2": designResistance,
      "median": median,
      "percentage": percentage,
      "concrete_testing_remission_id": concreteTestingRemission.id
    };
  }

  ConcreteTestingSampleCylinder toModel(Map<String, Object?> map) {
    ConcreteTestingSample concreteTestingRemission =
        ConcreteTestingSample.toModel(map);

    return ConcreteTestingSampleCylinder(
        id: map["id"] as int,
        testingAge: map["testing_age_days"] as int,
        testingDate: DateTime.fromMillisecondsSinceEpoch((map["testing_date"] ??
            DateTime.now().millisecondsSinceEpoch) as int),
        totalLoad: map["total_load_kg"] as int?,
        designResistance: map["resistance_kgf_cm2"] as int?,
        median: map["median"] as num?,
        percentage: map["percentage"] as num?,
        concreteTestingRemission: concreteTestingRemission);
  }

  @override
  String toString() {
    return 'ConcreteTestingSampleCylinder{id: $id, testingAge: $testingAge, testingDate: $testingDate, totalLoad: $totalLoad, designResistance: $designResistance, median: $median, percentage: $percentage, concreteTestingRemission: $concreteTestingRemission}';
  }
}
