import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:masa_epico_concrete_manager/constants/constants.dart';
import 'package:masa_epico_concrete_manager/models/manager.dart';
import 'package:pocketbase/pocketbase.dart';

class ManagerDao {
  final pb = PocketBase(dotenv.get("BACKEND_URL"));

  Future<RecordModel> addManager(Manager manager) async {
    final authData =
        await pb.admins.authWithPassword(dotenv.get("ADMIN_USERNAME"), dotenv.get("ADMIN_PASSWORD"));
    return await pb
        .collection(Constants.MANAGERS)
        .create(body: manager.toMap());
  }
}
