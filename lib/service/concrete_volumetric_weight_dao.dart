import 'package:drift/drift.dart';
import 'package:injector/injector.dart';
import 'package:masa_epico_concrete_manager/database/app_database.dart';


class ConcreteVolumetricWeightDAO {
  late final AppDatabase db;

  ConcreteVolumetricWeightDAO() {
    final injector = Injector.appInstance;
    db = injector.get<AppDatabase>();
  }

  Future<ConcreteVolumetricWeight> add(
      ConcreteVolumetricWeight concreteVolumetricWeight) async {
    return await db
        .into(db.concreteVolumetricWeights)
        .insertReturning(concreteVolumetricWeight, mode: InsertMode.insert);
  }

  Future<ConcreteVolumetricWeight?> findById(int id) async {
    return (db.select(db.concreteVolumetricWeights)
          ..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
  }

  Future<ConcreteVolumetricWeight?> update(
      ConcreteVolumetricWeight concreteVolumetricWeight) async {
    var result = await db
        .update(db.concreteVolumetricWeights)
        .writeReturning(concreteVolumetricWeight);
    return result.firstOrNull;
  }
}
