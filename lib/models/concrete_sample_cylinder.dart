
class ConcreteSampleCylinder {
  int? id;
  int testingAge;
  DateTime testingDate;
  int? totalLoad;
  num? diameter;
  int? resistance;
  num? median;
  num? percentage;
  int? concreteTestingSampleId;

  ConcreteSampleCylinder(
      {this.id,
      required this.testingAge,
      required this.testingDate,
      this.totalLoad,
      this.diameter,
      this.resistance,
      this.median,
      this.percentage,
      this.concreteTestingSampleId});

  Map<String, Object?> toMap() {
    return {
      "id": id,
      "testing_age_days": testingAge,
      "testing_date": testingDate.millisecondsSinceEpoch,
      "total_load_kg": totalLoad,
      "diameter_cm": diameter,
      "resistance_kgf_cm2": resistance,
      "median": median,
      "percentage": percentage,
      "concrete_sample_id": concreteTestingSampleId
    };
  }

  static ConcreteSampleCylinder toModel(Map<String, Object?> map) {
    return ConcreteSampleCylinder(
        id: map["id"] as int,
        testingAge: map["testing_age_days"] as int,
        testingDate: DateTime.fromMillisecondsSinceEpoch((map["testing_date"] ??
            DateTime.now().millisecondsSinceEpoch) as int),
        totalLoad: map["total_load_kg"] as int?,
        diameter: map["diameter"] as num?,
        resistance: map["resistance_kgf_cm2"] as int?,
        median: map["median"] as num?,
        percentage: map["percentage"] as num?,
        concreteTestingSampleId: map["concrete_sample_id"] as int?);
  }

  @override
  String toString() {
    return 'ConcreteTestingSampleCylinder{id: $id, testingAge: $testingAge, testingDate: $testingDate, totalLoad: $totalLoad, designResistance: $resistance, median: $median, percentage: $percentage}';
  }
}
