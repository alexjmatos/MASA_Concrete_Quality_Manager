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
    int id = await db.insert(Constants.PROJECT_SITES, projectSite.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return findById(id);
  }

  Future<ProjectSite> findById(int id) async {
    List<Map<String, Object?>> records =
    await db.query(Constants.PROJECT_SITES, where: "id = ?", whereArgs: [id]);
    return records.map((e) => ProjectSite.toModel(e)).first;
  }
}
