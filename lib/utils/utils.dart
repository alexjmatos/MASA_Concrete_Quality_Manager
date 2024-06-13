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
    if (listOfMaps.isNotEmpty){
      for (var map in listOfMaps) {
        additives.putIfAbsent(
          map["Aditivo"] as String,
              () => num.tryParse(map["Cantidad (lt)"] as String) ?? 0.0,
        );
      }
    }
    return additives;
  }
}
