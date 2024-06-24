import 'package:flutter/material.dart';
import 'package:masa_epico_concrete_manager/constants/constants.dart';
import 'package:masa_epico_concrete_manager/dto/concrete_testing_sample_dto.dart';
import 'package:masa_epico_concrete_manager/elements/autocomplete.dart';
import 'package:masa_epico_concrete_manager/elements/custom_icon_button.dart';
import 'package:masa_epico_concrete_manager/elements/custom_number_form_field.dart';
import 'package:masa_epico_concrete_manager/elements/custom_select_dropdown.dart';
import 'package:masa_epico_concrete_manager/elements/custom_text_form_field.dart';
import 'package:masa_epico_concrete_manager/elements/input_text_field.dart';
import 'package:masa_epico_concrete_manager/elements/input_time_picker_field.dart';
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
import '../elements/input_number_field.dart';
import '../utils/sequential_counter_generator.dart';
import '../utils/utils.dart';

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
  List<ConcreteTestingSampleDTO> rows = [];

  @override
  void initState() {
    super.initState();
    loadData();
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
                  'Informacion general',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Divider(),
                const SizedBox(height: 20),
                CustomSelectDropdown(
                  labelText: "F'C (kg/cm\u00B2)",
                  items: Constants.CONCRETE_COMPRESSION_RESISTANCES,
                  onChanged: (p0) => _designResistanceController.text = p0,
                  defaultValueIndex: -1,
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
                  labelText: "Volumen total (m³)",
                  validatorText: "",
                  maxLength: 3,
                ),
                CustomNumberFormField(
                  controller: _tmaController,
                  labelText: "Tamaño máximo del agregado (mm)",
                  validatorText: "",
                  maxLength: 2,
                ),
                CustomSelectDropdown(
                  labelText: "Edad de diseño",
                  items: Constants.CONCRETE_DESIGN_AGES,
                  onChanged: (p0) {
                    _designAgeController.text = p0;
                    updateTestingDates();
                  },
                  defaultValueIndex: Constants.CONCRETE_DESIGN_AGES
                      .indexOf(Constants.CONCRETE_DESIGN_AGES.last),
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextFormField.noValidation(
                        controller: _testingDateController,
                        labelText: "Fecha de muestreo",
                        readOnly: true,
                      ),
                    ),
                    const SizedBox(width: 16),
                    CustomIconButton(
                      icon: Icons.punch_clock,
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
                              updateTestingDates();
                            },
                          );
                        }
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 32),
                Row(
                  children: [
                    const Text(
                      'Muestras',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 32),
                    CustomIconButton(
                        buttonColor: Colors.green,
                        icon: Icons.add,
                        onPressed: () {
                          ConcreteTestingSampleDTO value =
                              _buildConcreteTestingSampleDTO(
                                  designAgeAndTesting: Utils
                                      .generateTestingDatesBasedOnDesignDays(
                                          selectedDate,
                                          int.tryParse(
                                                  _designAgeController.text) ??
                                              28));
                          setState(() {
                            rows.add(value);
                          });
                        }),
                  ],
                ),
                const Divider(),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: DataTable(
                        dataRowMaxHeight: double.infinity,
                        headingRowColor: WidgetStateProperty.resolveWith(
                            (states) => Colors.grey.shade300),
                        headingTextStyle:
                            const TextStyle(fontWeight: FontWeight.bold),
                        border: TableBorder.all(width: 1, color: Colors.grey),
                        columns: const [
                          DataColumn(
                              label: Expanded(
                                  child: Text('REMISION',
                                      textAlign: TextAlign.center))),
                          DataColumn(
                              label: Expanded(
                                  child: Text('VOLUMEN',
                                      textAlign: TextAlign.center))),
                          DataColumn(
                              label: Expanded(
                                  child: Text('HORA\nPLANTA',
                                      textAlign: TextAlign.center))),
                          DataColumn(
                              label: Expanded(
                                  child: Text('HORA\nOBRA',
                                      textAlign: TextAlign.center))),
                          DataColumn(
                              label: Expanded(
                                  child: Text('REV REAL',
                                      textAlign: TextAlign.center))),
                          DataColumn(
                              label: Expanded(
                                  child: Text('TRAMO / UBICACION',
                                      textAlign: TextAlign.center))),
                          DataColumn(
                              label: Expanded(
                                  child: Text('EDAD DE ENSAYE',
                                      textAlign: TextAlign.center))),
                          DataColumn(
                              label: Expanded(
                                  child: Text('FECHA DE ENSAYE',
                                      textAlign: TextAlign.center))),
                        ],
                        rows: rows
                            .map(
                              (entry) => DataRow(
                                key: ValueKey(entry.id),
                                onLongPress: () =>
                                    _showDeleteDialog(context, entry.id),
                                cells: [
                                  DataCell(entry.remission),
                                  DataCell(entry.volume),
                                  DataCell(entry.timePlant),
                                  DataCell(entry.timeBuildingSite),
                                  DataCell(entry.realSlumping),
                                  DataCell(entry.location),
                                  DataCell(
                                    Column(
                                      children: entry.designAges.map<Widget>(
                                        (e) {
                                          return Padding(
                                            padding: const EdgeInsets.all(8),
                                            child: e,
                                          );
                                        },
                                      ).toList(),
                                    ),
                                  ),
                                  DataCell(
                                    Column(
                                      children: entry.testingDates.map<Widget>(
                                        (e) {
                                          return Padding(
                                            padding: const EdgeInsets.all(8),
                                            child: e,
                                          );
                                        },
                                      ).toList(),
                                    ),
                                  ),
                                ],
                              ),
                            )
                            .toList(),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Center(
                  child: ElevatedButtonDialog(
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
    });
  }

  void loadData() {
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
        _testingDateController.text = Constants.formatter.format(selectedDate);
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
      setState(() {
        selectedSiteResident = value.first;
        _siteResidentController.text =
            "${SequentialFormatter.generatePadLeftNumber(selectedSiteResident.id!)} - ${selectedSiteResident.firstName} ${selectedSiteResident.lastName}";
      });
    });
  }

  ConcreteTestingSampleDTO _buildConcreteTestingSampleDTO(
      {num volume = 7,
      required List<Map<String, dynamic>> designAgeAndTesting}) {
    return ConcreteTestingSampleDTO(
        id: Utils.generateUniqueId(),
        remission: InputTextField(
          lines: 3,
        ),
        volume: InputNumberField(),
        timePlant: const InputTimePicker(),
        timeBuildingSite: const InputTimePicker(),
        realSlumping: InputNumberField(
          acceptDecimalPoint: true,
        ),
        location: InputTextField(
          lines: 3,
        ),
        designAges: designAgeAndTesting.map(
          (e) {
            InputNumberField designAge = InputNumberField();
            designAge.controller.text = e[Constants.DESIGN_AGE_KEY].toString();
            return designAge;
          },
        ).toList(),
        testingDates: designAgeAndTesting.map(
          (e) {
            InputTextField testingDate = InputTextField(
              readOnly: true,
            );
            DateTime temp = e[Constants.TESTING_DATE_KEY] as DateTime;
            testingDate.controller.text = Constants.formatter.format(temp);
            return testingDate;
          },
        ).toList());
  }

  void _showDeleteDialog(BuildContext context, String id) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirmacion'),
          content: const Text('¿Deseas eliminar esta muestra?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  rows.remove(rows[0]);
                });
                Navigator.of(context).pop(); // Close the dialog
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Muestra eliminada'),
                    backgroundColor: Colors.red,
                  ),
                );
              },
              child: const Text('Eliminar'),
            ),
          ],
        );
      },
    );
  }

  void updateTestingDates() {
    if (rows.isNotEmpty) {
      setState(
        () {
          rows = Iterable.generate(rows.length, (index) => index).map(
            (i) {
              rows[i].testingDates =
                  Iterable.generate(rows[i].testingDates.length).map(
                (j) {
                  DateTime temp = selectedDate.add(Duration(
                      days:
                          int.tryParse(rows[i].designAges[j].controller.text) ??
                              0));
                  rows[i].testingDates[j].controller.text =
                      Constants.formatter.format(temp);
                  return rows[i].testingDates[j];
                },
              ).toList();
              return rows[i];
            },
          ).toList();
        },
      );
    }
  }
}
