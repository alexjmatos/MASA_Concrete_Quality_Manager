import '../constants/constants.dart';
import '../models/customer.dart';

class SequentialFormatter {
  static String generatePadLeftNumber(int id) {
    return id.toString().padLeft(Constants.LEADING_ZEROS, '0');
  }

  static int getIdNumberFromConsecutive(String consecutive) {
    return int.parse(consecutive.split("-")[0].trim());
  }

  static String generateSequentialFormat(Customer customer) {
    return "${SequentialFormatter.generatePadLeftNumber(customer.id!)} - ${customer.identifier}";
  }
}
