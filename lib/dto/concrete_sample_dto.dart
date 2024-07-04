import 'package:flutter/material.dart';
import 'package:masa_epico_concrete_manager/database/app_database.dart';
import 'package:masa_epico_concrete_manager/dto/concrete_testing_order_dto.dart';
import '../utils/sequential_counter_generator.dart';
import '../utils/utils.dart';
import 'concrete_cylinder_dto.dart';
import 'package:pdf/widgets.dart' as pw;

import 'concrete_volumetric_weight_dto.dart';

class ConcreteSampleDTO {
  int? id;
  String? remission;
  double? volume;
  TimeOfDay? plantTime;
  TimeOfDay? buildingSiteTime;
  double? realSlumpingCm;
  double? temperatureCelsius;
  String? location;
  ConcreteTestingOrderDTO? testingOrder;
  ConcreteVolumetricWeightDTO? concreteVolumetricWeight;
  List<ConcreteCylinderDTO>? cylinders = [];

  ConcreteSampleDTO({
    this.id,
    this.remission,
    this.volume,
    this.plantTime,
    this.buildingSiteTime,
    this.realSlumpingCm,
    this.temperatureCelsius,
    this.location,
    this.testingOrder,
    this.concreteVolumetricWeight,
    this.cylinders,
  });

  pw.Widget getIndex(int index) {
    switch (index) {
      case 0:
        return pw.Expanded(child: pw.Text(remission!));
      case 1:
        return pw.Expanded(child: pw.Text(Utils.formatTimeOfDay(plantTime!)));
      case 2:
        return pw.Expanded(
            child: pw.Text(Utils.formatTimeOfDay(buildingSiteTime!)));
      case 3:
        return pw.Expanded(child: pw.Text(realSlumpingCm.toString()));
      case 4:
        return pw.Expanded(child: pw.Text(temperatureCelsius.toString()));
      case 5:
        return pw.Expanded(child: pw.Text(location!));
      case 6:
        return pw.Column(
            children: cylinders!
                .map((e) =>
                    pw.Text(SequentialFormatter.generatePadLeftNumber(e.id)))
                .toList());
      case 7:
        return pw.Column(
            children: cylinders!
                .map((e) => pw.Text(e.designAge.toString()))
                .toList());
      case 8:
        return pw.Column(
            children: cylinders!
                .map((e) => pw.Text(Utils.formatDate(e.testingDate!)))
                .toList());
      case 9:
        return pw.Column(
            children: cylinders!
                .map((e) => pw.Text(e.totalLoad.toString()))
                .toList());
      case 10:
        return pw.Column(
            children: cylinders!
                .map((e) => pw.Text(e.resistance.toString()))
                .toList());
      case 11:
        return pw.Column(
            children:
                cylinders!.map((e) => pw.Text(e.median.toString())).toList());
      case 12:
        return pw.Column(
            children: cylinders!
                .map((e) => pw.Text(e.percentage.toString()))
                .toList());
      default:
        return pw.Text("");
    }
  }
}
