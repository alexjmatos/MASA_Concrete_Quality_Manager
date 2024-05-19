import '../constants/constants.dart';

class SequentialIdGenerator {
  static String generatePadLeftNumber(int id) {
    return id.toString().padLeft(Constants.LEADING_ZEROS, '0');
  }

  static int getIdNumberFromConsecutive(String consecutive) {
    return int.parse(consecutive.split("-")[0].trim());
  }
}
