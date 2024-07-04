import 'package:flutter/material.dart';
import 'package:masa_epico_concrete_manager/dto/building_site_dto.dart';
import 'package:masa_epico_concrete_manager/dto/customer_dto.dart';
import 'package:masa_epico_concrete_manager/dto/site_resident_dto.dart';
import 'package:masa_epico_concrete_manager/elements/autocomplete.dart';
import 'package:masa_epico_concrete_manager/elements/custom_text_form_field.dart';
import 'package:masa_epico_concrete_manager/elements/elevated_button_dialog.dart';
import 'package:masa_epico_concrete_manager/service/customer_dao.dart';
import 'package:masa_epico_concrete_manager/service/building_site_dao.dart';
import 'package:masa_epico_concrete_manager/service/site_resident_dao.dart';
import 'package:masa_epico_concrete_manager/utils/component_utils.dart';
import 'package:masa_epico_concrete_manager/utils/sequential_counter_generator.dart';

import '../database/app_database.dart';

class ProjectSiteAndResidentForm extends StatefulWidget {
  const ProjectSiteAndResidentForm({super.key});

  @override
  State<ProjectSiteAndResidentForm> createState() =>
      _ProjectSiteAndResidentFormState();
}

class _ProjectSiteAndResidentFormState
    extends State<ProjectSiteAndResidentForm> {
  final _formKey = GlobalKey<FormState>();

  final BuildingSiteDAO buildingSiteDao = BuildingSiteDAO();
  final CustomerDAO customerDao = CustomerDAO();
  final SiteResidentDAO siteResidentDao = SiteResidentDAO();

  // Data for General Site Project Info
  final TextEditingController _siteNameController = TextEditingController();

  // Data for Customer
  final TextEditingController _customerController = TextEditingController();
  final TextEditingController _siteResidentController = TextEditingController();

  // Data for Site Resident
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _jobPositionController = TextEditingController();

  static List<CustomerDTO> customers = [];
  static List<String> selectionCustomers = [];
  static List<SiteResidentDTO> siteResidents = [];
  static List<String> selectionSiteResidents = [];

  SiteResidentDTO? _selectedSiteResident;

  @override
  void initState() {
    super.initState();
    loadCustomerAndSiteResidentData();
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
                  controller: _siteNameController,
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
                  validate: false,
                  onChanged: (p0) {
                    _selectedSiteResident = siteResidents.firstWhere(
                        (element) =>
                            SequentialFormatter.generatePadLeftNumber(
                                element.id!) ==
                            p0.split("-")[0].trim());
                    _siteResidentController.text = p0;
                    setState(
                      () {
                        updateSiteResidentInfo();
                      },
                    );
                  },
                  controller: _siteResidentController,
                ),
                const SizedBox(height: 20),
                CustomTextFormField.noValidation(
                  controller: _firstNameController,
                  labelText: "Nombre",
                  readOnly: true,
                ),
                const SizedBox(height: 20),
                CustomTextFormField.noValidation(
                  controller: _lastNameController,
                  labelText: "Apellidos",
                  readOnly: true,
                ),
                const SizedBox(height: 20),
                CustomTextFormField.noValidation(
                  controller: _jobPositionController,
                  labelText: "Puesto",
                  readOnly: true,
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButtonDialog(
                    title: "Agregar obra",
                    description: "Presiona OK para realizar la operacion",
                    onOkPressed: () {
                      if (_formKey.currentState!.validate()) {
                        addProjectSite();
                        Navigator.popUntil(
                          context,
                          ModalRoute.withName(Navigator.defaultRouteName),
                        );
                        _formKey.currentState!.reset();
                      } else {
                        Navigator.pop(context, 'Cancel');
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> addProjectSite() async {
    String obra = _siteNameController.text.trim();
    String nombreResidente = _firstNameController.text.trim();
    String apellidosResidente = _lastNameController.text.trim();
    String puestoResidente = _jobPositionController.text.trim();

    BuildingSiteDTO toBeAdded = BuildingSiteDTO(siteName: obra);

    if (_selectedSiteResident != null &&
        _selectedSiteResident!.firstName!.toUpperCase() ==
            nombreResidente.toUpperCase() &&
        _selectedSiteResident!.lastName!.toUpperCase() ==
            apellidosResidente.toUpperCase() &&
        _selectedSiteResident!.jobPosition!.toUpperCase() ==
            puestoResidente.toUpperCase()) {
      toBeAdded.siteResident = _selectedSiteResident;
    } else if (nombreResidente.isNotEmpty || apellidosResidente.isNotEmpty) {
      SiteResident siteResident = SiteResident(
        firstName: nombreResidente,
        lastName: apellidosResidente,
        jobPosition: puestoResidente,
      );
      var siteResidentResult = await siteResidentDao.add(siteResident);

      if (siteResidentResult != null) {
        toBeAdded.siteResident = SiteResidentDTO(
            id: siteResidentResult.id,
            firstName: siteResidentResult.firstName,
            lastName: siteResidentResult.lastName,
            jobPosition: siteResidentResult.jobPosition);
      }
    }

    toBeAdded.siteName = obra;
    toBeAdded.customer = customers.firstWhere((element) =>
        element.id ==
        SequentialFormatter.getIdNumberFromConsecutive(
            _customerController.text));

    Future<BuildingSite?> future = buildingSiteDao.add(BuildingSite(
        id: -1,
        siteName: toBeAdded.siteName ?? "",
        customerId: toBeAdded.customer!.id!,
        siteResidentId: toBeAdded.siteResident?.id));

    future.then((value) {
      if (value != null) {
        ComponentUtils.generateSuccessMessage(context,
            "Obra ${SequentialFormatter.generatePadLeftNumber(value.id!)} - ${value.siteName} agregada con exito");
        loadCustomerAndSiteResidentData();
      } else {
        ComponentUtils.generateErrorMessage(context);
      }
    }).onError((error, stackTrace) {
      ComponentUtils.generateErrorMessage(context);
    });
  }

  void updateSiteResidentInfo() {
    _firstNameController.text = _selectedSiteResident!.firstName ?? "";
    _lastNameController.text = _selectedSiteResident!.lastName ?? "";
    _jobPositionController.text = _selectedSiteResident!.jobPosition ?? "";
  }

  void loadCustomerAndSiteResidentData() {
    customerDao.findAll().then((value) {
      customers = value;
    }).whenComplete(() {
      setState(() {
        selectionCustomers = customers
            .map((customer) =>
                "${SequentialFormatter.generatePadLeftNumber(customer.id!)} - ${customer.identifier}")
            .toList();
      });
    });

    siteResidentDao.findAll().then((value) {
      siteResidents = value;
    }).whenComplete(() {
      setState(() {
        selectionSiteResidents = siteResidents
            .map((siteResident) =>
                "${SequentialFormatter.generatePadLeftNumber(siteResident.id!)} - ${siteResident.lastName} ${siteResident.firstName}")
            .toList();
      });
    });
  }
}
