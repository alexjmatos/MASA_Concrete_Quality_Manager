import 'package:masa_epico_concrete_manager/dto/customer_dto.dart';
import 'package:masa_epico_concrete_manager/dto/site_resident_dto.dart';

class BuildingSiteDTO {
  int? id;
  String? siteName;
  CustomerDTO? customer;
  SiteResidentDTO? siteResident;

  BuildingSiteDTO({this.id, this.siteName, this.customer, this.siteResident});
}
