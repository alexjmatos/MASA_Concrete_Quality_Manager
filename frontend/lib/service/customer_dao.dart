import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:masa_epico_concrete_manager/constants/constants.dart';
import 'package:masa_epico_concrete_manager/models/customer.dart';
import 'package:masa_epico_concrete_manager/service/location_dao.dart';
import 'package:masa_epico_concrete_manager/service/manager_dao.dart';
import 'package:pocketbase/pocketbase.dart';

class CustomerDao {
  final pb = PocketBase(dotenv.get("BACKEND_URL"));
  final LocationDao locationDao = LocationDao();
  final ManagerDao managerDao = ManagerDao();

  Future<RecordModel> addCustomer(Customer customer) async {
    final authData = await pb.admins.authWithPassword(
        dotenv.get("ADMIN_USERNAME"), dotenv.get("ADMIN_PASSWORD"));
    // Add the manager
    Future<RecordModel> addManagerFuture =
        managerDao.addManager(customer.manager);

    addManagerFuture.then((value) {
      customer.manager.id = value.id;
    });

    // Add the location
    Future<RecordModel> addLocation =
        locationDao.addLocation(customer.mainLocation);

    addLocation.then((value) {
      customer.mainLocation.id = value.id;
    });

    // Add the customer
    // Wait for both futures to complete
    await Future.wait([addManagerFuture, addLocation]);

    return await pb
        .collection(Constants.CUSTOMERS)
        .create(body: customer.toMap());
  }
}
