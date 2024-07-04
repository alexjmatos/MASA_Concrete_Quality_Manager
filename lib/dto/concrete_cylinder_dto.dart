class ConcreteCylinderDTO {
  int? id;
  int? buildingSiteSampleNumber;
  int? designAge;
  int? testingAgeDays;
  DateTime? testingDate;
  num? totalLoad;
  num? diameter;
  num? resistance;
  num? median;
  num? percentage;

  ConcreteCylinderDTO(
      {this.id,
      this.buildingSiteSampleNumber,
      this.testingAgeDays,
      this.designAge,
      this.testingDate,
      this.totalLoad,
      this.diameter,
      this.resistance,
      this.median,
      this.percentage});
}
