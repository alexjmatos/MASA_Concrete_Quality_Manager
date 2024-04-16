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
    if (projectSite.residents.firstOrNull != null) {
      Future<RecordModel> addSiteResidentFuture =
          siteResidentDao.addSiteResident(projectSite.residents.first);

      addSiteResidentFuture.then((value) {
        projectSite.residents.first.id = value.id;
      });

      await Future.wait([addSiteResidentFuture]);
    }

    // Add the project site
    // Wait for both futures to complete
    // Generate a next sequence for project site
    List<int> sequenceCustomer = await Future.wait(
        [sequentialIdGenerator.getNextSequence(Constants.PROJECT_SITES)]);
    projectSite.sequence = sequenceCustomer[0];

    return await pb
        .collection(Constants.PROJECT_SITES)
        .create(body: projectSite.toMap());
  }
}
