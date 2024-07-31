import 'package:flutter/material.dart';
import 'package:masa_epico_concrete_manager/elements/input_text_field.dart';
import 'package:masa_epico_concrete_manager/elements/input_time_picker_field.dart';
import 'package:masa_epico_concrete_manager/models/concrete_sample.dart';

import '../../elements/input_number_field.dart';

class ConcreteSampleFormDTO {
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

  ConcreteSampleFormDTO(
      {required this.id,
      required this.remission,
      required this.volume,
      required this.timePlant,
      required this.timeBuildingSite,
      required this.temperature,
      required this.realSlumping,
      required this.location,
      required this.designAges,
      required this.testingDates});

  static ConcreteSampleFormDTO fromModel(ConcreteSample model) {
    return ConcreteSampleFormDTO(
        id: model.id.toString(),
        remission: InputTextField(
          onChange: (p0) {},
        ),
        volume: InputNumberField(
          onChange: (p0) {},
          controller: TextEditingController(),
        ),
        timePlant: InputTimePicker(
          timeOfDay: TimeOfDay.now(),
        ),
        timeBuildingSite: InputTimePicker(
          timeOfDay: TimeOfDay.now(),
        ),
        temperature: InputNumberField(
          onChange: (p0) {},
          controller: TextEditingController(),
        ),
        realSlumping: InputNumberField(
          onChange: (p0) {},
          controller: TextEditingController(),
        ),
        location: InputTextField(
          onChange: (p0) {},
        ),
        designAges: [
          InputNumberField(
            onChange: (p0) {},
            controller: TextEditingController(),
          )
        ],
        testingDates: [
          InputTextField(
            onChange: (p0) {},
          )
        ]);
  }
}
