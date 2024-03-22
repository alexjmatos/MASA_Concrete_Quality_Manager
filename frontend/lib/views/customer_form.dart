import 'package:flutter/material.dart';
import 'package:masa_epico_concrete_manager/elements/custom_dropdown_form_field.dart';
import 'package:masa_epico_concrete_manager/elements/custom_number_form_field.dart';
import 'package:masa_epico_concrete_manager/elements/custom_text_form_field.dart';

class CustomerForm extends StatefulWidget {
  const CustomerForm({super.key});

  @override
  State<CustomerForm> createState() => _CustomerFormState();
}

class _CustomerFormState extends State<CustomerForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _clienteController = TextEditingController();
  final TextEditingController _razonSocialController = TextEditingController();
  final TextEditingController _coloniaController = TextEditingController();
  final TextEditingController _calleController = TextEditingController();
  final TextEditingController _numeroController = TextEditingController();
  final TextEditingController _municipioController = TextEditingController();
  final TextEditingController _codigoPostalController = TextEditingController();
  String? _selectedEstado = "Quintana Roo";

  final List<String> _estados = [
    'Aguascalientes',
    'Baja California',
    'Baja California Sur',
    'Campeche',
    'Chiapas',
    'Chihuahua',
    'Coahuila',
    'Colima',
    'Durango',
    'Guanajuato',
    'Guerrero',
    'Hidalgo',
    'Jalisco',
    'México',
    'Michoacán',
    'Morelos',
    'Nayarit',
    'Nuevo León',
    'Oaxaca',
    'Puebla',
    'Querétaro',
    'Quintana Roo',
    'San Luis Potosí',
    'Sinaloa',
    'Sonora',
    'Tabasco',
    'Tamaulipas',
    'Tlaxcala',
    'Veracruz',
    'Yucatán',
    'Zacatecas',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Informacion del cliente'),
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
                  validationText:
                      "El codigo postal no puede quedar vacio. (Introducir 00000 en caso que no aplique)",
                ),
                const SizedBox(height: 20),
                CustomDropdownFormField(
                  labelText: "Estado",
                  items: _estados,
                  onChanged: (p0) {
                    _selectedEstado = p0;
                  },
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Process data
                      String cliente = _clienteController.text;
                      String razonSocial = _razonSocialController.text;
                      String calle = _calleController.text;
                      String numero = _numeroController.text;
                      String ciudad = _municipioController.text;
                      String codigoPostal = _codigoPostalController.text;
                      String? estado = _selectedEstado;
                      print('Cliente: $cliente, Razon Social: $razonSocial, Calle: $calle, Numero: $numero, Ciudad: $ciudad, Codigo Postal: $codigoPostal, Estado: $estado');
                    }
                  },
                  child: const Text('Agregar cliente'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
