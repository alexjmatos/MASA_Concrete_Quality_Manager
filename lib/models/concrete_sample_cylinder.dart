class ConcreteSampleCylinder {
  int? id;
  int? sampleNumber;
  int testingAge;
  DateTime testingDate;
  num? totalLoad;
  num? diameter;
  num? resistance;
  num? median;
  num? percentage;
  int? concreteSampleId;

  ConcreteSampleCylinder(
      {this.id,
      this.sampleNumber,
      required this.testingAge,
      required this.testingDate,
      this.totalLoad,
      this.diameter,
      this.resistance,
      this.median,
      this.percentage,
      this.concreteSampleId});

  Map<String, Object?> toMap() {
    return {
      "id": id,
      "building_site_sample_number": sampleNumber,
      "testing_age_days": testingAge,
      "testing_date": testingDate.millisecondsSinceEpoch,
      "total_load_kg": totalLoad,
      "diameter_cm": diameter,
      "resistance_kgf_cm2": resistance,
      "median": median,
      "percentage": percentage,
      "concrete_sample_id": concreteSampleId
    };
  }

  static ConcreteSampleCylinder toModel(Map<String, Object?> map) {
    return ConcreteSampleCylinder(
        id: map["id"] as int,
        sampleNumber: map["building_site_sample_number"] as int?,
        testingAge: map["testing_age_days"] as int,
        testingDate: DateTime.fromMillisecondsSinceEpoch((map["testing_date"] ??
            DateTime.now().millisecondsSinceEpoch) as int),
        totalLoad: map["total_load_kg"] as num?,
        diameter: map["diameter_cm"] as num?,
        resistance: map["resistance_kgf_cm2"] as num?,
        median: map["median"] as num?,
        percentage: map["percentage"] as num?,
        concreteSampleId: map["concrete_sample_id"] as int?);
  }

  @override
  String toString() {
    return 'ConcreteTestingSampleCylinder{id: $id, testingAge: $testingAge, testingDate: $testingDate, totalLoad: $totalLoad, designResistance: $resistance, median: $median, percentage: $percentage}';
  }
}
