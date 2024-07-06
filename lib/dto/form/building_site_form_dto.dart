import 'package:flutter/cupertino.dart';
import 'package:masa_epico_concrete_manager/service/building_site_dao.dart';
import 'package:masa_epico_concrete_manager/service/site_resident_dao.dart';

import '../../models/building_site.dart';
import '../../models/customer.dart';
import '../../models/site_resident.dart';
import '../../utils/component_utils.dart';
import '../../utils/sequential_counter_generator.dart';

class BuildingSiteFormDTO {
  final TextEditingController siteNameController;
  final TextEditingController customerController;
  final TextEditingController siteResidentController;

  // Data for Site Resident
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController jobPositionController;

  List<Customer> customers = [];
  List<SiteResident> siteResidents = [];
  SiteResident? selectedSiteResident;

  BuildingSiteFormDTO(
      {required this.customerController,
      required this.siteResidentController,
      required this.firstNameController,
      required this.lastNameController,
      required this.jobPositionController,
      required this.siteNameController,
      required this.siteResidents,
      this.selectedSiteResident});

  String getSiteName() {
    return siteNameController.text.trim();
  }

  String getFirstName() {
    return firstNameController.text.trim();
  }

  String getLastName() {
    return lastNameController.text.trim();
  }

  String getJobPosition() {
    return jobPositionController.text.trim();
  }

  List<String> getSelectionCustomers() {
    return customers
        .map((customer) =>
            "${SequentialFormatter.generatePadLeftNumber(customer.id!)} - ${customer.identifier}")
        .toList();
  }

  List<String> getSelectionSiteResidents() {
    return siteResidents
        .map((siteResident) =>
            "${SequentialFormatter.generatePadLeftNumber(siteResident.id!)} - ${siteResident.lastName} ${siteResident.firstName}")
        .toList();
  }

  void setSiteResident(String selected) {
    selectedSiteResident = siteResidents.firstWhere((element) =>
        SequentialFormatter.generatePadLeftNumber(element.id!) ==
        selected.split("-")[0].trim());
    siteResidentController.text = selected;
  }

  void updateSiteResidentInfo() {
    firstNameController.text = selectedSiteResident!.firstName;
    lastNameController.text = selectedSiteResident!.lastName;
    jobPositionController.text = selectedSiteResident!.jobPosition;
  }

  Future<void> addProjectSite(BuildContext context,
      BuildingSiteDAO buildingSiteDAO, SiteResidentDAO siteResidentDAO) async {
    BuildingSite toBeAdded = BuildingSite(siteName: "");

    String siteName = getSiteName();
    String firstName = getFirstName();
    String lastName = getLastName();
    String jobPosition = getJobPosition();

    if (selectedSiteResident != null &&
        selectedSiteResident!.firstName.toUpperCase() ==
            firstName.toUpperCase() &&
        selectedSiteResident!.lastName.toUpperCase() ==
            lastName.toUpperCase() &&
        selectedSiteResident!.jobPosition.toUpperCase() ==
            jobPosition.toUpperCase()) {
      toBeAdded.siteResident = selectedSiteResident;
    } else if (firstName.isNotEmpty || lastName.isNotEmpty) {
      SiteResident siteResident = SiteResident(
        firstName: firstName,
        lastName: lastName,
        jobPosition: jobPosition,
      );
      var siteResidentResult = await siteResidentDAO.add(siteResident);

      toBeAdded.siteResident = siteResidentResult;
    }

    toBeAdded.siteName = siteName;
    toBeAdded.customer = customers.firstWhere((element) =>
        element.id ==
        SequentialFormatter.getIdNumberFromConsecutive(
            customerController.text));

    Future<BuildingSite> future = buildingSiteDAO.add(toBeAdded);

    future.then((value) {
      ComponentUtils.generateSuccessMessage(context,
          "Obra ${SequentialFormatter.generatePadLeftNumber(value.id!)} - ${value.siteName} agregada con exito");
    }).onError((error, stackTrace) {
      ComponentUtils.generateErrorMessage(context);
    });
  }
}
