import 'package:flutter/cupertino.dart';

import '../../models/site_resident.dart';
import '../../service/site_resident_dao.dart';
import '../../utils/component_utils.dart';
import '../../utils/sequential_counter_generator.dart';

class SiteResidentFormDTO {
  final SiteResidentDAO siteResidentDao = SiteResidentDAO();

  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final TextEditingController jobPositionController;
  SiteResident? selectedSiteResident;

  SiteResidentFormDTO(
      {required this.firstNameController,
      required this.lastNameController,
      required this.jobPositionController,
      this.selectedSiteResident});

  String getFirstName() {
    return firstNameController.text.trim();
  }

  String getLastName() {
    return lastNameController.text.trim();
  }

  String getJobPosition() {
    return jobPositionController.text.trim();
  }

  Future<void> addSiteResident(BuildContext context) async {
    SiteResident siteResident = SiteResident(
      firstName: getFirstName(),
      lastName: getLastName(),
      jobPosition: getJobPosition(),
    );
    var future = siteResidentDao.add(siteResident);
    future.then((value) {
      ComponentUtils.generateSuccessMessage(context,
          "Residente ${SequentialFormatter.generateSequentialFormatFromSiteResident(value)} agregada con exito");
    }).onError((error, stackTrace) {
      ComponentUtils.generateErrorMessage(context);
    });
  }
}
