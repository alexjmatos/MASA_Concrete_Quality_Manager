import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:masa_epico_concrete_manager/constants/constants.dart';
import 'package:masa_epico_concrete_manager/models/project_site.dart';
import 'package:masa_epico_concrete_manager/service/location_dao.dart';
import 'package:masa_epico_concrete_manager/service/site_resident_dao.dart';
import 'package:pocketbase/pocketbase.dart';

class ProjectSiteDao {
  final pb = PocketBase(dotenv.get("BACKEND_URL"));
  final LocationDao locationDao = LocationDao();
  final SiteResidentDao siteResidentDao = SiteResidentDao();

  Future<RecordModel> addProjectSite(ProjectSite projectSite) async {
    await pb.admins.authWithPassword(
        dotenv.get("ADMIN_USERNAME"), dotenv.get("ADMIN_PASSWORD"));

    // Add Site Resident
    Future<RecordModel> addSiteResidentFuture =
        siteResidentDao.addSiteResident(projectSite.residents.first);

    addSiteResidentFuture.then((value) {
      projectSite.residents.first.id = value.id;
    });

    // Add Location
    Future<RecordModel> addLocationFuture =
        locationDao.addLocation(projectSite.location);

    addLocationFuture.then((value) {
      projectSite.location.id = value.id;
    });

    // Add the project site
    // Wait for both futures to complete
    // Add the customer
    // Wait for both futures to complete
    await Future.wait([addSiteResidentFuture, addLocationFuture]);

    return await pb
        .collection(Constants.PROJECT_SITES)
        .create(body: projectSite.toMap());
  }
}
