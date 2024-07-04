import 'package:flutter/cupertino.dart';

class CustomerFormDTO {
  final TextEditingController identifierController;
  final TextEditingController companyNameController;

  CustomerFormDTO(
      {required this.identifierController,
      required this.companyNameController});

  String getIdentifier() {
    return identifierController.text.trim();
  }

  String getCompanyName() {
    return companyNameController.text.trim();
  }
}
