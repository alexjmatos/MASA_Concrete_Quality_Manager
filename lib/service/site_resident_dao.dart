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
    int id = await db.insert(Constants.SITE_RESIDENTS, siteResident.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return findById(id);
  }

  Future<SiteResident> findById(int id) async {
    List<Map<String, Object?>> records = await db
        .query(Constants.SITE_RESIDENTS, where: "id = ?", whereArgs: [id]);
    return records.map((e) => SiteResident.toModel(e)).first;
  }

  Future<List<SiteResident>> getAllSiteResidents() async {
    var list = await db.query(Constants.SITE_RESIDENTS);
    return list.map((e) => SiteResident.toModel(e)).toList();
  }

  Future<List<SiteResident>> getSiteResidentsByProjectSiteId(
      int projectId) async {
    var result = await db.rawQuery("""
    SELECT id, first_name, last_name, job_position FROM site_residents where id in 
(SELECT site_resident_id from project_site_resident where project_site_id = ?);
    """, [projectId]);
    return result.map((e) => SiteResident.toModel(e)).toList();
  }
}
