import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:masa_epico_concrete_manager/elements/custom_expansion_tile.dart';
import 'package:masa_epico_concrete_manager/service/concrete_testing_order_dao.dart';

import '../../constants/constants.dart';
import '../../elements/autocomplete.dart';
import '../../elements/custom_dropdown_form_field.dart';
import '../../elements/custom_number_form_field.dart';
import '../../elements/custom_text_form_field.dart';
import '../../models/concrete_testing_order.dart';
import '../../models/customer.dart';
import '../../models/project_site.dart';
import '../../models/site_resident.dart';
import '../../service/customer_dao.dart';
import '../../service/project_site_dao.dart';
import '../../service/site_resident_dao.dart';
import '../../utils/component_utils.dart';
import '../../utils/sequential_counter_generator.dart';

class ConcreteTestingOrderDetails extends StatefulWidget {
  final int id;
  final bool readOnly;
  final ValueNotifier<List<ConcreteTestingOrder>> concreteTestingOrdersNotifier;

  const ConcreteTestingOrderDetails(
      {super.key,
      required this.id,
      required this.readOnly,
      required this.concreteTestingOrdersNotifier});

  @override
  State<StatefulWidget> createState() => _ConcreteTestingOrderDetailsState();
}

class _ConcreteTestingOrderDetailsState
    extends State<ConcreteTestingOrderDetails> {
  late ConcreteTestingOrder selectedConcreteTestingOrder;
  final CustomerDao customerDao = CustomerDao();
  final ProjectSiteDao projectSiteDao = ProjectSiteDao();
  final SiteResidentDao siteResidentDao = SiteResidentDao();
  final ConcreteTestingOrderDao concreteTestingOrderDao =
      ConcreteTestingOrderDao();

  static List<Customer> clients = [];
  static List<String> availableClients = [];

  static List<BuildingSite> projectSites = [];
  static List<String> availableProjectSites = [];

  static List<SiteResident> siteResidents = [];
  static List<String> availableSiteResidents = [];

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
    concreteTestingOrderDao
        .findById(widget.id)
        .then(
          (value) => selectedConcreteTestingOrder = value,
        )
        .then(
      (value) {
        setState(() {
          _customerController.text =
              SequentialFormatter.generateSequentialFormat(
                  selectedConcreteTestingOrder.customer);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          widget.readOnly ? "Detalles de la muestra" : "Editar la muestra",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomExpansionTile(
                  title: "Informacion general", children: buildGeneralInfo()),
              CustomExpansionTile(
                  title: "Peso volumetrico",
                  children: buildVolumetricWeightInfo()),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> buildGeneralInfo() {
    return [
      const SizedBox(height: 20),
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
    ];
  }

  List<Widget> buildVolumetricWeightInfo() {
    return [
      const SizedBox(height: 20),
    ];
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
      ComponentUtils.generateSuccessMessage(context, "Actualizado con exito");
    }).onError((error, stackTrace) {
      ComponentUtils.generateErrorMessage(context);
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
        SequentialFormatter.getIdNumberFromConsecutive(selected.split("-")[0]));

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
      siteResidents = value;
      setState(() {
        selectedSiteResident = value.first;

        _siteResidentController.text =
            "${SequentialFormatter.generatePadLeftNumber(selectedSiteResident.id!)} - ${selectedSiteResident.firstName} ${selectedSiteResident.lastName}";
      });
    });
  }

  void reset() {
    _customerController.text = "";
    _projectSiteController.text = "";
    _siteResidentController.text = "";
  }
}
