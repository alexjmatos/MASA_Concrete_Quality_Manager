import '../constants/constants.dart';

class Utils {
  static Map<String, String> mergeMaps(List<Map<String, String>> listOfMaps) {
    Map<String, String> mergedMap = {};
    for (var map in listOfMaps) {
      mergedMap.addAll(map);
    }
    return mergedMap;
  }

  static Map<String, num> convert(List<Map<String, String>> listOfMaps) {
    Map<String, num> additives = {};
    if (listOfMaps.isNotEmpty) {
      for (var map in listOfMaps) {
        additives.putIfAbsent(
          map["Aditivo"] as String,
          () => num.tryParse(map["Cantidad (lt)"] as String) ?? 0.0,
        );
      }
    }
    return additives;
  }

  static String generateUniqueId() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

  static List<Map<String, dynamic>> generateTestingDatesBasedOnDesignDays(
      DateTime initDateTime, int designAge) {
    return Constants.DESIGN_AGES[designAge]!.map(
      (e) {
        return {
          Constants.DESIGN_AGE_KEY: e,
          Constants.TESTING_DATE_KEY: initDateTime.add(Duration(days: e))
        };
      },
    ).toList();
  }
}
