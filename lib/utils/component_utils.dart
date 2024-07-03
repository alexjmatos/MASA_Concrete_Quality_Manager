import 'package:flutter/material.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

class ComponentUtils {
  void showPdfMessage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Documento generado con exito'),
      ),
    );
  }

  static void generateSuccessMessage(
      BuildContext context, String successMessage) {
    QuickAlert.show(
      title: "Exito",
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

  static void executeEditOrDelete(BuildContext context,
      StatefulWidget detailsWidget, StatefulWidget editWidget) {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.custom,
      confirmBtnText: "Cancelar",
      confirmBtnColor: Colors.black,
      title: "Operaciones",
      widget: Column(
        children: [
          ElevatedButton.icon(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => detailsWidget));
            },
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
            onPressed: () async {
              await Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => editWidget),
              );
            },
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
          // ElevatedButton.icon(
          //   onPressed: () {},
          //   icon: const Icon(Icons.delete, color: Colors.white),
          //   label: const Text(
          //     'Eliminar',
          //     style: TextStyle(color: Colors.white),
          //   ),
          //   style: ElevatedButton.styleFrom(
          //     backgroundColor: Colors.red,
          //     textStyle: const TextStyle(fontSize: 16, color: Colors.white),
          //   ),
          // ),
        ],
      ),
    );
  }

  static void showSnackbar(BuildContext context, String message,
      {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
      ),
    );
  }
}
