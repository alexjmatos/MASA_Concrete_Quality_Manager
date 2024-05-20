import 'package:injector/injector.dart';
import 'package:masa_epico_concrete_manager/models/project_site.dart';
import 'package:masa_epico_concrete_manager/service/customer_dao.dart';
import 'package:masa_epico_concrete_manager/service/site_resident_dao.dart';
import 'package:sqflite/sqflite.dart';

import '../constants/constants.dart';

class ProjectSiteDao {
  late final Database db;
  final SiteResidentDao siteResidentDao = SiteResidentDao();
  final CustomerDao customerDao = CustomerDao();

  ProjectSiteDao() {
    final injector = Injector.appInstance;
    db = injector.get<Database>();
  }

  Future<ProjectSite> addProjectSite(ProjectSite projectSite) async {
    // ADD PROJECT SITE TO THE project_sites table
    int id = await db.insert(Constants.PROJECT_SITES, projectSite.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);

    // ADD THE PROJECT SITE AND SITE RESIDENT TO THE MANY-MANY TABLE
    await db.insert(Constants.MANY_TO_MANY_PROJECT_SITES_SITE_RESIDENTS, {
      "project_site_id": id,
      "site_resident_id": projectSite.residents.first?.id
    });
    return findById(id);
  }

  Future<ProjectSite> findById(int id) async {
    List<Map<String, Object?>> records = await db
        .query(Constants.PROJECT_SITES, where: "id = ?", whereArgs: [id]);
    return records.map((e) => ProjectSite.toModel(e)).first;
  }

  Future<List<ProjectSite>> findProjectSitesByClientId(int clientId) async {
    List<Map<String, Object?>> records = await db.query(Constants.PROJECT_SITES,
        where: "customer_id = ?", whereArgs: [clientId]);
    return records.map((e) => ProjectSite.toModel(e)).toList();
  }
}
