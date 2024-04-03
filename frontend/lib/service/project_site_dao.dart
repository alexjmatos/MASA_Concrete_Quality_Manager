import 'package:injector/injector.dart';
import 'package:masa_epico_concrete_manager/constants/constants.dart';
import 'package:masa_epico_concrete_manager/models/project_site.dart';
import 'package:masa_epico_concrete_manager/models/site_resident.dart';
import 'package:masa_epico_concrete_manager/service/location_dao.dart';
import 'package:masa_epico_concrete_manager/service/site_resident_dao.dart';
import 'package:masa_epico_concrete_manager/utils/sequential_counter_generator.dart';
import 'package:pocketbase/pocketbase.dart';

class ProjectSiteDao {
  late final PocketBase pb;
  final LocationDao locationDao = LocationDao();
  final SiteResidentDao siteResidentDao = SiteResidentDao();
  late final SequentialIdGenerator sequentialIdGenerator;

  ProjectSiteDao() {
    final injector = Injector.appInstance;
    pb = injector.get<PocketBase>();
    sequentialIdGenerator = injector.get<SequentialIdGenerator>();
  }

  Future<RecordModel> addProjectSite(ProjectSite projectSite) async {
    List<int> sequenceSiteResident = await Future.wait(
        [sequentialIdGenerator.getNextSequence(Constants.SITE_RESIDENTS)]);
    int currentSequenceSiteResident = sequenceSiteResident[0];

    for (SiteResident siteResident in projectSite.residents) {
      // Generate a next sequence for site resident
      siteResident.sequence = currentSequenceSiteResident;
      currentSequenceSiteResident++;
    }

    // Add Site Resident
    Future<RecordModel> addSiteResidentFuture =
        siteResidentDao.addSiteResident(projectSite.residents.first);

    addSiteResidentFuture.then((value) {
      projectSite.residents.first.id = value.id;
    });

    // Add Location
    // Generate a next sequence for customer
    List<int> sequenceLocations = await Future.wait(
        [sequentialIdGenerator.getNextSequence(Constants.LOCATIONS)]);
    projectSite.location.sequence = sequenceLocations[0];

    Future<RecordModel> addLocationFuture =
        locationDao.addLocation(projectSite.location);

    addLocationFuture.then((value) {
      projectSite.location.id = value.id;
    });

    // Add the project site
    // Wait for both futures to complete
    // Generate a next sequence for project site
    List<int> sequenceCustomer = await Future.wait(
        [sequentialIdGenerator.getNextSequence(Constants.PROJECT_SITES)]);
    projectSite.sequence = sequenceCustomer[0];

    await Future.wait([addSiteResidentFuture, addLocationFuture]);

    return await pb
        .collection(Constants.PROJECT_SITES)
        .create(body: projectSite.toMap());
  }
}
