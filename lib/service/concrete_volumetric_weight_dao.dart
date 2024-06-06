import 'package:injector/injector.dart';
import 'package:masa_epico_concrete_manager/models/concrete_volumetric_weight.dart';
import 'package:sqflite/sqflite.dart';

import '../constants/constants.dart';
import '../utils/sequential_counter_generator.dart';

class ConcreteVolumetricWeightDao {
  late final Database db;
  final SequentialIdGenerator sequentialIdGenerator = SequentialIdGenerator();

  ConcreteVolumetricWeightDao() {
    final injector = Injector.appInstance;
    db = injector.get<Database>();
  }

  Future<ConcreteVolumetricWeight?> addConcreteVolumetricWeight(
      ConcreteVolumetricWeight concreteVolumetricWeight) async {
    int id = await db.insert(
        Constants.CONCRETE_VOLUMETRIC_WEIGHT, concreteVolumetricWeight.toMap());
    return findById(id);
  }

  Future<ConcreteVolumetricWeight?> findById(int id) async {
    var list = await db.query(Constants.CONCRETE_VOLUMETRIC_WEIGHT,
        where: "id = ?", whereArgs: [id], limit: 1);
    return ConcreteVolumetricWeight.toModel(list.first);
  }
}