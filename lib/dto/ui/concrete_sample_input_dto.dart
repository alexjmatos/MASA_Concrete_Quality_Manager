import 'package:flutter/material.dart';
import 'package:masa_epico_concrete_manager/database/app_database.dart';
import 'package:masa_epico_concrete_manager/dto/concrete_sample_dto.dart';

import '../../utils/utils.dart';

class ConcreteSampleInputDTO {
  TextEditingController remissionController;
  TextEditingController volumeController;
  TimeOfDay plantTime;
  TimeOfDay buildingSiteTime;
  TextEditingController temperature;
  TextEditingController realSlumpingController;
  TextEditingController locationController;

  ConcreteSampleInputDTO(
      this.remissionController,
      this.volumeController,
      this.plantTime,
      this.buildingSiteTime,
      this.temperature,
      this.realSlumpingController,
      this.locationController);

  static ConcreteSampleInputDTO fromModel(ConcreteSampleDTO dto) {
    TextEditingController remissionController = TextEditingController();
    TextEditingController volumeController = TextEditingController();
    TextEditingController temperature = TextEditingController();
    TextEditingController realSlumpingController = TextEditingController();
    TextEditingController locationController = TextEditingController();
    TimeOfDay plantTime = dto.plantTime ?? TimeOfDay.now();
    TimeOfDay buildingSiteTime = dto.buildingSiteTime ?? TimeOfDay.now();

    remissionController.text = dto.remission ?? "";
    volumeController.text = dto.volume.toString();
    temperature.text = dto.temperatureCelsius.toString();
    realSlumpingController.text = dto.realSlumpingCm.toString();
    locationController.text = dto.location.toString();

    return ConcreteSampleInputDTO(
        remissionController,
        volumeController,
        plantTime,
        buildingSiteTime,
        temperature,
        realSlumpingController,
        locationController);
  }
}
