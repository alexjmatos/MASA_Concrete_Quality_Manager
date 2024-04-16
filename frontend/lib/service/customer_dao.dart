import 'package:injector/injector.dart';
import 'package:masa_epico_concrete_manager/constants/constants.dart';
import 'package:masa_epico_concrete_manager/models/customer.dart';
import 'package:masa_epico_concrete_manager/service/location_dao.dart';
import 'package:masa_epico_concrete_manager/service/manager_dao.dart';
import 'package:masa_epico_concrete_manager/utils/sequential_counter_generator.dart';
import 'package:pocketbase/pocketbase.dart';

class CustomerDao {
  late final PocketBase pb;
  final LocationDao locationDao = LocationDao();
  final ManagerDao managerDao = ManagerDao();
  final SequentialIdGenerator sequentialIdGenerator = SequentialIdGenerator();

  CustomerDao() {
    final injector = Injector.appInstance;
    pb = injector.get<PocketBase>();
  }

  Future<RecordModel> addCustomer(Customer customer) async {
    // Generate a next sequence for customer
    List<int> sequenceCustomer = await Future.wait([sequentialIdGenerator.getNextSequence(Constants.CUSTOMERS)]);
    customer.sequence = sequenceCustomer[0];
  
    return await pb
        .collection(Constants.CUSTOMERS)
        .create(body: customer.toMap());
  }

  Future<List<Customer>> getAllCustomers() async {
    List<RecordModel> models = await pb
        .collection(Constants.CUSTOMERS)
        .getFullList(sort: '-created', expand: "obras,obras.direccion_id,obras.residentes_asignados");

    return models.map((e) {
      return Customer.toModel(e.toJson());
    }).toList();
  }
}
