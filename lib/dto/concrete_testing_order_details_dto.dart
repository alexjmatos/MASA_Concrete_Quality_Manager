import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:masa_epico_concrete_manager/dto/input/concrete_cylinder_input_dto.dart';
import 'package:masa_epico_concrete_manager/dto/input/concrete_sample_input_dto.dart';

import '../models/building_site.dart';
import '../models/concrete_cylinder.dart';
import '../models/concrete_sample.dart';
import '../models/concrete_testing_order.dart';
import '../models/concrete_volumetric_weight.dart';
import '../models/customer.dart';
import '../models/site_resident.dart';
import '../service/building_site_dao.dart';
import '../service/concrete_sample_dao.dart';
import '../service/concrete_testing_order_dao.dart';
import '../service/concrete_volumetric_weight_dao.dart';
import '../service/customer_dao.dart';
import '../service/site_resident_dao.dart';
import '../utils/utils.dart';
import 'concrete_volumetric_weight_dto.dart';

class ConcreteTestingOrderDetailsDTO {
  final CustomerDAO customerDao = CustomerDAO();
  final BuildingSiteDAO buildingSiteDao = BuildingSiteDAO();
  final SiteResidentDAO siteResidentDao = SiteResidentDAO();
  final ConcreteTestingOrderDAO concreteTestingOrderDao =
      ConcreteTestingOrderDAO();
  final ConcreteVolumetricWeightDAO concreteVolumetricWeightDao =
      ConcreteVolumetricWeightDAO();
  final ConcreteSampleDAO concreteSampleDAO = ConcreteSampleDAO();

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
  List<ConcreteSampleInputDTO> samplesDTOs;
  Map<int?, List<ConcreteCylinderInputDTO>> cylindersDTOs;

  List<Customer> clients = [];
  List<String> availableClients = [];
  List<BuildingSite> buildingSites = [];
  List<String> availableBuildingSites = [];

  List<ConcreteSample> samples = [];
  List<ConcreteCylinder> cylinders = [];
  List<Map<String, String>> additivesRows = [];

  late ConcreteTestingOrder selectedConcreteTestingOrder;
  Customer selectedCustomer = Customer(identifier: "", companyName: "");
  BuildingSite selectedBuildingSite = BuildingSite(siteName: "");
  SiteResident selectedSiteResident =
      SiteResident(firstName: "", lastName: "", jobPosition: "");
  ConcreteVolumetricWeight? selectedConcreteVolumetricWeight;
  DateTime selectedDate = DateTime.now();

  ConcreteTestingOrderDetailsDTO({
    required this.concreteVolumetricWeightDTO,
    required this.samplesDTOs,
    required this.cylindersDTOs,
  });

  Future<ConcreteTestingOrder> updateConcreteTestingOrder() async {
    // UPDATE GENERAL INFO
    selectedConcreteTestingOrder.slumping =
        int.tryParse(slumpingController.text);
    selectedConcreteTestingOrder.volume = int.tryParse(volumeController.text);
    selectedConcreteTestingOrder.tma = int.tryParse(tmaController.text);
    selectedConcreteTestingOrder.designResistance =
        designResistanceController.text;
    selectedConcreteTestingOrder.designAge = designAgeController.text;
    selectedConcreteTestingOrder.testingDate = selectedDate;
    selectedConcreteTestingOrder.customer = selectedCustomer;
    selectedConcreteTestingOrder.buildingSite = selectedBuildingSite;
    selectedConcreteTestingOrder.siteResident = selectedSiteResident;

    return await concreteTestingOrderDao.update(selectedConcreteTestingOrder);
  }

  Future<void> updateConcreteSamples() async {
    // UPDATE CONCRETE SAMPLES
    for (var samp in samples) {
      // RETRIEVE THE INPUT ELEMENT
      var input =
          samplesDTOs.firstWhereOrNull((element) => element.id == samp.id);

      // UPDATE THE SAMPLE
      if (input != null) {
        samp.remission = input.remissionController.text.trim();
        samp.volume = num.tryParse(input.volumeController.text.trim());
        samp.plantTime = Utils.convertStringToTimeOfDay(input.plantTime.text);
        samp.buildingSiteTime =
            Utils.convertStringToTimeOfDay(input.buildingSiteTime.text);
        samp.temperature = num.tryParse(input.temperature.text.trim());
        samp.realSlumping =
            num.tryParse(input.realSlumpingController.text.trim());
        samp.location = input.locationController.text.trim();
      }
    }
    await concreteSampleDAO.updateAllConcreteSamples(samples);
  }

  Future<void> updateConcreteCylinders() async {
    // UPDATE CONCRETE CYLINDERS
    for (var cylinder in cylinders) {
      var cylinderDTO = cylindersDTOs.values
          .expand((element) => element)
          .firstWhereOrNull((element) => element.id == cylinder.id);

      if (cylinderDTO != null) {
        // UPDATE THE FIELDS
        cylinder.testingAge =
            int.tryParse(cylinderDTO.designAge.controller.text) ?? 0;
        cylinder.testingDate =
            Utils.convertToDateTime(cylinderDTO.testingDate.controller.text);
        cylinder.totalLoad =
            num.tryParse(cylinderDTO.totalLoad.controller.text.trim());
        cylinder.diameter =
            num.tryParse(cylinderDTO.diameter.controller.text.trim());
        cylinder.resistance =
            num.tryParse(cylinderDTO.resistance.controller.text.trim());
        cylinder.percentage =
            num.tryParse(cylinderDTO.percentage.controller.text.trim());
        cylinder.median =
            num.tryParse(cylinderDTO.median.controller.text.trim());
      }
    }
    await concreteSampleDAO.updateAllConcreteCylinders(cylinders);
  }

  Future<void> getUpdated(int? id) async {
    selectedConcreteTestingOrder = await concreteTestingOrderDao.findById(id!);
  }
}
