import 'package:injector/injector.dart';
import 'package:sqflite/sqflite.dart';

import '../constants/constants.dart';
import '../models/concrete_testing_sample.dart';
import '../utils/sequential_counter_generator.dart';

class ConcreteTestingSampleDao {
  late final Database db;
  final SequentialFormatter sequentialIdGenerator = SequentialFormatter();

  ConcreteTestingSampleDao() {
    final injector = Injector.appInstance;
    db = injector.get<Database>();
  }

  Future<List<ConcreteTestingSample>> findAll() async {
    var result = await db.rawQuery("""
    SELECT
    sam.id AS id,
    sam.plant_time,
    sam.building_site_time,
    sam.real_slumping_cm,
    sam.temperature_celsius,
    sam.location,
    sam.concrete_testing_order_id,
    ord.id AS order_id,
    ord.design_resistance,
    ord.slumping_cm,
    ord.volume_m3,
    ord.tma_mm,
    ord.design_age,
    ord.testing_date AS order_testing_date,
    cust.id AS customer_id,
    cust.identifier AS customer_identifier,
    cust.company_name AS customer_company_name,
    site.id AS building_site_id,
    site.site_name AS building_site_name,
    res.id AS site_resident_id,
    res.first_name AS site_resident_first_name,
    res.last_name AS site_resident_last_name,
    res.job_position AS site_resident_job_position
    FROM
    concrete_testing_samples sam
        JOIN
    concrete_testing_orders ord ON sam.concrete_testing_order_id = ord.id
        JOIN
    customers cust ON ord.customer_id = cust.id
        JOIN
    building_sites site ON ord.building_site_id = site.id
        JOIN
    site_residents res ON ord.site_resident_id = res.id ORDER BY id DESC;
    """);
    return result.map((e) => ConcreteTestingSample.toModel(e)).toList();
  }

  Future<void> addAll(List<ConcreteTestingSample> samples) async {
    Batch batch = db.batch();
    for (var element in samples) {
      batch.insert(Constants.CONCRETE_TESTING_SAMPLES, element.toMap());
    }
    await batch.commit(noResult: true);
  }
}
