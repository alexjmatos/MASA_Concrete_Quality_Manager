import 'package:flutter/material.dart';
import 'package:masa_epico_concrete_manager/constants/constants.dart';
import 'package:masa_epico_concrete_manager/elements/autocomplete.dart';
import 'package:masa_epico_concrete_manager/elements/custom_dropdown_form_field.dart';
import 'package:masa_epico_concrete_manager/elements/custom_number_form_field.dart';
import 'package:masa_epico_concrete_manager/elements/custom_text_form_field.dart';
import 'package:masa_epico_concrete_manager/models/concrete_testing_order.dart';
import 'package:masa_epico_concrete_manager/models/customer.dart';
import 'package:masa_epico_concrete_manager/models/project_site.dart';
import 'package:masa_epico_concrete_manager/models/site_resident.dart';
import 'package:masa_epico_concrete_manager/service/concrete_testing_order_dao.dart';
import 'package:masa_epico_concrete_manager/service/customer_dao.dart';
import 'package:masa_epico_concrete_manager/service/project_site_dao.dart';
import 'package:masa_epico_concrete_manager/service/site_resident_dao.dart';
import 'package:masa_epico_concrete_manager/utils/component_utils.dart';

import '../utils/sequential_counter_generator.dart';

class ConcreteQualityForm extends StatefulWidget {
  const ConcreteQualityForm({super.key});

  @override
  State<ConcreteQualityForm> createState() => _ConcreteQualityFormState();
}

class _ConcreteQualityFormState extends State<ConcreteQualityForm> {
  final _formKey = GlobalKey<FormState>();
  final CustomerDao customerDao = CustomerDao();
  final ProjectSiteDao projectSiteDao = ProjectSiteDao();
  final SiteResidentDao siteResidentDao = SiteResidentDao();
  final ConcreteTestingOrderDao concreteTestingOrderDao =
      ConcreteTestingOrderDao();

  static List<Customer> clients = [];
  static List<String> availableClients = [];

  static List<ProjectSite> projectSites = [];
  static List<String> availableProjectSites = [];

  static List<SiteResident> siteResidents = [];
  static List<String> availableSiteResidents = [];

  Customer selectedCustomer = Customer(identifier: "", companyName: "");
  ProjectSite selectedProjectSite = ProjectSite();
  SiteResident selectedSiteResident =
      SiteResident(firstName: "", lastName: "", jobPosition: "");

  final TextEditingController _designResistanceController =
      TextEditingController();
  final TextEditingController _slumpingController = TextEditingController();
  final TextEditingController _volumeController = TextEditingController();
  final TextEditingController _tmaController = TextEditingController();
  final TextEditingController _designAgeController = TextEditingController();
  final TextEditingController _testingDateController = TextEditingController();

  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    loadCustomerData();
    _tmaController.text = "20";
    _volumeController.text = "7";
    _testingDateController.text = Constants.formatter.format(selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
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
                  options: availableClients,
                  onChanged: (p0) => setSelectedCustomer(p0),
                ),
                const SizedBox(height: 20),
                AutoCompleteElement(
                  fieldName: "Obra",
                  options: availableProjectSites,
                  onChanged: (p0) => setSelectedProjectSite(p0),
                ),
                const SizedBox(height: 20),
                CustomDropdownFormField(
                  labelText: "Residentes",
                  items: availableSiteResidents,
                  onChanged: (p0) => setSelectedSiteResident(p0),
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
                CustomDropdownFormField(
                  labelText: "Edad de diseño",
                  items: Constants.CONCRETE_DESIGN_AGES,
                  onChanged: (p0) {
                    _designAgeController.text = p0;
                  },
                ),
                const SizedBox(height: 20),
                CustomTextFormField.noValidation(
                  controller: _testingDateController,
                  labelText: "Fecha de muestreo",
                  readOnly: true,
                ),
                const SizedBox(height: 20),
                TextButton(
                  onPressed: () async {
                    final DateTime? dateTime = await showDatePicker(
                        context: context,
                        initialDate: selectedDate,
                        firstDate: DateTime(2000),
                        lastDate: DateTime(3000));
                    if (dateTime != null) {
                      setState(() {
                        selectedDate = dateTime;
                        _testingDateController.text =
                            Constants.formatter.format(selectedDate);
                      });
                    }
                  },
                  child: const Text("Seleccionar fecha de muestreo \u23F0"),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      addConcreteQualityOrder();
                    }
                  },
                  child: const Text("Agregar muestra"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void addConcreteQualityOrder() {
    ConcreteTestingOrder concreteTestingOrder = ConcreteTestingOrder(
        designResistance: _designResistanceController.text,
        slumping: int.tryParse(_slumpingController.text),
        volume: int.tryParse(_volumeController.text),
        tma: int.tryParse(_tmaController.text),
        designAge: _designAgeController.text,
        testingDate: selectedDate,
        customer: selectedCustomer,
        projectSite: selectedProjectSite,
        siteResident: selectedSiteResident);

    concreteTestingOrderDao
        .addConcreteTestingOrder(concreteTestingOrder)
        .then((value) {
      ComponentUtils.generateSuccessMessage(context,
          "Orden de muestreo - ${SequentialIdGenerator.generatePadLeftNumber(value.id!)} agregada con exito");
    }).onError((error, stackTrace) {
      print(stackTrace);
      ComponentUtils.generateErrorMessage(context);
    });
  }

  void loadCustomerData() {
    customerDao.getAllCustomers().then((value) {
      clients = value;
    }).whenComplete(() {
      setState(() {
        availableClients = clients
            .map((customer) =>
                "${SequentialIdGenerator.generatePadLeftNumber(customer.id!)} - ${customer.identifier}")
            .toList();
      });
    });
  }

  void setSelectedCustomer(String selected) async {
    selectedCustomer = await customerDao.findById(
        SequentialIdGenerator.getIdNumberFromConsecutive(
            selected.split("-")[0]));

    projectSiteDao
        .findProjectSitesByClientId(selectedCustomer.id!)
        .then((value) {
      projectSites = value;
      setState(() {
        availableProjectSites = projectSites
            .map((e) =>
                "${SequentialIdGenerator.generatePadLeftNumber(e.id!)} - ${e.siteName}")
            .toList();
      });
    });
  }

  void setSelectedProjectSite(String selected) {
    selectedProjectSite = projectSites.firstWhere((element) =>
        element.id ==
        SequentialIdGenerator.getIdNumberFromConsecutive(
            selected.split("-").first));

    siteResidentDao
        .getSiteResidentsByProjectSiteId(selectedProjectSite.id!)
        .then((value) {
      siteResidents = value;
      setState(() {
        availableSiteResidents = value.map((e) {
          return "${SequentialIdGenerator.generatePadLeftNumber(e.id!)} - ${e.firstName} ${e.lastName}";
        }).toList();
      });
    });
  }

  void setSelectedSiteResident(String selected) {
    selectedSiteResident = siteResidents.firstWhere((element) =>
        element.id ==
        SequentialIdGenerator.getIdNumberFromConsecutive(
            selected.split("-").first));
  }
}
