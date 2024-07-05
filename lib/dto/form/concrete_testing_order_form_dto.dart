import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:masa_epico_concrete_manager/dto/form/concrete_sample_form_dto.dart';
import 'package:masa_epico_concrete_manager/service/concrete_testing_order_dao.dart';

import '../../constants/constants.dart';
import '../../models/building_site.dart';
import '../../models/concrete_sample.dart';
import '../../models/concrete_sample_cylinder.dart';
import '../../models/concrete_testing_order.dart';
import '../../models/customer.dart';
import '../../models/site_resident.dart';
import '../../service/concrete_sample_dao.dart';
import '../../utils/component_utils.dart';
import '../../utils/sequential_counter_generator.dart';
import '../../utils/utils.dart';

class ConcreteTestingOrderFormDTO {
  final ConcreteTestingOrderDAO concreteTestingOrderDAO =
      ConcreteTestingOrderDAO();
  final ConcreteSampleDAO concreteSampleDAO = ConcreteSampleDAO();

  final TextEditingController customerController;
  final TextEditingController buildingSiteController;
  final TextEditingController siteResidentController;
  final TextEditingController designResistanceController;
  final TextEditingController slumpingController;
  final TextEditingController volumeController;
  final TextEditingController tmaController;
  final TextEditingController designAgeController;
  final TextEditingController testingDateController;

  Customer? selectedCustomer;
  BuildingSite? selectedBuildingSite;
  SiteResident? selectedSiteResident;
  DateTime selectedDate;

  List<Customer> clients = [];
  List<BuildingSite> buildingSites = [];
  List<ConcreteSampleFormDTO> samples = [];

  ConcreteTestingOrderFormDTO(
      {required this.customerController,
      required this.buildingSiteController,
      required this.siteResidentController,
      required this.designResistanceController,
      required this.slumpingController,
      required this.volumeController,
      required this.tmaController,
      required this.designAgeController,
      required this.testingDateController,
      this.selectedCustomer,
      this.selectedBuildingSite,
      this.selectedSiteResident,
      required this.selectedDate});

  void addConcreteTestingOrder(BuildContext context) {
    ConcreteTestingOrder concreteTestingOrder = ConcreteTestingOrder(
        designResistance: designResistanceController.text,
        slumping: int.tryParse(slumpingController.text),
        volume: int.tryParse(volumeController.text),
        tma: int.tryParse(tmaController.text),
        designAge: designAgeController.text,
        testingDate: selectedDate,
        customer: selectedCustomer ?? Customer(identifier: "", companyName: ""),
        buildingSite: selectedBuildingSite ?? BuildingSite(),
        siteResident: selectedSiteResident);

    concreteTestingOrderDAO.add(concreteTestingOrder).then((value) {
      return addConcreteTestingSamples(value);
    }).then(
      (value) {
        return addConcreteTestingCylinders(value);
      },
    ).then(
      (value) {
        int id = value["CONCRETE_TESTING_ORDER_ID"] as int;
        ComponentUtils.generateSuccessMessage(context,
            "Orden de muestreo ${SequentialFormatter.generatePadLeftNumber(id)} agregada con exito");
      },
    );
  }

  Future<Map<String, Object?>> addConcreteTestingSamples(
      ConcreteTestingOrder order) async {
    List<ConcreteSample> concreteSamples = samples.map((sample) {
      return ConcreteSample(
          concreteTestingOrder: order,
          remission: sample.remission.controller.text,
          volume: num.tryParse(sample.volume.controller.text),
          plantTime: Utils.parseTimeOfDay(sample.timePlant.timeController.text),
          buildingSiteTime:
              Utils.parseTimeOfDay(sample.timeBuildingSite.timeController.text),
          realSlumping: num.tryParse(sample.realSlumping.controller.text),
          temperature: num.tryParse(sample.temperature.controller.text),
          location: sample.location.controller.text,
          concreteCylinders: []);
    }).toList();

    var list = await concreteSampleDAO.addAll(concreteSamples);
    return {"CONCRETE_TESTING_ORDER_ID": order.id, "CONCRETE_SAMPLES": list};
  }

  Future<Map<String, Object?>> addConcreteTestingCylinders(
      Map<String, Object?> previousResult) async {
    List<int> identifiers = previousResult["CONCRETE_SAMPLES"] as List<int>;
    for (var i in Iterable.generate(samples.length, (index) => index)) {
      int sampleNumber = await concreteSampleDAO
          .findNextCounterByBuildingSite(selectedBuildingSite?.id ?? 0);
      var cylinders = Iterable.generate(
        samples[i].designAges.length,
        (index) => index,
      ).map((j) {
        var dto = samples.elementAt(i);
        var testingAge =
            int.tryParse(dto.designAges.elementAt(j).controller.text) ?? 0;
        var testingDate = Utils.convertToDateTime(
            dto.testingDates.elementAt(j).controller.text);
        return ConcreteCylinder(
            sampleNumber: sampleNumber,
            testingAge: testingAge,
            testingDate: testingDate,
            concreteSampleId: identifiers.elementAt(i));
      }).toList();
      var result = await concreteSampleDAO.addAllCylinders(cylinders);
      previousResult.putIfAbsent(
        "CONCRETE_CYLINDERS",
        () => result,
      );
      return previousResult;
    }
    return previousResult;
  }

  String getTestingDateString() {
    return Constants
        .formatter
        .format(selectedDate);
  }
}
