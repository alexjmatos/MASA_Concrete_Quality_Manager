import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:masa_epico_concrete_manager/elements/custom_expansion_tile.dart';
import 'package:masa_epico_concrete_manager/service/concrete_testing_order_dao.dart';

import '../../constants/constants.dart';
import '../../elements/autocomplete.dart';
import '../../elements/custom_dropdown_form_field.dart';
import '../../elements/custom_number_form_field.dart';
import '../../elements/custom_text_form_field.dart';
import '../../elements/elevated_button_dialog.dart';
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
  final _formKey = GlobalKey<FormState>();

  late ConcreteTestingOrder selectedConcreteTestingOrder;
  final CustomerDao customerDao = CustomerDao();
  final BuildingSiteDao buildingSiteDao = BuildingSiteDao();
  final SiteResidentDao siteResidentDao = SiteResidentDao();
  final ConcreteTestingOrderDao concreteTestingOrderDao =
      ConcreteTestingOrderDao();

  static List<Customer> clients = [];
  static List<String> availableClients = [];

  static List<BuildingSite> buildingSites = [];
  static List<String> availableBuildingSites = [];

  Customer selectedCustomer = Customer(identifier: "", companyName: "");
  BuildingSite selectedBuildingSite = BuildingSite();
  SiteResident selectedSiteResident =
      SiteResident(firstName: "", lastName: "", jobPosition: "");

  final TextEditingController _customerController = TextEditingController();
  final TextEditingController _buildingSiteController = TextEditingController();
  final TextEditingController _siteResidentController = TextEditingController();
  final TextEditingController _designResistanceController =
      TextEditingController();
  final TextEditingController _slumpingController = TextEditingController();
  final TextEditingController _volumeController = TextEditingController();
  final TextEditingController _tmaController = TextEditingController();
  final TextEditingController _designAgeController = TextEditingController();
  final TextEditingController _testingDateController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  int designResistanceIndex = 0;
  int designAgeIndex = 0;

  @override
  void initState() {
    super.initState();
    _setOrderFields();
    _loadData();
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
        child: Form(
          key: _formKey,
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
                if (!widget.readOnly)
                  ElevatedButtonDialog(
                    title: "Confirmar cambios",
                    description: "Presiona OK para realizar la operacion",
                    onOkPressed: () {
                      if (_formKey.currentState!.validate()) {
                        updateConcreteQualityOrder();
                        concreteTestingOrderDao.findAll().then((value) =>
                            widget.concreteTestingOrdersNotifier.value = value);
                        Navigator.popUntil(context,
                            ModalRoute.withName(Navigator.defaultRouteName));
                        _formKey.currentState!.reset();
                      } else {
                        Navigator.pop(context, 'Cancel');
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

  List<Widget> buildGeneralInfo() {
    return [
      const SizedBox(height: 20),
      AutoCompleteElement(
        fieldName: "Cliente",
        options: availableClients,
        onChanged: (p0) => setSelectedCustomer(p0),
        controller: _customerController,
        readOnly: widget.readOnly,
      ),
      const SizedBox(height: 20),
      AutoCompleteElement(
        fieldName: "Obra",
        options: availableBuildingSites,
        onChanged: (p0) => setSelectedProjectSite(p0),
        controller: _buildingSiteController,
        readOnly: widget.readOnly,
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
      if (!widget.readOnly)
        CustomDropdownFormField(
          labelText: "F'C (kg/cm2)",
          items: Constants.CONCRETE_COMPRESSION_RESISTANCES,
          onChanged: (p0) => _designResistanceController.text = p0,
          defaultValueIndex: designResistanceIndex,
        ),
      if (widget.readOnly)
        CustomTextFormField(
            controller: _designResistanceController,
            labelText: "F'C (kg/cm2)",
            validatorText: ""),
      const SizedBox(height: 20),
      CustomNumberFormField(
        labelText: "Revenimiento (cm)",
        controller: _slumpingController,
        validatorText: "",
        readOnly: widget.readOnly,
        maxLength: 2,
      ),
      CustomNumberFormField(
        controller: _volumeController,
        labelText: "Volumen (m3)",
        validatorText: "",
        readOnly: widget.readOnly,
        maxLength: 3,
      ),
      CustomNumberFormField(
        controller: _tmaController,
        labelText: "Tamaño máximo del agregado (mm)",
        validatorText: "",
        readOnly: widget.readOnly,
        maxLength: 2,
      ),
      if(!widget.readOnly)
        CustomDropdownFormField(
            labelText: "Edad de diseño",
            items: Constants.CONCRETE_DESIGN_AGES,
            onChanged: (p0) => _designAgeController.text = p0,
            defaultValueIndex: designAgeIndex),
      if (widget.readOnly)
        CustomTextFormField(
            controller: _designAgeController,
            labelText: "Edad de diseño",
            validatorText: ""),
      const SizedBox(height: 20),
      CustomTextFormField.noValidation(
        controller: _testingDateController,
        labelText: "Fecha de muestreo",
        readOnly: widget.readOnly,
      ),
      const SizedBox(height: 20),
      if (!widget.readOnly)
        TextButton(
          onPressed: () async {
            final DateTime? dateTime = await showDatePicker(
                context: context,
                initialDate: selectedDate,
                firstDate: DateTime(2000),
                lastDate: DateTime(3000));
            if (dateTime != null) {
              setState(
                () {
                  selectedDate = dateTime;
                  _testingDateController.text =
                      Constants.formatter.format(selectedDate);
                },
              );
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

  void updateConcreteQualityOrder() {
    selectedConcreteTestingOrder.designResistance =
        _designResistanceController.text;

    selectedConcreteTestingOrder.slumping =
        int.tryParse(_slumpingController.text);
    selectedConcreteTestingOrder.volume = int.tryParse(_volumeController.text);
    selectedConcreteTestingOrder.tma = int.tryParse(_tmaController.text);
    selectedConcreteTestingOrder.designResistance =
        _designResistanceController.text;
    selectedConcreteTestingOrder.testingDate = selectedDate;
    selectedConcreteTestingOrder.customer = selectedCustomer;
    selectedConcreteTestingOrder.buildingSite = selectedBuildingSite;
    selectedConcreteTestingOrder.siteResident = selectedSiteResident;

    concreteTestingOrderDao.update(selectedConcreteTestingOrder).then((value) {
      ComponentUtils.generateSuccessMessage(context, "Actualizado con exito");
    }).onError((error, stackTrace) {
      ComponentUtils.generateErrorMessage(context);
    });
  }

  void _setOrderFields() async {
    await concreteTestingOrderDao
        .findById(widget.id)
        .then((value) => selectedConcreteTestingOrder = value)
        .whenComplete(
      () {
        setState(
          () {
            selectedCustomer = selectedConcreteTestingOrder.customer;
            _customerController.text =
                SequentialFormatter.generateSequentialFormatFromCustomer(
                    selectedConcreteTestingOrder.customer);

            selectedBuildingSite = selectedConcreteTestingOrder.buildingSite;
            _buildingSiteController.text =
                SequentialFormatter.generateSequentialFormatFromBuildingSite(
                    selectedConcreteTestingOrder.buildingSite);

            selectedSiteResident = selectedConcreteTestingOrder.siteResident;
            _siteResidentController.text =
                SequentialFormatter.generateSequentialFormatFromSiteResident(
                    selectedConcreteTestingOrder.siteResident);

            _designResistanceController.text =
                selectedConcreteTestingOrder.designResistance!;

            designResistanceIndex = Constants.CONCRETE_COMPRESSION_RESISTANCES
                .indexOf(selectedConcreteTestingOrder.designResistance!);

            _slumpingController.text =
                selectedConcreteTestingOrder.slumping.toString();

            _volumeController.text =
                selectedConcreteTestingOrder.volume.toString();

            _tmaController.text = selectedConcreteTestingOrder.tma.toString();

            _designAgeController.text = selectedConcreteTestingOrder.designAge!;

            designAgeIndex = Constants.CONCRETE_DESIGN_AGES
                .indexOf(selectedConcreteTestingOrder.designAge!);

            selectedDate = selectedConcreteTestingOrder.testingDate!;

            _testingDateController.text = Constants.formatter
                .format(selectedConcreteTestingOrder.testingDate!);
          },
        );
      },
    );
  }

  Future<void> _loadData() async {
    await customerDao.findAll().then((value) {
      clients = value;
    }).whenComplete(() {
      setState(() {
        availableClients = clients
            .map((customer) =>
                SequentialFormatter.generateSequentialFormatFromCustomer(
                    customer))
            .toList();
      });
    });

    await buildingSiteDao
        .findByClientId(selectedConcreteTestingOrder.customer.id!)
        .then(
      (value) {
        buildingSites = value;
        setState(() {
          availableBuildingSites = buildingSites
              .map((e) =>
                  SequentialFormatter.generateSequentialFormatFromBuildingSite(
                      e))
              .toList();
        });
      },
    );
  }

  void setSelectedCustomer(String selected) async {
    _customerController.text = selected;
    selectedCustomer = await customerDao.findById(
        SequentialFormatter.getIdNumberFromConsecutive(selected.split("-")[0]));

    buildingSiteDao.findByClientId(selectedCustomer.id!).then((value) {
      buildingSites = value;
      setState(() {
        availableBuildingSites = buildingSites
            .map((e) =>
                "${SequentialFormatter.generatePadLeftNumber(e.id!)} - ${e.siteName}")
            .toList();
      });
    });
  }

  void setSelectedProjectSite(String selected) {
    _buildingSiteController.text = selected;
    selectedBuildingSite = buildingSites.firstWhere((element) =>
        element.id ==
        SequentialFormatter.getIdNumberFromConsecutive(
            selected.split("-").first));

    siteResidentDao.findByBuildingSiteId(selectedBuildingSite.id!).then(
      (value) {
        selectedSiteResident = value.first;
        setState(
          () {
            _siteResidentController.text =
                SequentialFormatter.generateSequentialFormatFromSiteResident(
                    selectedSiteResident);
          },
        );
      },
    );
  }
}
