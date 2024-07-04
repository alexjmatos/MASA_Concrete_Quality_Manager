import 'package:masa_epico_concrete_manager/database/app_database.dart';
import 'package:masa_epico_concrete_manager/dto/building_site_dto.dart';
import 'package:masa_epico_concrete_manager/dto/concrete_testing_order_dto.dart';
import 'package:masa_epico_concrete_manager/dto/customer_dto.dart';
import 'package:masa_epico_concrete_manager/dto/site_resident_dto.dart';

import '../constants/constants.dart';

class SequentialFormatter {
  static String generatePadLeftNumber(int? id) {
    return id.toString().padLeft(Constants.LEADING_ZEROS, '0');
  }

  static int getIdNumberFromConsecutive(String consecutive) {
    return int.parse(consecutive.split("-")[0].trim());
  }

  static String generateSequentialFormatFromCustomer(CustomerDTO customer) {
    return "${SequentialFormatter.generatePadLeftNumber(customer.id!)} - ${customer.identifier}";
  }

  static String generateSequentialFormatFromBuildingSite(
      BuildingSiteDTO building) {
    return "${SequentialFormatter.generatePadLeftNumber(building.id)} - ${building.siteName}";
  }

  static String generateSequentialFormatFromSiteResidentDTO(
      SiteResidentDTO siteResident) {
    return "${SequentialFormatter.generatePadLeftNumber(siteResident.id)} - ${siteResident.firstName} ${siteResident.lastName}";
  }

  static String generateSequentialFormatFromSiteResident(
      SiteResident siteResident) {
    return "${SequentialFormatter.generatePadLeftNumber(siteResident.id)} - ${siteResident.firstName} ${siteResident.lastName}";
  }

  static String generateSequentialFormatFromConcreteTestingOrder(
      ConcreteTestingOrderDTO e) {
    return "${SequentialFormatter.generatePadLeftNumber(e.id!)} - ${e.customer?.identifier} : ${e.buildingSite?.siteName} - (${e.testingDate?.day}/${e.testingDate?.month}/${e.testingDate?.year})";
  }
}
