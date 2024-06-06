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
          MaterialPageRoute(builder: (context) => route),
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

  static void generateInformationMessage(BuildContext context) {
    QuickAlert.show(
        context: context,
        type: QuickAlertType.custom,
        confirmBtnText: "Cancelar",
        confirmBtnColor: Colors.black,
        title: "Operaciones",
        autoCloseDuration: const Duration(seconds: 30),
        widget: Column(
          children: [
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(
                Icons.details_rounded,
                color: Colors.white,
              ),
              label: const Text(
                'Detalles',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightGreen,
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(
                Icons.edit,
                color: Colors.white,
              ),
              label: const Text(
                'Editar',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightBlue,
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.delete, color: Colors.white),
              label: const Text(
                'Eliminar',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                textStyle: const TextStyle(fontSize: 16, color: Colors.white),
              ),
            ),
          ],
        ));
  }
}
