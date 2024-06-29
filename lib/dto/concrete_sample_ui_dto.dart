import 'package:flutter/material.dart';
import 'package:masa_epico_concrete_manager/elements/input_text_field.dart';
import 'package:masa_epico_concrete_manager/elements/input_time_picker_field.dart';
import 'package:masa_epico_concrete_manager/models/concrete_sample.dart';

import '../elements/input_number_field.dart';

class ConcreteSampleUiDTO {
  String id;
  InputTextField remission;
  InputNumberField volume;
  InputTimePicker timePlant;
  InputTimePicker timeBuildingSite;
  InputNumberField temperature;
  InputNumberField realSlumping;
  InputTextField location;
  List<InputNumberField> designAges = [];
  List<InputTextField> testingDates = [];

  ConcreteSampleUiDTO({required this.id,
    required this.remission,
    required this.volume,
    required this.timePlant,
    required this.timeBuildingSite,
    required this.temperature,
    required this.realSlumping,
    required this.location,
    required this.designAges,
    required this.testingDates});

  static ConcreteSampleUiDTO fromModel(ConcreteSample model) {
    return ConcreteSampleUiDTO(id: model.id.toString(),
        remission: InputTextField(),
        volume: InputNumberField(),
        timePlant: InputTimePicker(timeOfDay: TimeOfDay.now(),),
        timeBuildingSite: InputTimePicker(timeOfDay: TimeOfDay.now(),),
        temperature: InputNumberField(),
        realSlumping: InputNumberField(),
        location: InputTextField(),
        designAges: [InputNumberField()],
        testingDates: [InputTextField()]);
  }
}
