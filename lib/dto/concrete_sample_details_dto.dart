import 'package:flutter/material.dart';
import 'package:masa_epico_concrete_manager/models/concrete_sample.dart';

class ConcreteSampleDetailsDTO {
  TextEditingController remissionController;
  TextEditingController volumeController;
  TimeOfDay plantTime;
  TimeOfDay buildingSiteTime;
  TextEditingController temperature;
  TextEditingController realSlumpingController;
  TextEditingController locationController;

  ConcreteSampleDetailsDTO(
      this.remissionController,
      this.volumeController,
      this.plantTime,
      this.buildingSiteTime,
      this.temperature,
      this.realSlumpingController,
      this.locationController);

  static ConcreteSampleDetailsDTO fromModel(ConcreteSample model) {
    TextEditingController remissionController = TextEditingController();
    TextEditingController volumeController = TextEditingController();
    TextEditingController temperature = TextEditingController();
    TextEditingController realSlumpingController = TextEditingController();
    TextEditingController locationController = TextEditingController();
    TimeOfDay plantTime = model.plantTime ?? TimeOfDay.now();
    TimeOfDay buildingSiteTime = model.buildingSiteTime ?? TimeOfDay.now();

    remissionController.text = model.remission ?? "";
    volumeController.text = model.volume.toString();
    temperature.text = model.temperature.toString();
    realSlumpingController.text = model.realSlumping.toString();
    locationController.text = model.location.toString();

    return ConcreteSampleDetailsDTO(
        remissionController,
        volumeController,
        plantTime,
        buildingSiteTime,
        temperature,
        realSlumpingController,
        locationController);
  }
}
