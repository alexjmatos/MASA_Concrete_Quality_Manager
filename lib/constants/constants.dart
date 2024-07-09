// ignore_for_file: constant_identifier_names

import 'dart:core';

import 'package:intl/intl.dart';

class Constants {
  static const List<String> ESTADOS = [
    'Aguascalientes',
    'Baja California',
    'Baja California Sur',
    'Campeche',
    'Chiapas',
    'Chihuahua',
    'Coahuila',
    'Colima',
    'Durango',
    'Guanajuato',
    'Guerrero',
    'Hidalgo',
    'Jalisco',
    'México',
    'Michoacán',
    'Morelos',
    'Nayarit',
    'Nuevo León',
    'Oaxaca',
    'Puebla',
    'Querétaro',
    'Quintana Roo',
    'San Luis Potosí',
    'Sinaloa',
    'Sonora',
    'Tabasco',
    'Tamaulipas',
    'Tlaxcala',
    'Veracruz',
    'Yucatán',
    'Zacatecas',
  ];

  static const String USERS = "users";
  static const String CUSTOMERS = "customers";
  static const String BUILDING_SITES = "building_sites";
  static const String SITE_RESIDENTS = "site_residents";
  static const String CONCRETE_TESTING_ORDERS = "concrete_testing_orders";
  static const String CONCRETE_TESTING_SAMPLES = "concrete_samples";
  static const String CONCRETE_TESTING_CYLINDERS = "concrete_cylinders";
  static const String CONCRETE_VOLUMETRIC_WEIGHT = "concrete_volumetric_weight";

  static const int LEADING_ZEROS = 4;
  static const int TARE_WEIGHT = 3480;
  static const num TARE_VOLUME = 5.181;
  static const List<String> CONCRETE_COMPRESSION_RESISTANCES = [
    "100",
    "150",
    "200",
    "250",
    "300",
    "350",
    "400",
    "450",
    "500"
  ];

  static const List<String> CONCRETE_DESIGN_AGES = [
    "3",
    "3 RR",
    "7",
    "7 RR",
    "14",
    "14 RR",
    "28"
  ];

  static DateFormat formatter = DateFormat('dd-MM-yyyy');

  static const double DATA_TABLE_HORIZONTAL_MARGIN = 24;
  static const double DATA_TABLE_COLUMN_SPACING = 56;
  static const String DESIGN_AGE_KEY = "DESIGN_AGE_DAYS";
  static const String TESTING_DATE_KEY = "TESTING_DATE";
  static const Map<String, List<int>> DESIGN_AGES = {
    "3": [1, 2, 3, 3],
    "3 RR": [1, 2, 3, 3],
    "7 RR": [1, 3, 7, 7],
    "7": [1, 3, 7, 7],
    "14": [3, 7, 14, 14],
    "14 RR": [3, 7, 14, 14],
    "28": [7, 14, 28, 28],
  };

  static const double TITLE_FONT_SIZE = 12.0;
  static const double INFO_FONT_SIZE = 10.0;
  static const double TABLE_FONT_SIZE = 8.0;
}
