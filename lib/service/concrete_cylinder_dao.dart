import 'package:drift/drift.dart';
import 'package:injector/injector.dart';
import 'package:masa_epico_concrete_manager/database/app_database.dart';

import '../utils/sequential_counter_generator.dart';

class ConcreteCylinderDAO {
  late final AppDatabase db;
  final SequentialFormatter sequentialIdGenerator = SequentialFormatter();

  ConcreteCylinderDAO() {
    final injector = Injector.appInstance;
    db = injector.get<AppDatabase>();
  }

  Future<List<ConcreteCylinder>> findConcreteCylindersByTestingOrderId(
      AppDatabase db, int testingOrderId) async {
    // Construct the query
    final query = db.select(db.concreteCylinders).join([
      innerJoin(
          db.concreteSamples,
          db.concreteSamples.id
              .equalsExp(db.concreteCylinders.concreteSampleId)),
      innerJoin(
          db.concreteTestingOrders,
          db.concreteTestingOrders.id
              .equalsExp(db.concreteSamples.concreteTestingOrderId)),
    ]);

    // Add the filter condition
    query.where(db.concreteTestingOrders.id.equals(testingOrderId));

    // Execute the query and get the result
    final rows = await query.get();

    // Extract the concrete cylinders from the result rows
    return rows.map((row) {
      return row.readTable(db.concreteCylinders);
    }).toList();
  }
}
