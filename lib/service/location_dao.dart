import 'package:injector/injector.dart';
import 'package:masa_epico_concrete_manager/constants/constants.dart';
import 'package:masa_epico_concrete_manager/models/location.dart';
import 'package:pocketbase/pocketbase.dart';

class LocationDao {
  late final PocketBase pb;

  LocationDao() {
    final injector = Injector.appInstance;
    pb = injector.get<PocketBase>();
  }

  Future<RecordModel> addLocation(Location location) async {
    return await pb
        .collection(Constants.LOCATIONS)
        .create(body: location.toMap());
  }

  Future<Location> getLocationById(String locationId) async {
    return await pb
        .collection(Constants.LOCATIONS)
        .getFirstListItem("id='$locationId'")
        .then((value) => Location.toModel(value.toJson()));
  }
}
