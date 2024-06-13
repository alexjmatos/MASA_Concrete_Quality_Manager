import 'package:injector/injector.dart';
import 'package:sqflite/sqflite.dart';

import '../constants/constants.dart';
import '../models/concrete_testing_order.dart';
import '../utils/sequential_counter_generator.dart';

class ConcreteTestingOrderDao {
  late final Database db;
  final SequentialFormatter sequentialIdGenerator = SequentialFormatter();

  ConcreteTestingOrderDao() {
    final injector = Injector.appInstance;
    db = injector.get<Database>();
  }

  Future<ConcreteTestingOrder> add(
      ConcreteTestingOrder concreteTestingOrder) async {
    int id = await db.insert(
        Constants.CONCRETE_TESTING_ORDERS, concreteTestingOrder.toMap());
    return findById(id);
  }

  Future<ConcreteTestingOrder> findById(int id) async {
    var result = await db.rawQuery("""
    SELECT
    cto.id AS id,
    cto.design_resistance,
    cto.slumping_cm,
    cto.volume_m3,
    cto.tma_mm,
    cto.design_age,
    cto.testing_date,
    cust.id AS customer_id,
    cust.identifier AS customer_identifier,
    cust.company_name AS customer_company_name,
    bs.id AS building_site_id,
    bs.site_name AS building_site_name,
    sr.id AS site_resident_id,
    sr.first_name AS site_resident_first_name,
    sr.last_name AS site_resident_last_name,
    sr.job_position AS site_resident_job_position,
    cvw.id AS concrete_volumetric_weight_id,
    cvw.tare_weight_gr,
    cvw.material_tare_weight_gr,
    cvw.material_weight_gr,
    cvw.tare_volume_cm3,
    cvw.volumetric_weight_gr_cm3,
    cvw.volume_load_m3,
    cvw.cement_quantity_kg,
    cvw.coarse_aggregate_kg,
    cvw.fine_aggregate_kg,
    cvw.water_kg,
    cvw.additives,
    cvw.total_load_kg,
    cvw.total_load_volumetric_weight_relation,
    cvw.percentage
    FROM
        concrete_testing_orders cto
            LEFT JOIN
        customers cust ON cto.customer_id = cust.id
            LEFT JOIN
        building_sites bs ON cto.building_site_id = bs.id
            LEFT JOIN
        site_residents sr ON cto.site_resident_id = sr.id
            LEFT JOIN
        concrete_volumetric_weight cvw ON cto.concrete_volumetric_weight_id = cvw.id
    WHERE
            cto.id = ?;
    """, [id]);
    return mapToEntity(result.first);
  }

  Future<List<ConcreteTestingOrder>> findAll() async {
    var result = await db.rawQuery("""
    SELECT
    cto.id AS id,
    cto.design_resistance,
    cto.slumping_cm,
    cto.volume_m3,
    cto.tma_mm,
    cto.design_age,
    cto.testing_date,
    cust.id AS customer_id,
    cust.identifier AS customer_identifier,
    cust.company_name AS customer_company_name,
    bs.id AS building_site_id,
    bs.site_name AS building_site_name,
    sr.id AS site_resident_id,
    sr.first_name AS site_resident_first_name,
    sr.last_name AS site_resident_last_name,
    sr.job_position AS site_resident_job_position,
    cvw.id AS concrete_volumetric_weight_id,
    cvw.tare_weight_gr,
    cvw.material_tare_weight_gr,
    cvw.material_weight_gr,
    cvw.tare_volume_cm3,
    cvw.volumetric_weight_gr_cm3,
    cvw.volume_load_m3,
    cvw.cement_quantity_kg,
    cvw.coarse_aggregate_kg,
    cvw.fine_aggregate_kg,
    cvw.water_kg,
    cvw.additives,
    cvw.total_load_kg,
    cvw.total_load_volumetric_weight_relation,
    cvw.percentage
    FROM
        concrete_testing_orders cto
            LEFT JOIN
        customers cust ON cto.customer_id = cust.id
            LEFT JOIN
        building_sites bs ON cto.building_site_id = bs.id
            LEFT JOIN
        site_residents sr ON cto.site_resident_id = sr.id
            LEFT JOIN
        concrete_volumetric_weight cvw ON cto.concrete_volumetric_weight_id = cvw.id;
    """);
    return mapEntities(result);
  }

  Future<List<ConcreteTestingOrder>> mapEntities(
      List<Map<String, Object?>> result) async {
    // Map the results to a list of futures
    var futures = result.map((e) => mapToEntity(e)).toList();
    // Wait for all futures to complete
    return await Future.wait(futures);
  }

  Future<ConcreteTestingOrder> mapToEntity(Map<String, Object?> source) async {
    return ConcreteTestingOrder.toModel(source);
  }

  Future<int> update(ConcreteTestingOrder selectedConcreteTestingOrder) async {
    int update = await db.update(
        Constants.CONCRETE_TESTING_ORDERS, selectedConcreteTestingOrder.toMap(),
        where: "id = ?", whereArgs: [selectedConcreteTestingOrder.id!]);
    return update;
  }
}
