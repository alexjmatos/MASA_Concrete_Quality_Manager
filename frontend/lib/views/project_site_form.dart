import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:masa_epico_concrete_manager/constants/constants.dart';
import 'package:masa_epico_concrete_manager/elements/autocomplete.dart';
import 'package:masa_epico_concrete_manager/elements/custom_text_form_field.dart';
import 'package:masa_epico_concrete_manager/models/customer.dart';
import 'package:masa_epico_concrete_manager/models/project_site.dart';
import 'package:masa_epico_concrete_manager/models/site_resident.dart';
import 'package:masa_epico_concrete_manager/service/customer_dao.dart';
import 'package:masa_epico_concrete_manager/service/project_site_dao.dart';
import 'package:pocketbase/pocketbase.dart';

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
  String _selectedCustomer = '';

  // Data for Site Resident
  final TextEditingController _nombresController = TextEditingController();
  final TextEditingController _apellidosController = TextEditingController();
  final TextEditingController _puestoController = TextEditingController();

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
      selectionCustomers = customers
          .map((e) =>
              "${e.sequence.toString().padLeft(Constants.LEADING_ZEROS, '0')} - ${e.identifier}")
          .toList();
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
                  'Residente de obra (Opcional)',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Divider(),
                CustomTextFormField.noValidation(
                  controller: _nombresController,
                  labelText: "Nombre",
                ),
                const SizedBox(height: 20),
                CustomTextFormField.noValidation(
                  controller: _apellidosController,
                  labelText: "Apellidos",
                ),
                const SizedBox(height: 20),
                CustomTextFormField.noValidation(
                  controller: _puestoController,
                  labelText: "Puesto",
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      addProjectSite();
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

  void addProjectSite() {
    // Process data
    String obra = _obraController.text;
    List<SiteResident> residents = [];

    Customer customerAssigned = customers.firstWhere((element) =>
        element.sequence.toString().padLeft(Constants.LEADING_ZEROS, "0") ==
        _selectedCustomer.split("-")[0].trim());

    String nombreResidente = _nombresController.text;
    String apellidosResidente = _apellidosController.text;
    String puestoResidente = _puestoController.text;

    if (nombreResidente.isNotEmpty || apellidosResidente.isNotEmpty) {
      SiteResident siteResident = SiteResident(
        firstName: nombreResidente,
        lastName: apellidosResidente,
        jobPosition: puestoResidente,
      );
      residents.add(siteResident);
    }

    ProjectSite projectSite = ProjectSite(
        siteName: obra,
        residents: residents,
        customers: [customerAssigned]);

    Future<RecordModel> future = projectSiteDao.addProjectSite(projectSite);

    String name = "";
    int consecutive = 0;

    future.then((value) {
      name = value.getStringValue("nombre_identificador");
      consecutive = value.getIntValue("consecutivo");
    }).then((value) {
      CoolAlert.show(
        context: context,
        title: "Registro de obra añadido exitosamente",
        type: CoolAlertType.success,
        text:
            'Se agrego la obra ${consecutive.toString().padLeft(Constants.LEADING_ZEROS, '0')} - $name',
      );
    }).onError((error, stackTrace) {
      print(stackTrace);
      CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          title: "Error al agregar la obra",
          text:
              "Hubo un error al agregar el cliente. Verifica conexion a internet e intenta de nuevo");
    });
  }
}
