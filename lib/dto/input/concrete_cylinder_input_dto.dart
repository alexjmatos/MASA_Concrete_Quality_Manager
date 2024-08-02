import 'package:masa_epico_concrete_manager/elements/input_number_field.dart';
import 'package:masa_epico_concrete_manager/elements/input_text_field.dart';

class ConcreteCylinderInputDTO {
  int id;
  int sampleNumber;
  InputNumberField designAge;
  InputTextField testingDate;
  InputNumberField totalLoad;
  InputNumberField diameter;
  InputNumberField resistance;
  InputNumberField percentage;
  InputNumberField median;

  ConcreteCylinderInputDTO(
      this.id,
      this.sampleNumber,
      this.designAge,
      this.testingDate,
      this.totalLoad,
      this.diameter,
      this.resistance,
      this.percentage,
      this.median);
}
