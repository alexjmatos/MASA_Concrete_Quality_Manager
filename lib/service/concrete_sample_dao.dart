import 'package:drift/drift.dart';
import 'package:injector/injector.dart';
import 'package:masa_epico_concrete_manager/database/app_database.dart';
import 'package:masa_epico_concrete_manager/dto/concrete_cylinder_dto.dart';
import 'package:masa_epico_concrete_manager/dto/concrete_sample_dto.dart';

import '../utils/sequential_counter_generator.dart';
import '../utils/utils.dart';
import 'concrete_cylinder_dao.dart';

class ConcreteSampleDAO {
  late final AppDatabase db;
  final SequentialFormatter sequentialIdGenerator = SequentialFormatter();
  final ConcreteCylinderDAO concreteCylinderDao = ConcreteCylinderDAO();

  ConcreteSampleDAO() {
    final injector = Injector.appInstance;
    db = injector.get<AppDatabase>();
  }

  ConcreteSampleDAO.withDB(this.db);

  Future<List<ConcreteSample>> findAll() async {
    return await db.select(db.concreteSamples).get();
  }

  Future<List<ConcreteSample>> addAll(List<ConcreteSample> samples) async {
    List<ConcreteSample> inserted = [];
    await db.transaction(() async {
      for (var sample in samples) {
        final result = await db.into(db.concreteSamples).insertReturning(
              sample,
              mode: InsertMode.insert,
            );
        inserted.add(result);
      }
    });
    return inserted;
  }

  Future<List<ConcreteCylinder>> addAllCylinders(
      List<ConcreteCylinder> cylinders) async {
    List<ConcreteCylinder> inserted = [];
    await db.transaction(() async {
      for (var cylinder in cylinders) {
        final result = await db.into(db.concreteCylinders).insertReturning(
              cylinder,
              mode: InsertMode.insert,
            );
        inserted.add(result);
      }
    });
    return inserted;
  }

  Future<List<ConcreteSample>> findByOrderId(int? id) async {
    var query = db.select(db.concreteSamples)
      ..where((tbl) => tbl.concreteTestingOrderId.equals(id!));
    final result = await query.get();
    return result.toList();
  }

  Future<int> findNextCounterByBuildingSite(int id) async {
    // Define table aliases for easier reference
    final bs = db.buildingSites;
    final cto = db.concreteTestingOrders;
    final cs = db.concreteSamples;
    final cc = db.concreteCylinders;

    // Create a custom select statement
    final query = db.customSelect(
      'SELECT '
      'bs.id AS building_site_id, '
      'COUNT(DISTINCT cc.building_site_sample_number) AS incremental_sample_number '
      'FROM building_sites bs '
      'JOIN concrete_testing_orders cto ON bs.id = cto.building_site_id '
      'JOIN concrete_samples cs ON cto.id = cs.concrete_testing_order_id '
      'JOIN concrete_cylinders cc ON cs.id = cc.concrete_sample_id '
      'WHERE bs.id = ?',
      variables: [Variable.withInt(id)],
      readsFrom: {bs, cto, cs, cc},
    );

    // Execute the query and map the result
    final result = await query.getSingle();
    return result.data['building_site_id'] as int;
  }

  // Define the method to get all concrete samples with their corresponding concrete cylinders by concrete testing order ID
  Future<List<ConcreteSampleDTO>> getConcreteSamplesByOrderId(
      int orderId) async {
    // Define table aliases for easier reference
    final cs = db.concreteSamples;
    final cc = db.concreteCylinders;

    // Create a custom select statement
    final query = db.customSelect(
      'SELECT '
      'cs.id AS sample_id, '
      'cs.remission, '
      'cs.volume, '
      'cs.plant_time, '
      'cs.building_site_time, '
      'cs.real_slumping_cm, '
      'cs.temperature_celsius, '
      'cs.location, '
      'cc.id AS cylinder_id, '
      'cc.building_site_sample_number, '
      'cc.testing_age_days, '
      'cc.testing_date, '
      'cc.total_load_kg, '
      'cc.diameter_cm, '
      'cc.resistance_kgf_cm2, '
      'cc.median, '
      'cc.percentage '
      'FROM concrete_samples cs '
      'LEFT JOIN concrete_cylinders cc ON cs.id = cc.concrete_sample_id '
      'WHERE cs.concrete_testing_order_id = ?',
      variables: [Variable.withInt(orderId)],
      readsFrom: {cs, cc},
    );

    // Execute the query and map the result
    final result = await query.map((row) {
      final cylinder = ConcreteCylinderDTO(
        id: row.read<int>('cylinder_id'),
        buildingSiteSampleNumber: row.read<int>('building_site_sample_number'),
        testingAgeDays: row.read<int>('testing_age_days'),
        testingDate:
            DateTime.fromMillisecondsSinceEpoch(row.read<int>('testing_date')),
        totalLoad: row.read<double>('total_load_kg'),
        diameter: row.read<double>('diameter_cm'),
        resistance: row.read<double>('resistance_kgf_cm2'),
        median: row.read<double>('median'),
        percentage: row.read<double>('percentage'),
      );

      return ConcreteSampleDTO(
        id: row.read<int>('sample_id'),
        remission: row.read<String>('remission'),
        volume: row.read<double>('volume'),
        plantTime: Utils.parseTimeOfDay(row.read<String>('plant_time')),
        buildingSiteTime:
            Utils.parseTimeOfDay(row.read<String>('building_site_time')),
        realSlumpingCm: row.read<double>('real_slumping_cm'),
        temperatureCelsius: row.read<double>('temperature_celsius'),
        location: row.read<String>('location'),
        cylinders: [cylinder],
      );
    }).get();

    // Group results by sample ID
    final Map<int, ConcreteSampleDTO> groupedResults = {};
    for (var item in result) {
      if (groupedResults.containsKey(item.id)) {
        groupedResults[item.id]!.cylinders?.addAll(item.cylinders ?? []);
      } else {
        groupedResults[item.id ?? 0] = item;
      }
    }

    return groupedResults.values.toList();
  }
}
