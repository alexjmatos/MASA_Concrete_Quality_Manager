import 'package:flutter/material.dart';
import 'package:masa_epico_concrete_manager/models/concrete_sample.dart';

import '../../utils/utils.dart';
import 'concrete_cylinder_input_dto.dart';

class ConcreteSampleInputDTO {
  int id;
  TextEditingController remissionController;
  TextEditingController volumeController;
  TextEditingController plantTime;
  TimeOfDay plantTimeOfDay;
  TextEditingController buildingSiteTime;
  TimeOfDay buildingTimeOfDay;
  TextEditingController temperature;
  TextEditingController realSlumpingController;
  TextEditingController locationController;
  List<ConcreteCylinderInputDTO> cylinders = [];

  ConcreteSampleInputDTO(
      this.id,
      this.remissionController,
      this.volumeController,
      this.plantTime,
      this.plantTimeOfDay,
      this.buildingSiteTime,
      this.buildingTimeOfDay,
      this.temperature,
      this.realSlumpingController,
      this.locationController);

  static ConcreteSampleInputDTO fromModel(ConcreteSample model) {
    TextEditingController remissionController = TextEditingController();
    TextEditingController volumeController = TextEditingController();
    TextEditingController temperature = TextEditingController();
    TextEditingController realSlumpingController = TextEditingController();
    TextEditingController locationController = TextEditingController();
    TextEditingController plantTime = TextEditingController();
    TextEditingController buildingSiteTime = TextEditingController();

    remissionController.text = model.remission ?? "";
    volumeController.text = model.volume.toString();
    temperature.text = model.temperature.toString();
    realSlumpingController.text = model.realSlumping.toString();
    locationController.text = model.location.toString();

    return ConcreteSampleInputDTO(
        model.id!,
        remissionController,
        volumeController,
        plantTime,
        model.plantTime ?? TimeOfDay.now(),
        buildingSiteTime,
        model.buildingSiteTime ?? TimeOfDay.now(),
        temperature,
        realSlumpingController,
        locationController);
  }
}
