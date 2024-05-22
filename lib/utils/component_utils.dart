import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:masa_epico_concrete_manager/views/concrete_volumetric_weight.dart';
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

  static void generateConfirmMessage(
      BuildContext context, String mainMessage, String nextStep, Widget route) {
    QuickAlert.show(
      onCancelBtnTap: () {
        Navigator.pop(context);
      },
      context: context,
      type: QuickAlertType.confirm,
      title: mainMessage,
      text: nextStep,
      titleAlignment: TextAlign.center,
      textAlignment: TextAlign.center,
      confirmBtnText: 'Sí',
      cancelBtnText: 'No, realizar más tarde',
      confirmBtnColor: Colors.white,
      backgroundColor: Colors.black,
      headerBackgroundColor: Colors.grey,
      confirmBtnTextStyle: const TextStyle(
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      barrierColor: Colors.white,
      titleColor: Colors.white,
      textColor: Colors.white,
      onConfirmBtnTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => route),
        );
      },
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
