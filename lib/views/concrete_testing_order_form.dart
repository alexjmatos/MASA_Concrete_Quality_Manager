import 'package:flutter/material.dart';
import 'package:masa_epico_concrete_manager/constants/constants.dart';
import 'package:masa_epico_concrete_manager/dto/building_site_dto.dart';
import 'package:masa_epico_concrete_manager/dto/customer_dto.dart';
import 'package:masa_epico_concrete_manager/dto/site_resident_dto.dart';
import 'package:masa_epico_concrete_manager/elements/autocomplete.dart';
import 'package:masa_epico_concrete_manager/elements/custom_icon_button.dart';
import 'package:masa_epico_concrete_manager/elements/custom_number_form_field.dart';
import 'package:masa_epico_concrete_manager/elements/custom_select_dropdown.dart';
import 'package:masa_epico_concrete_manager/elements/custom_text_form_field.dart';
import 'package:masa_epico_concrete_manager/elements/input_text_field.dart';
import 'package:masa_epico_concrete_manager/elements/input_time_picker_field.dart';
import 'package:masa_epico_concrete_manager/service/concrete_testing_order_dao.dart';
import 'package:masa_epico_concrete_manager/service/concrete_sample_dao.dart';
import 'package:masa_epico_concrete_manager/service/customer_dao.dart';
import 'package:masa_epico_concrete_manager/service/building_site_dao.dart';
import 'package:masa_epico_concrete_manager/service/site_resident_dao.dart';
import 'package:masa_epico_concrete_manager/utils/component_utils.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../database/app_database.dart';
import '../dto/ui/concrete_sample_ui_dto.dart';
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

  final CustomerDAO customerDao = CustomerDAO();
  final BuildingSiteDAO projectSiteDao = BuildingSiteDAO();
  final SiteResidentDAO siteResidentDao = SiteResidentDAO();
  final ConcreteTestingOrderDAO concreteTestingOrderDao =
      ConcreteTestingOrderDAO();
  final ConcreteSampleDAO concreteSampleDao = ConcreteSampleDAO();

  static List<CustomerDTO> clients = [];
  static List<String> availableClients = [];

  static List<BuildingSiteDTO> buildingSites = [];
  static List<String> availableProjectSites = [];

  CustomerDTO selectedCustomer = CustomerDTO(identifier: "", companyName: "");
  BuildingSiteDTO selectedBuildingSite = BuildingSiteDTO(siteName: '');
  SiteResidentDTO selectedSiteResident =
      SiteResidentDTO(firstName: "", lastName: "", jobPosition: "");

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
  List<ConcreteSampleUiDTO> rows = [];
  late TimeOfDay timePlant;
  late TimeOfDay timeBuildingSite;

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
          padding: const EdgeInsets.all(12.0),
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
                    updateDataTableRows(
                            updateDesignAges: true, updateTestingDates: true)
                        .then(
                      (value) {
                        setState(() {
                          rows = value;
                        });
                      },
                    );
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
                            },
                          );
                          updateDataTableRows(
                                  updateDesignAges: false,
                                  updateTestingDates: true)
                              .then(
                            (value) {
                              setState(() {
                                rows = value;
                              });
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
                          ConcreteSampleUiDTO value = _buildConcreteSampleDTO(
                              designAgeAndTesting:
                                  Utils.generateTestingDatesBasedOnDesignDays(
                                      selectedDate,
                                      int.tryParse(_designAgeController.text) ??
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
                        columnSpacing: 12,
                        horizontalMargin: 12,
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
                                  child: Text('T (°C)',
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
                                  DataCell(entry.temperature),
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
                    onOkPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        addConcreteTestingOrder();
                        Navigator.popUntil(context,
                            ModalRoute.withName(Navigator.defaultRouteName));
                      } else {
                        Navigator.pop(context, 'Cancelar');
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

  void addConcreteTestingOrder() {
    ConcreteTestingOrder concreteTestingOrder = ConcreteTestingOrder(
        designResistance: _designResistanceController.text,
        slumpingCm: int.tryParse(_slumpingController.text) ?? 0,
        totalVolumeM3: int.tryParse(_volumeController.text) ?? 0,
        tmaMm: int.tryParse(_tmaController.text) ?? 0,
        designAge: _designAgeController.text,
        testingDate: selectedDate,
        customerId: selectedCustomer.id!,
        buildingSiteId: selectedBuildingSite.id!,
        siteResidentId: selectedSiteResident.id);

    concreteTestingOrderDao.add(concreteTestingOrder).then((value) {
      return addConcreteTestingSamples(value);
    }).then(
      (value) {
        return addConcreteTestingCylinders(value);
      },
    ).then(
      (value) {
        int id = value["CONCRETE_TESTING_ORDER_ID"] as int;
        ComponentUtils.generateSuccessMessage(context,
            "Orden de muestreo ${SequentialFormatter.generatePadLeftNumber(id)} agregada con exito");
      },
    );
  }

  Future<Map<String, Object?>> addConcreteTestingSamples(
      ConcreteTestingOrder order) async {
    List<ConcreteSample> samples = rows.map((sample) {
      return ConcreteSample(
          concreteTestingOrderId: order.id!,
          remission: sample.remission.controller.text,
          volume: double.tryParse(sample.volume.controller.text) ?? 0,
          plantTime: Utils.formatTimeOfDay(
              Utils.parseTimeOfDay(sample.timePlant.timeController.text)),
          buildingSiteTime: Utils.formatTimeOfDay(Utils.parseTimeOfDay(
              sample.timeBuildingSite.timeController.text)),
          realSlumpingCm:
              double.tryParse(sample.realSlumping.controller.text) ?? 0,
          temperatureCelsius:
              double.tryParse(sample.temperature.controller.text) ?? 0,
          location: sample.location.controller.text);
    }).toList();

    var list = await concreteSampleDao.addAll(samples);
    return {"CONCRETE_TESTING_ORDER_ID": order.id, "CONCRETE_SAMPLES": list};
  }

  Future<Map<String, Object?>> addConcreteTestingCylinders(
      Map<String, Object?> previousResult) async {
    List<int> identifiers = previousResult["CONCRETE_SAMPLES"] as List<int>;
    for (var i in Iterable.generate(rows.length, (index) => index)) {
      int sampleNumber = await concreteSampleDao
          .findNextCounterByBuildingSite(selectedBuildingSite.id ?? 0);
      var cylinders = Iterable.generate(
        rows[i].designAges.length,
        (index) => index,
      ).map((j) {
        var dto = rows.elementAt(i);
        var testingAge =
            int.tryParse(dto.designAges.elementAt(j).controller.text) ?? 0;
        var testingDate = Utils.convertToDateTime(
            dto.testingDates.elementAt(j).controller.text);
        return ConcreteCylinder(
          id: sampleNumber,
          testingAgeDays: testingAge,
          testingDate: testingDate.millisecondsSinceEpoch,
          concreteSampleId: identifiers.elementAt(i),
          buildingSiteSampleNumber: sampleNumber,
        );
      }).toList();
      var result = await concreteSampleDao.addAllCylinders(cylinders);
      previousResult.putIfAbsent(
        "CONCRETE_CYLINDERS",
        () => result,
      );
      return previousResult;
    }
    return previousResult;
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
    customerDao
        .findById(SequentialFormatter.getIdNumberFromConsecutive(
            selected.split("-")[0]))
        .then(
      (value) {
        if (value != null) {
          selectedCustomer = CustomerDTO(
              id: value.id,
              identifier: value.identifier,
              companyName: value.companyName);
        }
      },
    );

    projectSiteDao.findByClientId(selectedCustomer.id!).then((value) {
      buildingSites = value
          .map(
            (e) => BuildingSiteDTO(id: e.id, siteName: e.siteName),
          )
          .toList();
      setState(() {
        availableProjectSites = buildingSites
            .map((e) =>
                "${SequentialFormatter.generatePadLeftNumber(e.id!)} - ${e.siteName}")
            .toList();
      });
    });
  }

  void setSelectedProjectSite(String selected) {
    _projectSiteController.text = selected;
    selectedBuildingSite = buildingSites.firstWhere((element) =>
        element.id ==
        SequentialFormatter.getIdNumberFromConsecutive(
            selected.split("-").first));

    siteResidentDao
        .findByBuildingSiteId(selectedBuildingSite.id!)
        .then((value) {
      var model = value.first;
      setState(() {
        selectedSiteResident = SiteResidentDTO(
            id: model.id,
            firstName: model.firstName,
            lastName: model.lastName,
            jobPosition: model.jobPosition);
        _siteResidentController.text =
            "${SequentialFormatter.generatePadLeftNumber(selectedSiteResident.id!)} - ${selectedSiteResident.firstName} ${selectedSiteResident.lastName}";
      });
    });
  }

  ConcreteSampleUiDTO _buildConcreteSampleDTO(
      {required List<Map<String, dynamic>> designAgeAndTesting}) {
    InputNumberField volumeInput = InputNumberField();
    volumeInput.controller.text = "7";

    return ConcreteSampleUiDTO(
        id: Utils.generateUniqueId(),
        remission: InputTextField(lines: 3),
        volume: volumeInput,
        timePlant: InputTimePicker(
          timeOfDay: TimeOfDay.now(),
        ),
        timeBuildingSite: InputTimePicker(
          timeOfDay: TimeOfDay.now(),
        ),
        temperature: InputNumberField(),
        realSlumping: InputNumberField(acceptDecimalPoint: true),
        location: InputTextField(lines: 3),
        designAges: designAgeAndTesting.map(
          (e) {
            InputNumberField designAge = InputNumberField(readOnly: true);
            designAge.controller.text = e[Constants.DESIGN_AGE_KEY].toString();
            return designAge;
          },
        ).toList(),
        testingDates: designAgeAndTesting.map(
          (e) {
            InputTextField testingDate = InputTextField(readOnly: true);
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

  Future<List<ConcreteSampleUiDTO>> updateDataTableRows(
      {required bool updateDesignAges,
      required bool updateTestingDates}) async {
    if (rows.isNotEmpty) {
      return Iterable.generate(rows.length, (index) => index).map(
        (i) {
          if (updateDesignAges) {
            rows[i].designAges =
                Iterable.generate(rows[i].designAges.length).map(
              (j) {
                rows[i].designAges[j].controller.text = Constants
                    .DESIGN_AGES[int.tryParse(_designAgeController.text) ?? 0]!
                    .elementAt(j)
                    .toString();
                return rows[i].designAges[j];
              },
            ).toList();
          }
          // UPDATE TESTING DATES
          if (updateTestingDates) {
            rows[i].testingDates =
                Iterable.generate(rows[i].testingDates.length).map(
              (j) {
                DateTime temp = selectedDate.add(Duration(
                    days: int.tryParse(rows[i].designAges[j].controller.text) ??
                        0));
                rows[i].testingDates[j].controller.text =
                    Constants.formatter.format(temp);
                return rows[i].testingDates[j];
              },
            ).toList();
          }
          return rows[i];
        },
      ).toList();
    } else {
      return rows;
    }
  }

  // List<ConcreteCylinder> generateConcreteSampleCylinders(
  //     ConcreteSampleUiDTO dto) {
  //   return Iterable.generate(dto.designAges.length, (index) => index).map((i) {
  //     int? testingAge =
  //         int.tryParse(dto.designAges.elementAt(i).controller.text) ?? 0;
  //     DateTime testingDate =
  //         DateTime.tryParse(dto.testingDates.elementAt(i).controller.text) ??
  //             DateTime.now();
  //
  //     return ConcreteCylinder(
  //         testingAgeDays: testingAge,
  //         testingDate: testingDate.millisecondsSinceEpoch, buildingSiteSampleNumber: null);
  //   }).toList();
  // }
}
