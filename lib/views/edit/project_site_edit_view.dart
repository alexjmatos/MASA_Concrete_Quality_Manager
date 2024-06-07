import 'package:flutter/material.dart';
import 'package:masa_epico_concrete_manager/elements/autocomplete.dart';
import 'package:masa_epico_concrete_manager/elements/custom_text_form_field.dart';
import 'package:masa_epico_concrete_manager/elements/elevated_button_dialog.dart';
import 'package:masa_epico_concrete_manager/models/customer.dart';
import 'package:masa_epico_concrete_manager/models/project_site.dart';
import 'package:masa_epico_concrete_manager/models/site_resident.dart';
import 'package:masa_epico_concrete_manager/service/customer_dao.dart';
import 'package:masa_epico_concrete_manager/service/project_site_dao.dart';
import 'package:masa_epico_concrete_manager/service/site_resident_dao.dart';
import 'package:masa_epico_concrete_manager/utils/component_utils.dart';
import 'package:masa_epico_concrete_manager/utils/sequential_counter_generator.dart';

class ProjectSiteDetails extends StatefulWidget {
  final int id;
  final bool readOnly;
  final ValueNotifier<List<ProjectSite>> projectSitesNotifier;

  const ProjectSiteDetails(
      {super.key,
      required this.id,
      required this.readOnly,
      required this.projectSitesNotifier});

  @override
  State<ProjectSiteDetails> createState() => _ProjectSiteDetailsState();
}

class _ProjectSiteDetailsState extends State<ProjectSiteDetails> {
  final _formKey = GlobalKey<FormState>();

  final ProjectSiteDao projectSiteDao = ProjectSiteDao();
  final CustomerDao customerDao = CustomerDao();
  final SiteResidentDao siteResidentDao = SiteResidentDao();

  // Data for General Site Project Info
  final TextEditingController _obraController = TextEditingController();

  // Data for Customer
  final TextEditingController _customerController = TextEditingController();

  // Data for Site Resident
  final TextEditingController _nombresController = TextEditingController();
  final TextEditingController _apellidosController = TextEditingController();
  final TextEditingController _puestoController = TextEditingController();
  final TextEditingController _siteResidentController = TextEditingController();

  static List<Customer> customers = [];
  static List<String> selectionCustomers = [];
  static List<SiteResident> siteResidents = [];
  static List<String> selectionSiteResidents = [];

  late ProjectSite selectedProjectSite;
  SiteResident? _selectedSiteResident;

  @override
  void initState() {
    super.initState();
    loadCustomerAndSiteResidentData();
    fillValues();
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
                  onChanged: (p0) => _customerController.text = p0,
                  controller: _customerController,
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
                            SequentialIdGenerator.generatePadLeftNumber(
                                element.id!) ==
                            p0.split("-")[0].trim());
                    setState(() {
                      updateSiteResidentInfo();
                    });
                  },
                  controller: _siteResidentController,
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
                if (!widget.readOnly)
                  ElevatedButtonDialog(
                    title: "Modificar obra",
                    description: "Presiona OK para realizar la operacion",
                    onOkPressed: () {
                      if (_formKey.currentState!.validate()) {
                        updateProjectSite();
                        projectSiteDao.findAll().then(
                              (value) =>
                                  widget.projectSitesNotifier.value = value,
                            );
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void updateProjectSite() {
    ProjectSite toBeAdded = ProjectSite();

    String obra = _obraController.text;
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
      toBeAdded.residents.add(_selectedSiteResident);
    } else if (nombreResidente.isNotEmpty || apellidosResidente.isNotEmpty) {
      SiteResident siteResident = SiteResident(
        firstName: nombreResidente,
        lastName: apellidosResidente,
        jobPosition: puestoResidente,
      );
      siteResidentDao
          .addSiteResident(siteResident)
          .then((value) => toBeAdded.residents.add(value));
    }

    toBeAdded.siteName = obra;
    toBeAdded.customer = customers.firstWhere((element) =>
        element.id ==
        SequentialIdGenerator.getIdNumberFromConsecutive(
            _customerController.text));

    Future<ProjectSite> future = projectSiteDao.addProjectSite(toBeAdded);

    future.then((value) {
      ComponentUtils.generateSuccessMessage(context,
          "Obra ${SequentialIdGenerator.generatePadLeftNumber(value.id!)} - ${value.siteName} agregada con exito");
      loadCustomerAndSiteResidentData();
    }).onError((error, stackTrace) {
      ComponentUtils.generateErrorMessage(context);
    });
  }

  void updateSiteResidentInfo() {
    _nombresController.text = _selectedSiteResident!.firstName;
    _apellidosController.text = _selectedSiteResident!.lastName;
    _puestoController.text = _selectedSiteResident!.jobPosition;
  }

  void loadCustomerAndSiteResidentData() {
    customerDao.getAllCustomers().then((value) {
      customers = value;
    }).whenComplete(() {
      setState(() {
        selectionCustomers = customers
            .map((customer) =>
                "${SequentialIdGenerator.generatePadLeftNumber(customer.id!)} - ${customer.identifier}")
            .toList();
      });
    });

    siteResidentDao.getAllSiteResidents().then((value) {
      siteResidents = value;
    }).whenComplete(() {
      setState(() {
        selectionSiteResidents = siteResidents
            .map((siteResident) =>
                "${SequentialIdGenerator.generatePadLeftNumber(siteResident.id!)} - ${siteResident.lastName} ${siteResident.firstName}")
            .toList();
      });
    });
  }

  Future<void> fillValues() async {
    projectSiteDao.findById(widget.id).then(
      (value) {
        selectedProjectSite = value;
        setState(() {
          _obraController.text = selectedProjectSite.siteName!;
          print(selectedProjectSite.customer!.identifier);
          print(selectedProjectSite.customer!.companyName);
          _customerController.text =
              "${SequentialIdGenerator.generatePadLeftNumber(selectedProjectSite.customer!.id!)} - ${selectedProjectSite.customer!.identifier}";
        });
      },
    );
  }
}
