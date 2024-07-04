import 'package:masa_epico_concrete_manager/database/app_database.dart';

class ConcreteVolumetricWeightDTO {
  int? id;
  double? tareWeightGr;
  double? materialTareWeightGr;
  double? materialWeightGr;
  double? tareVolumeCm3;
  double? volumetricWeightGrCm3;
  double? volumeLoadM3;
  double? cementQuantityKg;
  double? coarseAggregateKg;
  double? fineAggregateKg;
  double? waterKg;
  String? additives;
  double? totalLoadKg;
  double? totalLoadVolumetricWeightRelation;
  double? percentage;

  ConcreteVolumetricWeightDTO({
    this.id,
    this.tareWeightGr,
    this.materialTareWeightGr,
    this.materialWeightGr,
    this.tareVolumeCm3,
    this.volumetricWeightGrCm3,
    this.volumeLoadM3,
    this.cementQuantityKg,
    this.coarseAggregateKg,
    this.fineAggregateKg,
    this.waterKg,
    this.additives,
    this.totalLoadKg,
    this.totalLoadVolumetricWeightRelation,
    this.percentage,
  });

  static ConcreteVolumetricWeightDTO fromModel(ConcreteVolumetricWeight model) {
    return ConcreteVolumetricWeightDTO(
      id: model.id,
      tareWeightGr: model.tareWeightGr,
      materialTareWeightGr: model.materialTareWeightGr,
      materialWeightGr: model.materialWeightGr,
      tareVolumeCm3: model.tareVolumeCm3,
      volumetricWeightGrCm3: model.volumetricWeightGrCm3,
      volumeLoadM3: model.volumeLoadM3,
      cementQuantityKg: model.cementQuantityKg,
      coarseAggregateKg: model.coarseAggregateKg,
      fineAggregateKg: model.fineAggregateKg,
      waterKg: model.waterKg,
      additives: model.additives ?? '',
      totalLoadKg: model.totalLoadKg,
      totalLoadVolumetricWeightRelation: model.totalLoadVolumetricWeightRelation,
      percentage: model.percentage,
    );
  }
}
