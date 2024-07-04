import 'package:drift/drift.dart';
import 'package:injector/injector.dart';
import 'package:masa_epico_concrete_manager/dto/building_site_dto.dart';
import 'package:masa_epico_concrete_manager/dto/concrete_sample_dto.dart';
import 'package:masa_epico_concrete_manager/dto/concrete_testing_order_dto.dart';
import 'package:masa_epico_concrete_manager/dto/customer_dto.dart';

import '../database/app_database.dart';
import 'concrete_sample_dao.dart';

class ConcreteTestingOrderDAO {
  late final AppDatabase db;
  late final ConcreteSampleDAO concreteSampleDAO;

  ConcreteTestingOrderDAO() {
    final injector = Injector.appInstance;
    db = injector.get<AppDatabase>();
    concreteSampleDAO = ConcreteSampleDAO.withDB(db);
  }

  Future<ConcreteTestingOrder> add(
      ConcreteTestingOrder concreteTestingOrder) async {
    return await db
        .into(db.concreteTestingOrders)
        .insertReturning(concreteTestingOrder, mode: InsertMode.insert);
  }

  Future<ConcreteTestingOrderDTO> findById(int id) async {
    // Define table aliases for easier reference
    final cto = db.concreteTestingOrders;
    final c = db.customers;
    final bs = db.buildingSites;

    // Create a custom select statement
    final query = db.customSelect(
      'SELECT '
          'cto.id AS testing_order_id, '
          'cto.design_resistance, '
          'cto.slumping_cm, '
          'cto.total_volume_m3, '
          'cto.tma_mm, '
          'cto.design_age, '
          'cto.testing_date, '
          'c.id AS customer_id, '
          'c.identifier, '
          'c.company_name, '
          'bs.id AS building_site_id, '
          'bs.site_name, '
          'FROM concrete_testing_orders cto '
          'JOIN customers c ON cto.customer_id = c.id '
          'JOIN building_sites bs ON cto.building_site_id = bs.id'
          'WHERE cto.id = ?',
      variables: [Variable.withInt(id)],
      readsFrom: {cto, c, bs},
    );

    // Execute the query and map the result
    final result = await query.map((row) {
      final customer = CustomerDTO(
        id: row.read<int>('customer_id'),
        identifier: row.read<String>('identifier'),
        companyName: row.read<String>('company_name'),
      );

      final buildingSite = BuildingSiteDTO(
        id: row.read<int>('building_site_id'),
        siteName: row.read<String>('site_name'),
      );

      return ConcreteTestingOrderDTO(
        id: row.read<int>('testing_order_id'),
        designResistance: row.read<String>('design_resistance'),
        slumpingCm: row.read<int>('slumping_cm'),
        volumeM3: row.read<int>('volume_m3'),
        tmaMm: row.read<int>('tma_mm'),
        designAge: row.read<String>('design_age'),
        testingDate:
        DateTime.fromMillisecondsSinceEpoch(row.read<int>('testing_date')),
        customer: customer,
        buildingSite: buildingSite,
        concreteSamples: [],
      );
    }).get();

    // FIND THE CONCRETE SAMPLES FOR EACH CONCRETE TESTING ORDER AND ALSO FIND THEIR CORRESPONDING CYLINDERS
    for (var element in result) {
      List<ConcreteSampleDTO> samples =
      await concreteSampleDAO.getConcreteSamplesByOrderId(element.id!);
      element.concreteSamples = samples;
    }

    return result.first;
  }

  Future<List<ConcreteTestingOrderDTO>> findAll() async {
    // Define table aliases for easier reference
    final cto = db.concreteTestingOrders;
    final c = db.customers;
    final bs = db.buildingSites;

    // Create a custom select statement
    final query = db.customSelect(
      'SELECT '
          'cto.id AS testing_order_id, '
          'cto.design_resistance, '
          'cto.slumping_cm, '
          'cto.total_volume_m3, '
          'cto.tma_mm, '
          'cto.design_age, '
          'cto.testing_date, '
          'c.id AS customer_id, '
          'c.identifier, '
          'c.company_name, '
          'bs.id AS building_site_id, '
          'bs.site_name '
          'FROM concrete_testing_orders cto '
          'JOIN customers c ON cto.customer_id = c.id '
          'JOIN building_sites bs ON cto.building_site_id = bs.id',
      readsFrom: {cto, c, bs},
    );

    // Execute the query and map the result
    final result = await query.map((row) {
      final customer = CustomerDTO(
        id: row.read<int>('customer_id'),
        identifier: row.read<String>('identifier'),
        companyName: row.read<String>('company_name'),
      );

      final buildingSite = BuildingSiteDTO(
        id: row.read<int>('building_site_id'),
        siteName: row.read<String>('site_name'),
      );

      return ConcreteTestingOrderDTO(
        id: row.read<int>('testing_order_id'),
        designResistance: row.read<String>('design_resistance'),
        slumpingCm: row.read<int>('slumping_cm'),
        volumeM3: row.read<int>('volume_m3'),
        tmaMm: row.read<int>('tma_mm'),
        designAge: row.read<String>('design_age'),
        testingDate:
        DateTime.fromMillisecondsSinceEpoch(row.read<int>('testing_date')),
        customer: customer,
        buildingSite: buildingSite,
        concreteSamples: [],
      );
    }).get();

    // FIND THE CONCRETE SAMPLES FOR EACH CONCRETE TESTING ORDER AND ALSO FIND THEIR CORRESPONDING CYLINDERS
    for (var element in result) {
      List<ConcreteSampleDTO> samples =
      await concreteSampleDAO.getConcreteSamplesByOrderId(element.id!);
      element.concreteSamples = samples;
    }

    return result;
  }

  Future<ConcreteTestingOrder> update(
      ConcreteTestingOrder selectedConcreteTestingOrder) async {
    return db
        .into(db.concreteTestingOrders)
        .insertReturning(selectedConcreteTestingOrder, mode: InsertMode.insert);
  }
}
