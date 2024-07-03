import 'package:flutter/cupertino.dart';
import 'package:masa_epico_concrete_manager/elements/input_number_field.dart';
import 'package:masa_epico_concrete_manager/elements/input_text_field.dart';
import 'package:masa_epico_concrete_manager/models/concrete_sample_cylinder.dart';

class ConcreteSampleCylinderDTO {
  int id;
  InputNumberField designAge;
  InputTextField testingDate;
  InputNumberField totalLoad;
  InputNumberField diameter;
  InputNumberField resistance;
  InputNumberField percentage;
  InputNumberField median;

  ConcreteSampleCylinderDTO(this.id, this.designAge, this.testingDate, this.totalLoad,
      this.diameter, this.resistance, this.percentage, this.median);
}
