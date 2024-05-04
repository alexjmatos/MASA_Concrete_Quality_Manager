import 'package:injector/injector.dart';
import 'package:masa_epico_concrete_manager/constants/constants.dart';
import 'package:masa_epico_concrete_manager/models/site_resident.dart';
import 'package:sqflite/sqflite.dart';

class SiteResidentDao {
  late final Database db;

  SiteResidentDao() {
    final injector = Injector.appInstance;
    db = injector.get<Database>();
  }

  Future<SiteResident> addSiteResident(SiteResident siteResident) async {
    int id = await db.insert(Constants.SITE_RESIDENTS, siteResident.toMap());
    return findById(id);
  }

  Future<SiteResident> findById(int id) async {
    List<Map<String, Object?>> records = await db
        .query(Constants.SITE_RESIDENTS, where: "id = ?", whereArgs: [id]);
    return records.map((e) => SiteResident.toModel(e)).first;
  }

  Future<List<SiteResident>> getSiteResidentsByIds(
      List<String> residentsId) async {
    return List.empty();
  }

  Future<List<SiteResident>> getAllSiteResidents() async {
    return List.empty();
  }
}
