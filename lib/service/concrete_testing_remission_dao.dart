import 'package:injector/injector.dart';
import 'package:sqflite/sqflite.dart';

import '../models/concrete_testing_remission.dart';
import '../utils/sequential_counter_generator.dart';

class ConcreteTestingRemissionDao {
  late final Database db;
  final SequentialFormatter sequentialIdGenerator = SequentialFormatter();

  ConcreteTestingRemissionDao() {
    final injector = Injector.appInstance;
    db = injector.get<Database>();
  }

  Future<List<ConcreteTestingRemission>> findAll() async {
    var result = await db.rawQuery("""
    SELECT
    rem.id AS id,
    rem.plant_time,
    rem.real_slumping_cm,
    rem.temperature_celsius,
    rem.location,
    rem.concrete_testing_order_id,
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
    concrete_testing_remissions rem
        JOIN
    concrete_testing_orders ord ON rem.concrete_testing_order_id = ord.id
        JOIN
    customers cust ON ord.customer_id = cust.id
        JOIN
    building_sites site ON ord.building_site_id = site.id
        JOIN
    site_residents res ON ord.site_resident_id = res.id;
    """);
    return result.map((e) => ConcreteTestingRemission.toModel(e)).toList();
  }
}
