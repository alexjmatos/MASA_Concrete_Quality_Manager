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
      DateTime? initDateTime, int designAge) {
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

  static TimeOfDay parseTimeOfDay(String timeString) {
    final parts = timeString.split(':');
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);

    return TimeOfDay(hour: hour, minute: minute);
  }

  static String formatTimeOfDay(TimeOfDay time) {
    final int hour = time.hour;
    final int minute = time.minute;

    // Ensuring two-digit formatting for hour and minute
    final String hourString = hour.toString().padLeft(2, '0');
    final String minuteString = minute.toString().padLeft(2, '0');

    return '$hourString:$minuteString';
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
