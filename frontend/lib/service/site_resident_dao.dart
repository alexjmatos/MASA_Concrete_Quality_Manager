import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:masa_epico_concrete_manager/constants/constants.dart';
import 'package:masa_epico_concrete_manager/models/site_resident.dart';
import 'package:pocketbase/pocketbase.dart';

class SiteResidentDao {
  final pb = PocketBase(dotenv.get("BACKEND_URL"));

  Future<RecordModel> addSiteResident(SiteResident siteResident) async {
    await pb.admins.authWithPassword(
        dotenv.get("ADMIN_USERNAME"), dotenv.get("ADMIN_PASSWORD"));
    return await pb
        .collection(Constants.SITE_RESIDENTS)
        .create(body: siteResident.toMap());
  }
}
