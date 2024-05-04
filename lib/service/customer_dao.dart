import 'package:injector/injector.dart';
import 'package:masa_epico_concrete_manager/constants/constants.dart';
import 'package:masa_epico_concrete_manager/models/customer.dart';
import 'package:masa_epico_concrete_manager/service/location_dao.dart';
import 'package:masa_epico_concrete_manager/service/manager_dao.dart';
import 'package:masa_epico_concrete_manager/utils/sequential_counter_generator.dart';
import 'package:sqflite/sqflite.dart';

class CustomerDao {
  late final Database db;
  final LocationDao locationDao = LocationDao();
  final ManagerDao managerDao = ManagerDao();
  final SequentialIdGenerator sequentialIdGenerator = SequentialIdGenerator();

  CustomerDao() {
    final injector = Injector.appInstance;
    db = injector.get<Database>();
  }

  Future<Customer> addCustomer(Customer customer) async {
    int id = await db.insert(Constants.CUSTOMERS, customer.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return findById(id);
  }

  Future<List<Customer>> getAllCustomers() async {
    List<Map<String, Object?>> records = await db.query(Constants.CUSTOMERS);
    return records.map((e) => Customer.toModel(e)).toList();
  }

  Future<Customer> findById(int id) async {
    List<Map<String, Object?>> records =
        await db.query(Constants.CUSTOMERS, where: "id = ?", whereArgs: [id]);
    return records.map((e) => Customer.toModel(e)).first;
  }
}
