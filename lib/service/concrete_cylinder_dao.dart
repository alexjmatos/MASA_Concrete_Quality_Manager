import 'package:injector/injector.dart';
import 'package:masa_epico_concrete_manager/models/concrete_sample_cylinder.dart';
import 'package:sqflite/sqflite.dart';

import '../constants/constants.dart';
import '../utils/sequential_counter_generator.dart';

class ConcreteCylinderDAO {
  late final Database db;
  final SequentialFormatter sequentialIdGenerator = SequentialFormatter();

  ConcreteCylinderDAO() {
    final injector = Injector.appInstance;
    db = injector.get<Database>();
  }

  Future<List<ConcreteSampleCylinder>> findByConcreteTestingOrder(int? id) async {
    var result = await db.query(Constants.CONCRETE_TESTING_CYLINDERS,
        where: "concrete_sample_id = ?", whereArgs: [id]);
    return result.map((e) => ConcreteSampleCylinder.toModel(e)).toList();
  }
}
