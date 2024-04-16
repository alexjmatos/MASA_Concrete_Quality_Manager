import 'package:flutter/material.dart';
import 'package:masa_epico_concrete_manager/constants/constants.dart';
import 'package:masa_epico_concrete_manager/elements/autocomplete.dart';
import 'package:masa_epico_concrete_manager/elements/custom_dropdown_form_field.dart';
import 'package:masa_epico_concrete_manager/elements/custom_number_form_field.dart';
import 'package:masa_epico_concrete_manager/elements/custom_text_form_field.dart';
import 'package:masa_epico_concrete_manager/models/customer.dart';
import 'package:masa_epico_concrete_manager/models/location.dart';
import 'package:masa_epico_concrete_manager/models/project_site.dart';
import 'package:masa_epico_concrete_manager/models/site_resident.dart';
import 'package:masa_epico_concrete_manager/service/customer_dao.dart';
import 'package:masa_epico_concrete_manager/service/project_site_dao.dart';

class ConcreteQualityForm extends StatefulWidget {
  const ConcreteQualityForm({super.key});

  @override
  State<ConcreteQualityForm> createState() => _ConcreteQualityFormState();
}

class _ConcreteQualityFormState extends State<ConcreteQualityForm> {
  final _formKey = GlobalKey<FormState>();
  final CustomerDao customerDao = CustomerDao();
  final ProjectSiteDao projectSiteDao = ProjectSiteDao();

  static List<Customer> customers = [];
  static List<String> availableCustomers = [];

  static List<ProjectSite> projectSites = [];
  static List<String> availableProjectSites = [];

  static List<String> availableSiteResidents = [];

  String _selectedCustomer = '';
  String _selectedProjectSite = '';
  String _selectedResident = '';
  final String _selectedFc = '';

  final TextEditingController _direccionController = TextEditingController();
  final TextEditingController _residenteController = TextEditingController();
  final TextEditingController _slumpingController = TextEditingController();
  final TextEditingController _volumeController = TextEditingController();
  final TextEditingController _tmaController = TextEditingController();
  final TextEditingController _designAgeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _getDataFromBackend();
  }

  void _getDataFromBackend() async {
    customers = await customerDao.getAllCustomers();
    setState(() {
      availableCustomers = customers
          .map((e) =>
              "${e.sequence.toString().padLeft(Constants.LEADING_ZEROS, '0')} - ${e.companyName} - ${e.identifier}")
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Crear orden de muestreo',
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
                AutoCompleteElement(
                  fieldName: "Cliente",
                  options: availableCustomers,
                  onChanged: (p0) =>
                      setSelectedCustomerAndUpdateProjectSites(p0),
                ),
                const SizedBox(height: 20),
                AutoCompleteElement(
                  fieldName: "Obra",
                  options: availableProjectSites,
                  onChanged: (p0) =>
                      setSelectedProjectSiteAndUpdateLocationSiteResident(p0),
                ),
                const SizedBox(height: 20),
                CustomTextFormField(
                    controller: _direccionController,
                    readOnly: true,
                    labelText: "Direccion",
                    validatorText: ""),
                const SizedBox(height: 20),
                CustomDropdownFormField(
                  labelText: "Residente",
                  items: availableSiteResidents,
                  onChanged: (p0) => _selectedResident = p0,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Informacion de la muestra',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Divider(),
                const SizedBox(height: 20),
                CustomDropdownFormField(
                  labelText: "F'C (kg/cm2)",
                  items: Constants.CONCRETE_COMPRESSION_RESISTANCES,
                  onChanged: (p0) {},
                ),
                const SizedBox(height: 20),
                CustomNumberFormField(
                  labelText: "Revenimiento (cm)",
                  controller: _slumpingController,
                  validatorText: "",
                  maxLength: 2,
                ),
                CustomNumberFormField(
                  controller: _volumeController,
                  labelText: "Volumen (m3)",
                  validatorText: "",
                  maxLength: 3,
                ),
                CustomNumberFormField(
                  controller: _tmaController,
                  labelText: "Tamaño máximo del agregado (mm)",
                  validatorText: "",
                  maxLength: 2,
                ),
                CustomNumberFormField(
                  controller: _designAgeController,
                  labelText: "Edad de diseño (días)",
                  validatorText: "",
                  maxLength: 2,
                ),
                ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        addConcreteQualityOrder();
                      }
                    },
                    child: const Text("Agregar muestra"))
              ],
            ),
          ),
        ),
      ),
    );
  }

  setSelectedCustomerAndUpdateProjectSites(String selected) {
    // RETRIEVE CUSTOMER
    Customer? found = customers.firstWhere((element) =>
        element.sequence.toString().padLeft(Constants.LEADING_ZEROS, "0") ==
        selected.split("-")[0].trim());

    // UPDATE THE LIST OF PROJECT SITES RELATED TO THE GIVEN CUSTOMER
    if (found.id != null) {
      // SET THE SELECTED CUSTOMER IN THE UI
      _selectedCustomer = selected;
      setState(
        () {
          projectSites = found.projects;
          availableProjectSites = projectSites
              .map((e) =>
                  "${e.sequence.toString().padLeft(Constants.LEADING_ZEROS, "0")} - ${e.siteName}")
              .toList();
        },
      );
    }
  }

  setSelectedProjectSiteAndUpdateLocationSiteResident(String selected) {
    // RETRIEVE THE PROJECT SITE
    ProjectSite? found = projectSites.firstWhere((element) =>
        element.sequence.toString().padLeft(Constants.LEADING_ZEROS, "0") ==
        selected.split("-")[0].trim());

    // UPDATE THE FIELDS LOCATION AND SITE RESIDENTS
    if (found.id != null) {
      // SET THE SELECTED CUSTOMER IN THE UI
      _selectedProjectSite = selected;
      setState(
        () {
          Location location = found.location;
          List<SiteResident> siteResidents = found.residents;
          print(siteResidents);
          _direccionController.text =
              "${location.street} ${location.number} ${location.district} - ${location.zipCode} ${location.city} ${location.state.toUpperCase()}";
          availableSiteResidents = siteResidents
              .map((e) =>
                  "${e.sequence.toString().padLeft(Constants.LEADING_ZEROS, "0")} - ${e.jobPosition}. ${e.lastName}, ${e.firstName}")
              .toList();
        },
      );
    }
  }
  
  void addConcreteQualityOrder() {}
}
