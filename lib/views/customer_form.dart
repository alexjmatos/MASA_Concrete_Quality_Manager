import 'package:flutter/material.dart';
import 'package:masa_epico_concrete_manager/elements/custom_text_form_field.dart';
import 'package:masa_epico_concrete_manager/elements/elevated_button_dialog.dart';
import 'package:masa_epico_concrete_manager/models/customer.dart';
import 'package:masa_epico_concrete_manager/service/customer_dao.dart';
import 'package:masa_epico_concrete_manager/utils/component_utils.dart';
import 'package:masa_epico_concrete_manager/utils/sequential_counter_generator.dart';

class CustomerForm extends StatefulWidget {
  const CustomerForm({super.key});

  @override
  State<CustomerForm> createState() => _CustomerFormState();
}

class _CustomerFormState extends State<CustomerForm> {
  final _formKey = GlobalKey<FormState>();

  final CustomerDAO customerDao = CustomerDAO();

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
    String razonSocial = _clienteController.text.trim();
    String rfc = _razonSocialController.text.trim();

    // Minimal implementation - manager and location empty
    Customer customer = Customer(
      identifier: razonSocial,
      companyName: rfc,
    );

    Future<Customer> future = customerDao.add(customer);

    future.then((value) {
      ComponentUtils.generateSuccessMessage(context,
          "Cliente ${SequentialFormatter.generatePadLeftNumber(value.id!)} - ${value.identifier} agregado con exito");
    }).onError((error, stackTrace) {
      ComponentUtils.generateErrorMessage(context);
    });
  }
}
