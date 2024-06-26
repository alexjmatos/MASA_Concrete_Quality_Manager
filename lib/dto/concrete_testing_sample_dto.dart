import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:masa_epico_concrete_manager/elements/input_text_field.dart';
import 'package:masa_epico_concrete_manager/elements/input_time_picker_field.dart';

import '../elements/input_number_field.dart';

class ConcreteTestingSampleDTO {
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

  ConcreteTestingSampleDTO(
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
}
