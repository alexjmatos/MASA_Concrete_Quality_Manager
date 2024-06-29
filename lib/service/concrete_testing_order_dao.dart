import 'package:injector/injector.dart';
import 'package:sqflite/sqflite.dart';

import '../constants/constants.dart';
import '../models/concrete_testing_order.dart';
import '../utils/sequential_counter_generator.dart';
import 'concrete_cylinder_dao.dart';
import 'concrete_sample_dao.dart';

class ConcreteTestingOrderDAO {
  late final Database db;
  final SequentialFormatter sequentialIdGenerator = SequentialFormatter();
  final ConcreteSampleDAO concreteSampleDao = ConcreteSampleDAO();

  ConcreteTestingOrderDAO() {
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
    sr.job_position AS site_resident_job_position
    FROM
        ${Constants.CONCRETE_TESTING_ORDERS} cto
            LEFT JOIN
        ${Constants.CUSTOMERS} cust ON cto.customer_id = cust.id
            LEFT JOIN
        ${Constants.BUILDING_SITES} bs ON cto.building_site_id = bs.id
            LEFT JOIN
        ${Constants.SITE_RESIDENTS} sr ON cto.site_resident_id = sr.id
    WHERE
            cto.id = ?;
    """, [id]);
    return mapToEntity(result.first).then((order) async {
      // RETRIEVE THE SAMPLES AND CYLINDERS
      order.concreteSamples = await concreteSampleDao.findByOrderId(order.id);
      return order;
    },);
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
    sr.job_position AS site_resident_job_position
    FROM
        ${Constants.CONCRETE_TESTING_ORDERS} cto
            LEFT JOIN
        ${Constants.CUSTOMERS} cust ON cto.customer_id = cust.id
            LEFT JOIN
        ${Constants.BUILDING_SITES} bs ON cto.building_site_id = bs.id
            LEFT JOIN
        ${Constants.SITE_RESIDENTS} sr ON cto.site_resident_id = sr.id
    """);
    return result.map(
      (e) {
        return ConcreteTestingOrder.toModel(e);
      },
    ).toList();
  }

  Future<ConcreteTestingOrder> mapToEntity(Map<String, Object?> source) async {
    return ConcreteTestingOrder.toModel(source);
  }

  Future<ConcreteTestingOrder> update(
      ConcreteTestingOrder selectedConcreteTestingOrder) async {
    await db.update(
        Constants.CONCRETE_TESTING_ORDERS, selectedConcreteTestingOrder.toMap(),
        where: "id = ?", whereArgs: [selectedConcreteTestingOrder.id!]);
    return findById(selectedConcreteTestingOrder.id!);
  }
}
