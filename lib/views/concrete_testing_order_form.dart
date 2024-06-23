import 'package:flutter/material.dart';
import 'package:masa_epico_concrete_manager/constants/constants.dart';
import 'package:masa_epico_concrete_manager/elements/autocomplete.dart';
import 'package:masa_epico_concrete_manager/elements/custom_dropdown_form_field.dart';
import 'package:masa_epico_concrete_manager/elements/custom_number_form_field.dart';
import 'package:masa_epico_concrete_manager/elements/custom_text_form_field.dart';
import 'package:masa_epico_concrete_manager/models/concrete_testing_order.dart';
import 'package:masa_epico_concrete_manager/models/customer.dart';
import 'package:masa_epico_concrete_manager/models/building_site.dart';
import 'package:masa_epico_concrete_manager/models/site_resident.dart';
import 'package:masa_epico_concrete_manager/service/concrete_testing_order_dao.dart';
import 'package:masa_epico_concrete_manager/service/customer_dao.dart';
import 'package:masa_epico_concrete_manager/service/building_site_dao.dart';
import 'package:masa_epico_concrete_manager/service/site_resident_dao.dart';
import 'package:masa_epico_concrete_manager/utils/component_utils.dart';
import 'package:masa_epico_concrete_manager/views/concrete_volumetric_weight_form.dart';

import '../elements/elevated_button_dialog.dart';
import '../utils/sequential_counter_generator.dart';

class ConcreteTestingOrderForm extends StatefulWidget {
  const ConcreteTestingOrderForm({super.key});

  @override
  State<ConcreteTestingOrderForm> createState() =>
      _ConcreteTestingOrderFormState();
}

class _ConcreteTestingOrderFormState extends State<ConcreteTestingOrderForm> {
  final _formKey = GlobalKey<FormState>();
  final CustomerDao customerDao = CustomerDao();
  final BuildingSiteDao projectSiteDao = BuildingSiteDao();
  final SiteResidentDao siteResidentDao = SiteResidentDao();
  final ConcreteTestingOrderDao concreteTestingOrderDao =
      ConcreteTestingOrderDao();

  static List<Customer> clients = [];
  static List<String> availableClients = [];

  static List<BuildingSite> projectSites = [];
  static List<String> availableProjectSites = [];

  Customer selectedCustomer = Customer(identifier: "", companyName: "");
  BuildingSite selectedProjectSite = BuildingSite();
  SiteResident selectedSiteResident =
      SiteResident(firstName: "", lastName: "", jobPosition: "");

  final TextEditingController _customerController = TextEditingController();
  final TextEditingController _projectSiteController = TextEditingController();
  final TextEditingController _siteResidentController = TextEditingController();
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
                  controller: _customerController,
                ),
                const SizedBox(height: 20),
                AutoCompleteElement(
                  fieldName: "Obra",
                  options: availableProjectSites,
                  onChanged: (p0) => setSelectedProjectSite(p0),
                  controller: _projectSiteController,
                ),
                const SizedBox(height: 20),
                CustomTextFormField.noValidation(
                  controller: _siteResidentController,
                  labelText: "Residente",
                  readOnly: true,
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
                  onChanged: (p0) => _designResistanceController.text = p0,
                  defaultValueIndex: 2,
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
                  defaultValueIndex: Constants.CONCRETE_DESIGN_AGES
                      .indexOf(Constants.CONCRETE_DESIGN_AGES.last),
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
                ElevatedButtonDialog(
                  title: "Agregar orden de muestreo",
                  description: "Presiona OK para realizar la operacion",
                  onOkPressed: () {
                    if (_formKey.currentState!.validate()) {
                      addConcreteQualityOrder();
                      Navigator.pop(context);
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

  void addConcreteQualityOrder() {
    ConcreteTestingOrder concreteTestingOrder = ConcreteTestingOrder(
        designResistance: _designResistanceController.text,
        slumping: int.tryParse(_slumpingController.text),
        volume: int.tryParse(_volumeController.text),
        tma: int.tryParse(_tmaController.text),
        designAge: _designAgeController.text,
        testingDate: selectedDate,
        customer: selectedCustomer,
        buildingSite: selectedProjectSite,
        siteResident: selectedSiteResident);

    concreteTestingOrderDao.add(concreteTestingOrder).then((value) {
      ComponentUtils.generateConfirmMessage(
        context,
        "Orden de muestreo - ${SequentialFormatter.generatePadLeftNumber(value.id!)} agregada con exito",
        "¿Deseas realizar el registro del peso volumetrico?",
        ConcreteVolumetricWeightForm.withTestingOrderId(
          concreteTestingOrderId: value.id!,
        ),
      );
    }).onError((error, stackTrace) {
      ComponentUtils.generateErrorMessage(context);
      print(stackTrace);
    });
  }

  void loadCustomerData() {
    customerDao.findAll().then((value) {
      clients = value;
    }).whenComplete(() {
      setState(() {
        availableClients = clients
            .map((customer) =>
                "${SequentialFormatter.generatePadLeftNumber(customer.id!)} - ${customer.identifier}")
            .toList();
      });
    }).then(
      (value) {
        _tmaController.text = "20";
        _volumeController.text = "7";
        _testingDateController.text = Constants.formatter.format(selectedDate);
        _designResistanceController.text =
            Constants.CONCRETE_COMPRESSION_RESISTANCES[2];
        _designAgeController.text = Constants.CONCRETE_DESIGN_AGES.last;
      },
    );
  }

  void setSelectedCustomer(String selected) async {
    _customerController.text = selected;
    selectedCustomer = await customerDao.findById(
        SequentialFormatter.getIdNumberFromConsecutive(
            selected.split("-")[0]));

    projectSiteDao.findByClientId(selectedCustomer.id!).then((value) {
      projectSites = value;
      setState(() {
        availableProjectSites = projectSites
            .map((e) =>
                "${SequentialFormatter.generatePadLeftNumber(e.id!)} - ${e.siteName}")
            .toList();
      });
    });
  }

  void setSelectedProjectSite(String selected) {
    _projectSiteController.text = selected;
    selectedProjectSite = projectSites.firstWhere((element) =>
        element.id ==
        SequentialFormatter.getIdNumberFromConsecutive(
            selected.split("-").first));

    siteResidentDao.findByBuildingSiteId(selectedProjectSite.id!).then((value) {
      setState(() {
        selectedSiteResident = value.first;
        _siteResidentController.text =
            "${SequentialFormatter.generatePadLeftNumber(selectedSiteResident.id!)} - ${selectedSiteResident.firstName} ${selectedSiteResident.lastName}";
      });
    });
  }
}
