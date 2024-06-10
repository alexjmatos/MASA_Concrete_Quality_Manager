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

  Future<BuildingSite> add(BuildingSite projectSite) async {
    // ADD PROJECT SITE TO THE project_sites table
    int id = await db.insert(Constants.PROJECT_SITES, projectSite.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return findById(id);
  }

  Future<BuildingSite> findById(int id) async {
    List<Map<String, Object?>> records = await db.rawQuery("""
        SELECT project_sites.id, project_sites.site_name, 
		    customers.id as customer_id, customers.identifier, customers.company_name, 
		    site_residents.id AS site_resident_id, site_residents.first_name, site_residents.last_name, site_residents.job_position
        FROM project_sites 
        INNER JOIN customers ON project_sites.customer_id = customers.id
        INNER JOIN site_residents ON project_sites.site_resident_id = site_residents.id
        WHERE project_sites.id = ?;
        """, [id]);
    return records.map((e) => BuildingSite.toModel(e)).first;
  }

  Future<List<BuildingSite>> findByClientId(int clientId) async {
    List<Map<String, Object?>> records = await db.query(Constants.PROJECT_SITES,
        where: "customer_id = ?", whereArgs: [clientId]);
    return records.map((e) => BuildingSite.toModel(e)).toList();
  }

  Future<List<BuildingSite>> findAll() async {
    List<Map<String, Object?>> records = await db.rawQuery("""
        SELECT project_sites.id, project_sites.site_name, 
		    customers.id as customer_id, customers.identifier, customers.company_name, 
		    site_residents.id AS site_resident_id, site_residents.first_name, site_residents.last_name, site_residents.job_position
        FROM project_sites 
        INNER JOIN customers ON project_sites.customer_id = customers.id
        INNER JOIN site_residents ON project_sites.site_resident_id = site_residents.id;
        """);
    return records.map((e) => BuildingSite.toModel(e)).toList();
  }

  Future<BuildingSite> update(BuildingSite toBeUpdated) async {
    // Update the Building Site
    await db.update(Constants.PROJECT_SITES, toBeUpdated.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
        where: "id = ?",
        whereArgs: [toBeUpdated.id]);

    return findById(toBeUpdated.id!);
  }
}
