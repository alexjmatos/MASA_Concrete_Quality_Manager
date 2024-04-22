import 'package:injector/injector.dart';
import 'package:masa_epico_concrete_manager/constants/constants.dart';
import 'package:masa_epico_concrete_manager/models/site_resident.dart';
import 'package:pocketbase/pocketbase.dart';

class SiteResidentDao {
  late final PocketBase pb;

  SiteResidentDao() {
    final injector = Injector.appInstance;
    pb = injector.get<PocketBase>();
  }

  Future<RecordModel> addSiteResident(SiteResident siteResident) async {
    return await pb
        .collection(Constants.SITE_RESIDENTS)
        .create(body: siteResident.toMap());
  }

  Future<List<SiteResident>> getSiteResidentsByIds(List<String> residentsId) {
    final result = pb
        .collection(Constants.SITE_RESIDENTS)
        .getList(filter: residentsId.map((e) => "id ~ '$e'").join(" & "));
    return result.then((value) =>
        value.items.map((e) => SiteResident.toModel(e.toJson())).toList());
  }

  Future<List<SiteResident>> getAllSiteResidents() async {
    final models = await pb.collection(Constants.SITE_RESIDENTS).getFullList(
          sort: '-created',
        );

    return models.map((e) {
      return SiteResident.toModel(e.toJson());
    }).toList();
  }
}
