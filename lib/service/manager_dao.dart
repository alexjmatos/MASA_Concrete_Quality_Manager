import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:injector/injector.dart';
import 'package:masa_epico_concrete_manager/constants/constants.dart';
import 'package:masa_epico_concrete_manager/models/manager.dart';
import 'package:pocketbase/pocketbase.dart';

class ManagerDao {
  late final PocketBase pb;

  ManagerDao() {
    final injector = Injector.appInstance;
    pb = injector.get<PocketBase>();
  }
  
  Future<RecordModel> addManager(Manager manager) async {
    await pb.admins.authWithPassword(
        dotenv.get("ADMIN_USERNAME"), dotenv.get("ADMIN_PASSWORD"));
    return await pb
        .collection(Constants.MANAGERS)
        .create(body: manager.toMap());
  }
}
