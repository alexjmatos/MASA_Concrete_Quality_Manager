import 'package:flutter/material.dart';
import 'package:masa_epico_concrete_manager/constants/constants.dart';
import 'package:masa_epico_concrete_manager/elements/custom_dropdown_form_field.dart';
import 'package:masa_epico_concrete_manager/elements/custom_email_form_field.dart';
import 'package:masa_epico_concrete_manager/elements/custom_number_form_field.dart';
import 'package:masa_epico_concrete_manager/elements/custom_phone_number_form_field.dart';
import 'package:masa_epico_concrete_manager/elements/custom_text_form_field.dart';
import 'package:masa_epico_concrete_manager/elements/elevated_button_dialog.dart';
import 'package:masa_epico_concrete_manager/models/customer.dart';
import 'package:masa_epico_concrete_manager/models/location.dart';
import 'package:masa_epico_concrete_manager/models/manager.dart';
import 'package:masa_epico_concrete_manager/service/customer_dao.dart';

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

  // Data for Manager
  final TextEditingController _nombresController = TextEditingController();
  final TextEditingController _apellidosController = TextEditingController();
  final TextEditingController _puestoController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  // Data for Location
  final TextEditingController _coloniaController = TextEditingController();
  final TextEditingController _calleController = TextEditingController();
  final TextEditingController _numeroController = TextEditingController();
  final TextEditingController _municipioController = TextEditingController();
  final TextEditingController _codigoPostalController = TextEditingController();
  String _selectedEstado = "Quintana Roo";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
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
                CustomTextFormField(
                  controller: _razonSocialController,
                  labelText: "RFC",
                  validatorText:
                      "El RFC del cliente no puede quedar vacio o no es valido",
                ),
                const SizedBox(height: 20),
                const Text(
                  'Informacion de encargado o gerente',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Divider(),
                const SizedBox(height: 20),
                CustomTextFormField(
                  controller: _nombresController,
                  labelText: "Nombre",
                  validatorText: "El nombre del gerente no puede quedar vacio",
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  controller: _apellidosController,
                  labelText: "Apellidos",
                  validatorText:
                      "Los apellidos del gerente no pueden quedar vacios",
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  controller: _puestoController,
                  labelText: "Puesto",
                  validatorText: "El puesto no puede quedar vacio",
                ),
                const SizedBox(height: 20),
                CustomPhoneNumberFormField(
                  controller: _telefonoController,
                  labelText: "Telefono",
                  hintText: "(555) 555-5555",
                ),
                const SizedBox(height: 20),
                CustomEmailFormField(
                  controller: _emailController,
                  labelText: "Correo electronico",
                  hintText: "sssssss@ssss.com",
                ),
                const SizedBox(height: 20),
                const Text(
                  'Dirección fiscal',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Divider(),
                const SizedBox(height: 20),
                CustomTextFormField(
                    controller: _coloniaController,
                    labelText: "Colonia",
                    validatorText:
                        "La colonia no puede quedar vacia (Introducir 'NA' en caso que no aplique)"),
                const SizedBox(height: 20),
                CustomTextFormField(
                  controller: _calleController,
                  labelText: "Calle",
                  validatorText:
                      "La calle no puede quedar vacia (Introducir 'NA' en caso que no aplique)",
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  controller: _numeroController,
                  labelText: "Numero exterior o lote",
                  validatorText:
                      "El numero exterior no puede quedar vacio (Introducir 'NA' en caso que no aplique)",
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                    controller: _municipioController,
                    labelText: "Municipio",
                    validatorText:
                        "El municipio no puede quedar vacio (Introducir 'NA' en caso que no aplique)"),
                const SizedBox(height: 20),
                CustomNumberFormField(
                  controller: _codigoPostalController,
                  labelText: "Codigo Postal",
                  validatorText:
                      "El codigo postal no puede quedar vacio. (Introducir NNNNN en caso que no aplique)",
                ),
                const SizedBox(height: 20),
                CustomDropdownFormField(
                  labelText: "Estado",
                  items: Constants.ESTADOS,
                  onChanged: (p0) {
                    _selectedEstado = p0;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButtonDialog(
                  title: "Agregar cliente",
                  description: "Presiona OK para confirmar",
                  onOkPressed: () {
                    if (_formKey.currentState!.validate()) {
                      addCustomer();
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

    String nombreGerente = _nombresController.text;
    String apellidosGerente = _apellidosController.text;
    String puestoGerente = _puestoController.text;
    String telefonoGerente = _telefonoController.text;
    String emailGerente = _emailController.text;

    String colonia = _coloniaController.text;
    String calle = _calleController.text;
    String numero = _numeroController.text;
    String municipio = _municipioController.text;
    String codigoPostal = _codigoPostalController.text;
    String estado = _selectedEstado;

    Location location = Location(
        district: colonia,
        street: calle,
        number: numero,
        city: municipio,
        state: estado,
        zipCode: codigoPostal);

    Manager manager = Manager(
        firstName: nombreGerente,
        lastName: apellidosGerente,
        jobPosition: puestoGerente,
        phoneNumber: telefonoGerente,
        email: emailGerente);

    Customer customer = Customer(
        identifier: razonSocial,
        companyName: rfc,
        manager: manager,
        mainLocation: location);

    customerDao.addCustomer(customer);
  }
}
