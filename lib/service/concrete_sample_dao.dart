import 'package:injector/injector.dart';
import 'package:masa_epico_concrete_manager/models/concrete_sample_cylinder.dart';
import 'package:sqflite/sqflite.dart';

import '../constants/constants.dart';
import '../models/concrete_sample.dart';
import '../utils/sequential_counter_generator.dart';
import 'concrete_cylinder_dao.dart';

class ConcreteSampleDAO {
  late final Database db;
  final SequentialFormatter sequentialIdGenerator = SequentialFormatter();
  final ConcreteCylinderDAO concreteCylinderDao = ConcreteCylinderDAO();

  ConcreteSampleDAO() {
    final injector = Injector.appInstance;
    db = injector.get<Database>();
  }

  Future<List<ConcreteSample>> findAll() async {
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
    concrete_samples sam
        JOIN
    concrete_testing_orders ord ON sam.concrete_testing_order_id = ord.id
        JOIN
    customers cust ON ord.customer_id = cust.id
        JOIN
    building_sites site ON ord.building_site_id = site.id
        JOIN
    site_residents res ON ord.site_resident_id = res.id ORDER BY id DESC;
    """);
    return result.map((e) => ConcreteSample.toModel(e)).toList();
  }

  Future<List<int>> addAll(List<ConcreteSample> samples) async {
    Batch batch = db.batch();
    for (var element in samples) {
      batch.insert(Constants.CONCRETE_TESTING_SAMPLES, element.toMap());
    }
    var result = await batch.commit();
    return result.map((i) => i as int).toList();
  }

  Future<List<int>> addAllCylinders(List<ConcreteCylinder> cylinders) async {
    Batch batch = db.batch();
    for (var element in cylinders) {
      batch.insert(Constants.CONCRETE_TESTING_CYLINDERS, element.toMap());
    }
    var result = await batch.commit();
    return result.map((i) => i as int).toList();
  }

  Future<List<ConcreteSample>> findByOrderId(int? id) async {
    var result = await db.query(Constants.CONCRETE_TESTING_SAMPLES,
        where: "concrete_testing_order_id = ?", whereArgs: [id]);
    return mapToEntities(result);
  }

  Future<void> updateAllConcreteSamples(List<ConcreteSample> samples) async {
    var batch = db.batch();
    for (var element in samples) {
      batch.update(Constants.CONCRETE_TESTING_SAMPLES, element.toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace,
          where: "id = ?",
          whereArgs: [element.id]);
    }
    await batch.commit(noResult: true);
  }

  Future<List<ConcreteSample>> mapToEntities(
      List<Map<String, Object?>> result) async {
    List<ConcreteSample> finalResult = [];
    for (var element in result) {
      ConcreteSample concreteSample = ConcreteSample.toModel(element);
      concreteSample.concreteCylinders = await concreteCylinderDao
          .findByConcreteTestingOrder(concreteSample.id);
      finalResult.add(concreteSample);
    }
    return finalResult;
  }

  Future<int> findNextCounterByBuildingSite(int id) async {
    var result = await db.rawQuery("""
    SELECT
    bs.id AS building_site_id,
    COUNT(DISTINCT cc.building_site_sample_number) AS incremental_sample_number
    FROM
        building_sites bs
            JOIN
        concrete_testing_orders cto ON bs.id = cto.building_site_id
            JOIN
        concrete_samples cs ON cto.id = cs.concrete_testing_order_id
            JOIN
        concrete_cylinders cc ON cs.id = cc.concrete_sample_id
    WHERE bs.id = ?;
    """, [id]);
    return (result.first["incremental_sample_number"] as int) + 1;
  }
}
