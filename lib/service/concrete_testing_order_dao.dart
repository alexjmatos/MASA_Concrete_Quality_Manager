import 'package:injector/injector.dart';
import 'package:sqflite/sqflite.dart';

import '../constants/constants.dart';
import '../models/concrete_testing_order.dart';
import '../utils/sequential_counter_generator.dart';

class ConcreteTestingOrderDao {
  late final Database db;
  final SequentialIdGenerator sequentialIdGenerator = SequentialIdGenerator();

  ConcreteTestingOrderDao() {
    final injector = Injector.appInstance;
    db = injector.get<Database>();
  }

  Future<ConcreteTestingOrder> addConcreteTestingOrder(
      ConcreteTestingOrder concreteTestingOrder) async {
    int id = await db.insert(
        Constants.CONCRETE_TESTING_ORDERS, concreteTestingOrder.toMap());
    return findById(id);
  }

  Future<ConcreteTestingOrder> findById(int id) async {
    var result = await db.query(Constants.CONCRETE_TESTING_ORDERS,
        where: "id = ?", whereArgs: [id]);
    return mapToEntity(result.first);
  }

  Future<List<ConcreteTestingOrder>> findAll() async {
    var list = await db.query(Constants.CONCRETE_TESTING_ORDERS,
        orderBy: "testing_date DESC");
    return mapEntities(list);
  }

  Future<List<ConcreteTestingOrder>> mapEntities(
      List<Map<String, Object?>> result) async {
    // Map the results to a list of futures
    var futures = result.map((e) => mapToEntity(e)).toList();
    // Wait for all futures to complete
    return await Future.wait(futures);
  }

  Future<ConcreteTestingOrder> mapToEntity(Map<String, Object?> source) async {
    int customerId = (source["customer_id"] ?? 0) as int;
    var customerMap = await db.query(Constants.CUSTOMERS,
        where: "id = ?", whereArgs: [customerId], limit: 1);
    int projectSiteId = (source["project_site_id"] ?? 0) as int;
    var projectSiteMap = await db.query(Constants.PROJECT_SITES,
        where: "id = ?", whereArgs: [projectSiteId], limit: 1);
    int siteResidentId = (source["site_resident_id"] ?? 0) as int;
    var siteResidentMap = await db.query(Constants.SITE_RESIDENTS,
        where: "id = ?", whereArgs: [siteResidentId], limit: 1);
    int volumetricWeightId =
        (source["concrete_volumetric_weight_id"] ?? 0) as int;
    var volumetricWeightMap = await db.query(
        Constants.CONCRETE_VOLUMETRIC_WEIGHT,
        where: "id = ?",
        whereArgs: [volumetricWeightId],
        limit: 1);
    return ConcreteTestingOrder.toModel(
        source,
        customerMap.firstOrNull,
        projectSiteMap.firstOrNull,
        siteResidentMap.firstOrNull,
        volumetricWeightMap.firstOrNull);
  }

  Future<int> updateConcreteTestingDao(
      ConcreteTestingOrder selectedConcreteTestingOrder) async {
    int update = await db.update(
        Constants.CONCRETE_TESTING_ORDERS, selectedConcreteTestingOrder.toMap(),
        where: "id = ?", whereArgs: [selectedConcreteTestingOrder.id!]);
    return update;
  }
}
