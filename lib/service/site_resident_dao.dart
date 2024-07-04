import 'package:drift/drift.dart';
import 'package:injector/injector.dart';
import 'package:masa_epico_concrete_manager/dto/site_resident_dto.dart';

import '../database/app_database.dart';

class SiteResidentDAO {
  late final AppDatabase db;

  SiteResidentDAO() {
    final injector = Injector.appInstance;
    db = injector.get<AppDatabase>();
  }

  Future<SiteResident?> add(SiteResident siteResident) async {
    return await db
        .into(db.siteResidents)
        .insertReturning(siteResident, mode: InsertMode.insert);
  }

  Future<SiteResident?> findById(int id) async {
    return (db.select(db.siteResidents)..where((tbl) => tbl.id.equals(id)))
        .getSingleOrNull();
  }

  Future<List<SiteResidentDTO>> findByBuildingSiteId(int buildingSiteId) async {
    // Define table aliases for easier reference
    final bs = db.buildingSites;
    final sr = db.siteResidents;

    // Create a custom select statement
    final query = db.customSelect(
      'SELECT '
      'sr.id AS site_resident_id, '
      'sr.first_name, '
      'sr.last_name, '
      'sr.job_position '
      'FROM building_sites bs '
      'JOIN site_residents sr ON bs.site_resident_id = sr.id '
      'WHERE bs.id = ?',
      variables: [Variable.withInt(buildingSiteId)],
      readsFrom: {bs, sr},
    );

    // Execute the query and map the result
    final result = await query.map((row) {
      return SiteResidentDTO(
        id: row.read<int>('site_resident_id'),
        firstName: row.read<String>('first_name'),
        lastName: row.read<String>('last_name'),
        jobPosition: row.read<String>('job_position'),
      );
    }).get();

    return result;
  }

  Future<List<SiteResidentDTO>> findAll() async {
    return db.select(db.siteResidents).get().then(
      (value) {
        return value
            .map((e) => SiteResidentDTO(
                id: e.id!,
                firstName: e.firstName,
                lastName: e.lastName,
                jobPosition: e.jobPosition))
            .toList();
      },
    );
  }

  Future<SiteResident?> update(SiteResident siteResident) async {
    var result = await db.update(db.siteResidents).writeReturning(siteResident);
    return result.firstOrNull;
  }
}
