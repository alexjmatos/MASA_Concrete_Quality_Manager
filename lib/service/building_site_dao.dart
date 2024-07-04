import 'package:drift/drift.dart';
import 'package:injector/injector.dart';
import 'package:masa_epico_concrete_manager/database/app_database.dart';
import 'package:masa_epico_concrete_manager/dto/building_site_dto.dart';
import 'package:masa_epico_concrete_manager/dto/customer_dto.dart';
import 'package:masa_epico_concrete_manager/dto/site_resident_dto.dart';
import 'package:masa_epico_concrete_manager/service/customer_dao.dart';
import 'package:masa_epico_concrete_manager/service/site_resident_dao.dart';

class BuildingSiteDAO {
  late final AppDatabase db;
  final SiteResidentDAO siteResidentDao = SiteResidentDAO();
  final CustomerDAO customerDao = CustomerDAO();

  BuildingSiteDAO() {
    final injector = Injector.appInstance;
    db = injector.get<AppDatabase>();
  }

  Future<BuildingSite?> add(BuildingSite buildingSite) async {
    return await db
        .into(db.buildingSites)
        .insertReturning(buildingSite, mode: InsertMode.insert);
  }

  Future<BuildingSiteDTO> findById(int id) async {
    // Define table aliases for easier reference
    final bs = db.buildingSites;
    final c = db.customers;
    final sr = db.siteResidents;

    // Create a custom select statement
    final query = db.customSelect(
      'SELECT '
      'bs.id AS building_site_id, '
      'bs.site_name, '
      'c.id AS customer_id, '
      'c.identifier, '
      'c.company_name, '
      'sr.id AS site_resident_id, '
      'sr.first_name, '
      'sr.last_name, '
      'sr.job_position '
      'FROM building_sites bs '
      'LEFT JOIN customers c ON bs.customer_id = c.id '
      'LEFT JOIN site_residents sr ON bs.site_resident_id = sr.id'
      'WHERE bs.id = ?',
      variables: [Variable.withInt(id)],
      readsFrom: {bs, c, sr},
    );

    // Execute the query and map the result
    final result = await query.map((row) {
      final customer = row.read<int?>('customer_id') != null
          ? CustomerDTO(
              id: row.read<int>('customer_id'),
              identifier: row.read<String>('identifier'),
              companyName: row.read<String>('company_name'),
            )
          : null;

      final siteResident = row.read<int?>('site_resident_id') != null
          ? SiteResidentDTO(
              id: row.read<int>('site_resident_id'),
              firstName: row.read<String>('first_name'),
              lastName: row.read<String>('last_name'),
              jobPosition: row.read<String>('job_position'),
            )
          : null;

      return BuildingSiteDTO(
        id: row.read<int>('building_site_id'),
        siteName: row.read<String>('site_name'),
        customer: customer,
        siteResident: siteResident,
      );
    }).get();

    return result.first;
  }

  Future<List<BuildingSiteDTO>> findByClientId(int customerId) async {
    // Define table aliases for easier reference
    final bs = db.buildingSites;
    final c = db.customers;
    final sr = db.siteResidents;

    // Create a custom select statement
    final query = db.customSelect(
      'SELECT '
      'bs.id AS building_site_id, '
      'bs.site_name, '
      'c.id AS customer_id, '
      'c.identifier, '
      'c.company_name, '
      'sr.id AS site_resident_id, '
      'sr.first_name, '
      'sr.last_name, '
      'sr.job_position '
      'FROM building_sites bs '
      'LEFT JOIN customers c ON bs.customer_id = c.id '
      'LEFT JOIN site_residents sr ON bs.site_resident_id = sr.id'
      'WHERE c.id = ?',
      variables: [Variable.withInt(customerId)],
      readsFrom: {bs, c, sr},
    );

    // Execute the query and map the result
    final result = await query.map((row) {
      final customer = row.read<int?>('customer_id') != null
          ? CustomerDTO(
              id: row.read<int>('customer_id'),
              identifier: row.read<String>('identifier'),
              companyName: row.read<String>('company_name'),
            )
          : null;

      final siteResident = row.read<int?>('site_resident_id') != null
          ? SiteResidentDTO(
              id: row.read<int>('site_resident_id'),
              firstName: row.read<String>('first_name'),
              lastName: row.read<String>('last_name'),
              jobPosition: row.read<String>('job_position'),
            )
          : null;

      return BuildingSiteDTO(
        id: row.read<int>('building_site_id'),
        siteName: row.read<String>('site_name'),
        customer: customer,
        siteResident: siteResident,
      );
    }).get();

    return result;
  }

  Future<List<BuildingSiteDTO>> findAll() async {
    // Define table aliases for easier reference
    final bs = db.buildingSites;
    final c = db.customers;
    final sr = db.siteResidents;

    // Create a custom select statement
    final query = db.customSelect(
      'SELECT '
      'bs.id AS building_site_id, '
      'bs.site_name, '
      'c.id AS customer_id, '
      'c.identifier, '
      'c.company_name, '
      'sr.id AS site_resident_id, '
      'sr.first_name, '
      'sr.last_name, '
      'sr.job_position '
      'FROM building_sites bs '
      'LEFT JOIN customers c ON bs.customer_id = c.id '
      'LEFT JOIN site_residents sr ON bs.site_resident_id = sr.id',
      readsFrom: {bs, c, sr},
    );

    // Execute the query and map the result
    final result = await query.map((row) {
      final customer = row.read<int?>('customer_id') != null
          ? CustomerDTO(
              id: row.read<int>('customer_id'),
              identifier: row.read<String>('identifier'),
              companyName: row.read<String>('company_name'),
            )
          : null;

      final siteResident = row.read<int?>('site_resident_id') != null
          ? SiteResidentDTO(
              id: row.read<int>('site_resident_id'),
              firstName: row.read<String>('first_name'),
              lastName: row.read<String>('last_name'),
              jobPosition: row.read<String>('job_position'),
            )
          : null;

      return BuildingSiteDTO(
        id: row.read<int>('building_site_id'),
        siteName: row.read<String>('site_name'),
        customer: customer,
        siteResident: siteResident,
      );
    }).get();

    return result;
  }

  Future<BuildingSite?> update(BuildingSite toBeUpdated) async {
    var result = await db.update(db.buildingSites).writeReturning(toBeUpdated);
    return result.firstOrNull;
  }
}
