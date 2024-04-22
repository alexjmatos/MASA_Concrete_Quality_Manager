import 'package:flutter/material.dart';
import 'package:masa_epico_concrete_manager/constants/constants.dart';
import 'package:masa_epico_concrete_manager/elements/custom_text_form_field.dart';
import 'package:masa_epico_concrete_manager/elements/elevated_button_dialog.dart';
import 'package:masa_epico_concrete_manager/models/customer.dart';
import 'package:masa_epico_concrete_manager/service/customer_dao.dart';
import 'package:cool_alert/cool_alert.dart';

// ignore: implementation_imports
import 'package:pocketbase/src/dtos/record_model.dart';

class CustomerForm extends StatefulWidget {
  const CustomerForm({super.key});

  @override
  State<CustomerForm> createState() => _CustomerFormState();
}

class _CustomerFormState extends State<CustomerForm> {
  final _formKey = GlobalKey<FormState>();

  final CustomerDao customerDao = CustomerDao();

  // Data for General Customer Info
  final TextEditingController _clienteController = TextEditingController();
  final TextEditingController _razonSocialController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text(
          'Datos del cliente',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                CustomTextFormField(
                  controller: _clienteController,
                  labelText: "Nombre o Razón Social",
                  validatorText:
                      "El nombre o razon social del cliente no puede quedar vacio",
                ),
                const SizedBox(height: 20),
                CustomTextFormField.withValidator(
                  controller: _razonSocialController,
                  labelText: "RFC (Opcional)",
                  validatorText: "El RFC debe tener 10 caracteres",
                  validator: (p0) {
                    if (p0!.isNotEmpty && p0.length != 10) {
                      return "El RFC debe tener 10 caracteres";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButtonDialog(
                  title: "Agregar cliente",
                  description: "Presiona OK para realizar la operacion",
                  onOkPressed: () {
                    if (_formKey.currentState!.validate()) {
                      addCustomer();
                      Navigator.pop(context);
                      _formKey.currentState!.reset();
                    } else {
                      Navigator.pop(context, 'Cancel');
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void addCustomer() {
    // Process data
    String razonSocial = _clienteController.text;
    String rfc = _razonSocialController.text;

    // Minimal implementation - manager and location empty
    Customer customer = Customer(
      identifier: razonSocial,
      companyName: rfc,
    );

    Future<RecordModel> future = customerDao.addCustomer(customer);

    String name = "";
    int consecutive = 0;

    future.then((value) {
      name = value.getStringValue("nombre_identificador");
      consecutive = value.getIntValue("consecutivo");
    }).then((value) {
      CoolAlert.show(
        context: context,
        title: "Registro de cliente añadido exitosamente",
        type: CoolAlertType.success,
        text:
            'Se agrego el cliente ${consecutive.toString().padLeft(Constants.LEADING_ZEROS, '0')} - $name',
      );
    }).onError((error, stackTrace) {
      CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          title: "Error al agregar cliente",
          text:
              "Hubo un error al agregar el cliente. Verifica conexion a internet e intenta de nuevo");
    });
  }
}
