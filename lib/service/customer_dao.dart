import 'package:drift/drift.dart';
import 'package:injector/injector.dart';
import 'package:masa_epico_concrete_manager/dto/customer_dto.dart';
import 'package:masa_epico_concrete_manager/utils/sequential_counter_generator.dart';

import '../database/app_database.dart';

class CustomerDAO {
  late final AppDatabase db;
  final SequentialFormatter sequentialIdGenerator = SequentialFormatter();

  CustomerDAO() {
    final injector = Injector.appInstance;
    db = injector.get<AppDatabase>();
  }

  Future<Customer> add(Customer customer) async {
    return await db
        .into(db.customers)
        .insertReturning(customer, mode: InsertMode.insert);
  }

  Future<List<CustomerDTO>> findAll() async {
    return db.select(db.customers).get().then(
      (value) {
        return value
            .map((e) => CustomerDTO(
                id: e.id!,
                identifier: e.identifier,
                companyName: e.companyName))
            .toList();
      },
    );
  }

  Future<CustomerDTO?> findById(int id) async {
    return (db.select(db.customers)..where((tbl) => tbl.id.equals(id))).map(
      (p0) {
        return CustomerDTO(
            id: p0.id, identifier: p0.identifier, companyName: p0.companyName);
      },
    ).getSingleOrNull();
  }

  Future<Customer?> update(Customer customer) async {
    var result = await db.update(db.customers).writeReturning(customer);
    return result.firstOrNull;
  }
}
