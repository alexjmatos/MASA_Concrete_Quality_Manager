class ConcreteVolumetricWeight {
  int? id;
  num? tareWeight;
  num? materialTareWeight;
  num? materialWeight;
  num? tareVolume;
  num? volumetricWeight;
  num? volumeLoad;
  num? cementQuantity;
  num? coarseAggregateQuantity;
  num? fineAggregateQuantity;
  num? waterQuantity;
  num? retardantAdditiveQuantity;
  num? otherAdditiveQuantity;
  num? totalLoad;
  num? totalLoadVolumetricWeightRelation;
  num? percentage;

  ConcreteVolumetricWeight(
      this.id,
      this.tareWeight,
      this.materialTareWeight,
      this.materialWeight,
      this.tareVolume,
      this.volumetricWeight,
      this.volumeLoad,
      this.cementQuantity,
      this.coarseAggregateQuantity,
      this.fineAggregateQuantity,
      this.waterQuantity,
      this.retardantAdditiveQuantity,
      this.otherAdditiveQuantity,
      this.totalLoad,
      this.totalLoadVolumetricWeightRelation,
      this.percentage);

  Map<String, Object?> toMap() {
    return {
      "id": id,
      "tare_weight_gr": tareWeight,
      "material_tare_weight_gr": materialTareWeight,
      "material_weight_gr": materialWeight,
      "tare_volume_cm3": tareVolume,
      "volumetric_weight_gr_cm3": volumetricWeight,
      "volume_load_m3": volumeLoad,
      "cement_quantity_kg": cementQuantity,
      "coarse_aggregate_kg": coarseAggregateQuantity,
      "fine_aggregate_kg": fineAggregateQuantity,
      "water_kg": waterQuantity,
      "retardant_additive_lt": retardantAdditiveQuantity,
      "other_additive_lt": otherAdditiveQuantity,
      "total_load_kg": totalLoad,
      "total_load_volumetric_weight_relation":
          totalLoadVolumetricWeightRelation,
      "percentage": percentage
    };
  }

  static ConcreteVolumetricWeight? toModel(Map<String, Object?>? map) {
    if (map != null) {
      return ConcreteVolumetricWeight(
          (map["id"] ?? 0) as int?,
          (map["tare_weight_gr"] ?? 0) as num?,
          (map["material_tare_weight_gr"] ?? 0) as num?,
          (map["material_weight_gr"] ?? 0) as num?,
          (map["tare_volume_cm3"] ?? 0) as num?,
          (map["volumetric_weight_gr_cm3"] ?? 0) as num?,
          (map["volume_load_m3"] ?? 0) as num?,
          (map["cement_quantity_kg"] ?? 0) as num?,
          (map["coarse_aggregate_kg"] ?? 0) as num?,
          (map["fine_aggregate_kg"] ?? 0) as num?,
          (map["water_kg"] ?? 0) as num?,
          (map["retardant_additive_lt"] ?? 0) as num?,
          (map["other_additive_lt"] ?? 0) as num?,
          (map["total_load_kg"] ?? 0) as num?,
          (map["total_load_volumetric_weight_relation"] ?? 0) as num?,
          (map["percentage"] ?? 0) as num?);
    } else {
      return null;
    }
  }
}
