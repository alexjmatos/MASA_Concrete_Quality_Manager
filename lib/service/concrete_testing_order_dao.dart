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
    return result.map((source) async {
      int customerId = source["customer_id"] as int;
      var customerMap = await db.query(Constants.CUSTOMERS,
          where: "id = ?", whereArgs: [customerId], limit: 1);
      int projectSiteId = source["project_site_id"] as int;
      var projectSiteMap = await db.query(Constants.PROJECT_SITES,
          where: "id = ?", whereArgs: [projectSiteId]);
      int siteResidentId = source["site_resident_id"] as int;
      var siteResidentMap = await db.query(Constants.SITE_RESIDENTS,
          where: "id = ?", whereArgs: [siteResidentId]);
      return ConcreteTestingOrder.toModel(source, customerMap.first,
          projectSiteMap.first, siteResidentMap.first);
    }).first;
  }
}
