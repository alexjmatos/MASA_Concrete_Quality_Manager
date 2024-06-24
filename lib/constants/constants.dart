// ignore_for_file: constant_identifier_names

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
  static const String PROJECT_SITES = "building_sites";
  static const String SITE_RESIDENTS = "site_residents";
  static const String MANY_TO_MANY_PROJECT_SITES_SITE_RESIDENTS =
      "project_site_resident";
  static const String CONCRETE_TESTING_ORDERS = "concrete_testing_orders";
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

  static const List<String> CONCRETE_DESIGN_AGES = ["3", "7", "14", "28"];

  static DateFormat formatter = DateFormat('dd-MM-yyyy');

  static const double DATA_TABLE_HORIZONTAL_MARGIN = 24;
  static const double DATA_TABLE_COLUMN_SPACING = 56;
  static const String DESIGN_AGE_KEY = "DESIGN_AGE_DAYS";
  static const String TESTING_DATE_KEY = "TESTING_DATE";
  static const Map<int, List<int>> DESIGN_AGES = {
    3: [1, 2, 3, 3],
    7: [1, 3, 7, 7],
    14: [3, 7, 14, 14],
    28: [7, 14, 28, 28]
  };
}
