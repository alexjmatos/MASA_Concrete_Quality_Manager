import 'package:masa_epico_concrete_manager/models/building_site.dart';
import 'package:masa_epico_concrete_manager/models/site_resident.dart';

import '../constants/constants.dart';
import '../models/concrete_testing_order.dart';
import '../models/customer.dart';

class SequentialFormatter {
  static String generatePadLeftNumber(int id) {
    return id.toString().padLeft(Constants.LEADING_ZEROS, '0');
  }

  static int getIdNumberFromConsecutive(String consecutive) {
    return int.parse(consecutive.split("-")[0].trim());
  }

  static String generateSequentialFormatFromCustomer(Customer customer) {
    return "${SequentialFormatter.generatePadLeftNumber(customer.id!)} - ${customer.identifier}";
  }

  static String generateSequentialFormatFromBuildingSite(
      BuildingSite building) {
    return "${SequentialFormatter.generatePadLeftNumber(building.id!)} - ${building.siteName}";
  }

  static String generateSequentialFormatFromSiteResident(
      SiteResident siteResident) {
    return "${SequentialFormatter.generatePadLeftNumber(siteResident.id!)} - ${siteResident.firstName} ${siteResident.lastName}";
  }

  static String generateSequentialFormatFromConcreteTestingOrder(ConcreteTestingOrder e) {
    return "${SequentialFormatter.generatePadLeftNumber(e.id!)} - ${e.customer.identifier} : ${e.buildingSite.siteName} - (${e.testingDate?.day}/${e.testingDate?.month}/${e.testingDate?.year})";
  }
}
