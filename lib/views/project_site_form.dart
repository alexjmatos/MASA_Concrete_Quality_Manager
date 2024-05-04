import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:masa_epico_concrete_manager/constants/constants.dart';
import 'package:masa_epico_concrete_manager/elements/autocomplete.dart';
import 'package:masa_epico_concrete_manager/elements/custom_text_form_field.dart';
import 'package:masa_epico_concrete_manager/elements/elevated_button_dialog.dart';
import 'package:masa_epico_concrete_manager/models/customer.dart';
import 'package:masa_epico_concrete_manager/models/project_site.dart';
import 'package:masa_epico_concrete_manager/models/site_resident.dart';
import 'package:masa_epico_concrete_manager/service/customer_dao.dart';
import 'package:masa_epico_concrete_manager/service/project_site_dao.dart';
import 'package:masa_epico_concrete_manager/service/site_resident_dao.dart';
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
  final SiteResidentDao siteResidentDao = SiteResidentDao();

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
  static List<SiteResident> siteResidents = [];
  static List<String> selectionSiteResidents = [];

  SiteResident? _selectedSiteResident;

  @override
  void initState()  {
    super.initState();

    customerDao.getAllCustomers().then((value) {
      customers = value;
    }).whenComplete(() {
      setState(() {
        selectionCustomers = customers
            .map((customer) =>
        "${customer.id.toString().padLeft(Constants.LEADING_ZEROS, '0')} - ${customer.identifier}")
            .toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
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
                const SizedBox(height: 20),
                AutoCompleteElement(
                  fieldName: "Residentes de obra (Busqueda)",
                  options: selectionSiteResidents,
                  onChanged: (p0) {
                    _selectedSiteResident = siteResidents.firstWhere(
                        (element) =>
                            element.id
                                .toString()
                                .padLeft(Constants.LEADING_ZEROS, "0") ==
                            p0.split("-")[0].trim());

                    setState(() {
                      updateSiteResidentInfo();
                    });
                  },
                ),
                const SizedBox(height: 20),
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
                ElevatedButtonDialog(
                  title: "Agregar obra",
                  description: "Presiona OK para realizar la operacion",
                  onOkPressed: () {
                    if (_formKey.currentState!.validate()) {
                      addProjectSite();
                      Navigator.pop(context);
                      _formKey.currentState!.reset();
                    } else {
                      Navigator.pop(context, 'Cancel');
                    }
                  },
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

    String nombreResidente = _nombresController.text;
    String apellidosResidente = _apellidosController.text;
    String puestoResidente = _puestoController.text;

    if (_selectedSiteResident != null &&
        _selectedSiteResident!.firstName.toUpperCase() ==
            nombreResidente.toUpperCase() &&
        _selectedSiteResident!.lastName.toUpperCase() ==
            apellidosResidente.toUpperCase() &&
        _selectedSiteResident!.jobPosition.toUpperCase() ==
            puestoResidente.toUpperCase()) {
      residents.add(_selectedSiteResident!);
    } else if (nombreResidente.isNotEmpty || apellidosResidente.isNotEmpty) {
      SiteResident siteResident = SiteResident(
        firstName: nombreResidente,
        lastName: apellidosResidente,
        jobPosition: puestoResidente,
      );
      residents.add(siteResident);
    }

    Future<RecordModel> future =
        projectSiteDao.addProjectSite(ProjectSite(siteName: "siteName"));

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
      CoolAlert.show(
          context: context,
          type: CoolAlertType.error,
          title: "Error al agregar la obra",
          text:
              "Hubo un error al agregar el cliente. Verifica conexion a internet e intenta de nuevo");
    });
  }

  void updateSiteResidentInfo() {
    _nombresController.text = _selectedSiteResident!.firstName;
    _apellidosController.text = _selectedSiteResident!.lastName;
    _puestoController.text = _selectedSiteResident!.jobPosition;
  }
}