import 'package:flutter/material.dart';
import 'package:masa_epico_concrete_manager/dto/customer_dto.dart';
import 'package:masa_epico_concrete_manager/elements/custom_text_form_field.dart';
import 'package:masa_epico_concrete_manager/elements/elevated_button_dialog.dart';
import 'package:masa_epico_concrete_manager/service/customer_dao.dart';
import 'package:masa_epico_concrete_manager/utils/component_utils.dart';
import 'package:masa_epico_concrete_manager/utils/sequential_counter_generator.dart';

import '../../database/app_database.dart';

class CustomerDetails extends StatefulWidget {
  final int id;
  final bool readOnly;
  final ValueNotifier<List<CustomerDTO>> customersNotifier;

  const CustomerDetails(
      {super.key,
      required this.id,
      required this.readOnly,
      required this.customersNotifier});

  @override
  State<CustomerDetails> createState() => _CustomerDetailsState();
}

class _CustomerDetailsState extends State<CustomerDetails> {
  final _formKey = GlobalKey<FormState>();

  late CustomerDTO customer;
  final CustomerDAO customerDao = CustomerDAO();

  // Data for General Customer Info
  final TextEditingController _clienteController = TextEditingController();
  final TextEditingController _razonSocialController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Retrieve the customer
    customerDao.findById(widget.id).then((value) {
      if (value != null) {
        customer = value;

        setState(() {
          _clienteController.text = customer.identifier!;
          _razonSocialController.text = customer.companyName!;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          widget.readOnly ? "Detalles del cliente" : "Editar cliente",
          style: const TextStyle(fontWeight: FontWeight.bold),
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
                  readOnly: widget.readOnly,
                  validatorText:
                      "El nombre o razon social del cliente no puede quedar vacio",
                ),
                const SizedBox(height: 20),
                CustomTextFormField.withValidator(
                  controller: _razonSocialController,
                  labelText: "RFC (Opcional)",
                  readOnly: widget.readOnly,
                  validatorText: "El RFC debe tener 10 caracteres",
                  validator: (p0) {
                    if (p0!.isNotEmpty && p0.length < 10) {
                      return "El RFC debe tener 10 caracteres o mas";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                if (!widget.readOnly)
                  ElevatedButtonDialog(
                    title: "Modificar cliente",
                    description: "Presiona OK para realizar la operacion",
                    onOkPressed: () {
                      if (_formKey.currentState!.validate()) {
                        updateCustomer();
                        customerDao.findAll().then(
                            (value) => widget.customersNotifier.value = value);
                        Navigator.popUntil(context,
                            ModalRoute.withName(Navigator.defaultRouteName));
                      }
                    },
                  ),
                ElevatedButton.icon(
                  onPressed: () => Navigator.popUntil(
                      context, ModalRoute.withName(Navigator.defaultRouteName)),
                  icon: const Icon(
                    Icons.keyboard_return_rounded,
                    color: Colors.white,
                  ),
                  label: const Text(
                    'Regresar',
                    style: TextStyle(color: Colors.white),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.lightGreen,
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void updateCustomer() {
    // Process data
    String razonSocial = _clienteController.text;
    String rfc = _razonSocialController.text;

    // Minimal implementation - manager and location empty
    Customer customer = Customer(
      id: widget.id,
      identifier: razonSocial,
      companyName: rfc,
    );

    Future<Customer?> future = customerDao.update(customer);

    future.then((value) {
      if (value != null) {
        ComponentUtils.generateSuccessMessage(context,
            "Cliente ${SequentialFormatter.generatePadLeftNumber(value.id!)} - ${value.identifier} actualizado con exito!");
      } else {
        ComponentUtils.generateErrorMessage(context);
      }
    }).onError((error, stackTrace) {
      ComponentUtils.generateErrorMessage(context);
    });
  }
}
