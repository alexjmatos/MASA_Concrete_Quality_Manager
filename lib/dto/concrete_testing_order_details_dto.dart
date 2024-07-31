import 'package:flutter/cupertino.dart';
import 'package:masa_epico_concrete_manager/dto/input/concrete_cylinder_input_dto.dart';
import 'package:masa_epico_concrete_manager/dto/input/concrete_sample_input_dto.dart';

import 'concrete_volumetric_weight_dto.dart';

class ConcreteTestingOrderDetailsDTO {
  final TextEditingController customerController = TextEditingController();
  final TextEditingController buildingSiteController = TextEditingController();
  final TextEditingController siteResidentController = TextEditingController();
  final TextEditingController designResistanceController =
      TextEditingController();
  final TextEditingController slumpingController = TextEditingController();
  final TextEditingController volumeController = TextEditingController();
  final TextEditingController tmaController = TextEditingController();
  final TextEditingController designAgeController = TextEditingController();
  final TextEditingController testingDateController = TextEditingController();

  final ConcreteVolumetricWeightDTO concreteVolumetricWeightDTO;
  late  List<ConcreteSampleInputDTO> samples;
  List<List<ConcreteCylinderInputDTO>> cylinders;

  ConcreteTestingOrderDetailsDTO({
    required this.concreteVolumetricWeightDTO,
    required this.samples,
    required this.cylinders,
  });
}
