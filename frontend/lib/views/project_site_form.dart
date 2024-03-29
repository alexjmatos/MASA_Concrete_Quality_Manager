import 'package:flutter/material.dart';
import 'package:masa_epico_concrete_manager/constants/constants.dart';
import 'package:masa_epico_concrete_manager/elements/autocomplete.dart';
import 'package:masa_epico_concrete_manager/elements/custom_dropdown_form_field.dart';
import 'package:masa_epico_concrete_manager/elements/custom_email_form_field.dart';
import 'package:masa_epico_concrete_manager/elements/custom_number_form_field.dart';
import 'package:masa_epico_concrete_manager/elements/custom_phone_number_form_field.dart';
import 'package:masa_epico_concrete_manager/elements/custom_text_form_field.dart';
import 'package:masa_epico_concrete_manager/models/customer.dart';
import 'package:masa_epico_concrete_manager/models/location.dart';
import 'package:masa_epico_concrete_manager/models/project_site.dart';
import 'package:masa_epico_concrete_manager/models/site_resident.dart';
import 'package:masa_epico_concrete_manager/service/customer_dao.dart';
import 'package:masa_epico_concrete_manager/service/project_site_dao.dart';

class ProjectSiteAndResidentForm extends StatefulWidget {
  const ProjectSiteAndResidentForm({super.key});

  @override
  State<ProjectSiteAndResidentForm> createState() =>
      _ProjectSiteAndResidentFormState();
}

class _ProjectSiteAndResidentFormState
    extends State<ProjectSiteAndResidentForm> {
  final _formKey = GlobalKey<FormState>();

  final ProjectSiteDao projectSiteDao = ProjectSiteDao();
  final CustomerDao customerDao = CustomerDao();

  // Data for General Site Project Info
  final TextEditingController _obraController = TextEditingController();

  // Data for Customer
  String? _selectedCustomer;

  // Data for Site Resident
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

  static List<Customer> customers = [];
  static List<String> selectionCustomers = [];

  @override
  void initState() {
    super.initState();
    _getDataFromBackend();
  }

  void _getDataFromBackend() async {
    customers = await customerDao.getAllCustomers();
    setState(() {
      selectionCustomers =
          customers.map((e) => "${e.companyName} - ${e.identifier}").toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Datos de la obra y residente',
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
                  controller: _obraController,
                  labelText: "Identificador",
                  validatorText:
                      "El identificador de la obra no puede quedar vacio",
                ),
                const SizedBox(height: 20),
                AutoCompleteElement(
                  fieldName: "Cliente asignado",
                  options: selectionCustomers,
                  onChanged: (p0) => _selectedCustomer = p0,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Dirección',
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
                      "El municipio no puede quedar vacio (Introducir 'NA' en caso que no aplique)",
                ),
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
                const Text(
                  'Residente de obra',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Divider(),
                CustomTextFormField(
                  controller: _nombresController,
                  labelText: "Nombre",
                  validatorText: "El nombre no puede quedar vacio",
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                  controller: _apellidosController,
                  labelText: "Apellidos",
                  validatorText: "Los apellidos no pueden quedar vacios",
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
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // Process data
                      String obra = _obraController.text;
                      Customer customerAssigned = customers.firstWhere((element) =>
                          "${element.companyName.toUpperCase()} - ${element.identifier}" ==
                          _selectedCustomer);

                      String nombreResidente = _nombresController.text;
                      String apellidosResidente = _apellidosController.text;
                      String puestoResidente = _puestoController.text;
                      String telefonoResidente = _telefonoController.text;
                      String emailResidente = _emailController.text;

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

                      SiteResident siteResident = SiteResident(
                          firstName: nombreResidente,
                          lastName: apellidosResidente,
                          jobPosition: puestoResidente,
                          phoneNumber: telefonoResidente,
                          email: emailResidente);

                      ProjectSite projectSite = ProjectSite(
                          siteName: obra,
                          location: location,
                          residents: [siteResident],
                          customers: [customerAssigned]);

                      addProjectSite(projectSite);
                    }
                  },
                  child: const Text('Agregar obra'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void addProjectSite(ProjectSite projectSite) {
    projectSiteDao.addProjectSite(projectSite);
  }
}
