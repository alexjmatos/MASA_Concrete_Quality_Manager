import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

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
      DateTime? initDateTime, String designAge) {
    initDateTime ??= DateTime.now();
    return Constants.DESIGN_AGES[designAge]!.map(
      (e) {
        return {
          Constants.DESIGN_AGE_KEY: e,
          Constants.TESTING_DATE_KEY: initDateTime?.add(Duration(days: e))
        };
      },
    ).toList();
  }

  static TimeOfDay convertStringToTimeOfDay(String timeString) {
    String result = timeString.replaceAll(RegExp(r'\s'), '\u202F');

    // Define the format of your time string
    final format = DateFormat.jm(); // jm stands for 'hh:mm a'

    // Parse the string to a DateTime object
    DateTime dateTime = format.parse(result);

    // Convert the DateTime object to TimeOfDay
    return TimeOfDay.fromDateTime(dateTime);
  }

  static String formatTimeOfDay(TimeOfDay timeOfDay) {
    // Convert TimeOfDay to DateTime
    final now = DateTime.now();
    final dateTime = DateTime(now.year, now.month, now.day, timeOfDay.hour, timeOfDay.minute);

    // Define the format
    final format = DateFormat.jm(); // 'jm' means 'h:mm a'

    // Format the DateTime object to the desired string format
    return format.format(dateTime);
  }

  static DateTime convertToDateTime(String dateString) {
    DateFormat dateFormat = DateFormat("dd-MM-yyyy");
    return dateFormat.parse(dateString);
  }

  static String formatDate(DateTime date) {
    final DateFormat formatter = DateFormat('dd-MM-yyyy');
    return formatter.format(date);
  }
}
