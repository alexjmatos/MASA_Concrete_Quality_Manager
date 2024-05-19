import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class ComponentUtils {
  static void generateSuccessMessage(
      BuildContext context, String successMessage) {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.success,
      text: successMessage,
      autoCloseDuration: const Duration(seconds: 5),
      showConfirmBtn: true,
    );
  }

  static void generateErrorMessage(BuildContext context,
      {error = "Ocurrio un error al agregar el registro. Intente de nuevo"}) {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.error,
      title: 'Error',
      text: error,
      backgroundColor: Colors.black,
      titleColor: Colors.white,
      textColor: Colors.white,
    );
  }
}
