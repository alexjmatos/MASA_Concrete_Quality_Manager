import 'package:drift/drift.dart';
import 'tables.dart';
import 'package:drift_sqflite/drift_sqflite.dart';
part 'app_database.g.dart';


@DriftDatabase(tables: [Customers, SiteResidents, BuildingSites, ConcreteVolumetricWeights, ConcreteTestingOrders, ConcreteSamples, ConcreteCylinders])
class AppDatabase extends _$AppDatabase {
  // we tell the database where to store the data with this constructor
  AppDatabase() : super(_openConnection());

  // you should bump this number whenever you change or add a table definition.
  // Migrations are covered later in the documentation.
  int get schemaVersion => 1;
}

QueryExecutor _openConnection() {
  return SqfliteQueryExecutor.inDatabaseFolder(path: 'app.db');
}
