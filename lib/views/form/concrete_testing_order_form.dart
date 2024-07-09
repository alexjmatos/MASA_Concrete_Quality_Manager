import 'dart:io';

import 'package:flutter/material.dart';
import 'package:masa_epico_concrete_manager/constants/constants.dart';
import 'package:masa_epico_concrete_manager/dto/form/concrete_sample_form_dto.dart';
import 'package:masa_epico_concrete_manager/dto/form/concrete_testing_order_form_dto.dart';
import 'package:masa_epico_concrete_manager/elements/autocomplete.dart';
import 'package:masa_epico_concrete_manager/elements/custom_icon_button.dart';
import 'package:masa_epico_concrete_manager/elements/custom_number_form_field.dart';
import 'package:masa_epico_concrete_manager/elements/custom_select_dropdown.dart';
import 'package:masa_epico_concrete_manager/elements/custom_text_form_field.dart';
import 'package:masa_epico_concrete_manager/elements/input_text_field.dart';
import 'package:masa_epico_concrete_manager/elements/input_time_picker_field.dart';
import 'package:masa_epico_concrete_manager/models/concrete_sample_cylinder.dart';
import 'package:masa_epico_concrete_manager/models/concrete_testing_order.dart';
import 'package:masa_epico_concrete_manager/reports/report_generator.dart';
import 'package:masa_epico_concrete_manager/service/customer_dao.dart';
import 'package:masa_epico_concrete_manager/service/building_site_dao.dart';
import 'package:masa_epico_concrete_manager/service/site_resident_dao.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/src/widgets/document.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import 'dart:typed_data' as ty;
import '../../elements/input_number_field.dart';
import '../../utils/component_utils.dart';
import '../../utils/sequential_counter_generator.dart';
import '../../utils/utils.dart';

class ConcreteTestingOrderForm extends StatefulWidget {
  const ConcreteTestingOrderForm({super.key});

  @override
  State<ConcreteTestingOrderForm> createState() =>
      _ConcreteTestingOrderFormState();
}

class _ConcreteTestingOrderFormState extends State<ConcreteTestingOrderForm> {
  final _formKey = GlobalKey<FormState>();

  // DAOs
  final CustomerDAO customerDao = CustomerDAO();
  final BuildingSiteDAO buildingSiteDao = BuildingSiteDAO();
  final SiteResidentDAO siteResidentDao = SiteResidentDAO();

  // REPORT
  final ReportGenerator reportGenerator = ReportGenerator();

  // DTOs
  late final ConcreteTestingOrderFormDTO concreteTestingOrderFormDTO;

  // SELECTION
  List<String> availableClients = [];
  List<String> availableProjectSites = [];

  // PDF FILE
  File? _pdfFile;

  @override
  void initState() {
    super.initState();

    // INIT DTO
    concreteTestingOrderFormDTO = ConcreteTestingOrderFormDTO(
        customerController: TextEditingController(),
        buildingSiteController: TextEditingController(),
        siteResidentController: TextEditingController(),
        designResistanceController: TextEditingController(),
        slumpingController: TextEditingController(),
        volumeController: TextEditingController(),
        tmaController: TextEditingController(),
        designAgeController: TextEditingController(),
        testingDateController: TextEditingController(),
        selectedDate: DateTime.now());

    // INIT DATA
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
                  controller: concreteTestingOrderFormDTO.customerController,
                ),
                const SizedBox(height: 20),
                AutoCompleteElement(
                  fieldName: "Obra",
                  options: availableProjectSites,
                  onChanged: (p0) => setSelectedProjectSite(p0),
                  controller:
                      concreteTestingOrderFormDTO.buildingSiteController,
                ),
                const SizedBox(height: 20),
                CustomTextFormField.noValidation(
                  controller:
                      concreteTestingOrderFormDTO.siteResidentController,
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
                  onChanged: (p0) => concreteTestingOrderFormDTO
                      .designResistanceController.text = p0,
                  defaultValueIndex: -1,
                ),
                const SizedBox(height: 20),
                CustomNumberFormField(
                  labelText: "Revenimiento (cm)",
                  controller: concreteTestingOrderFormDTO.slumpingController,
                  validatorText: "",
                  maxLength: 2,
                ),
                CustomNumberFormField(
                  controller: concreteTestingOrderFormDTO.volumeController,
                  labelText: "Volumen total (m³)",
                  validatorText: "",
                  maxLength: 3,
                ),
                CustomNumberFormField(
                  controller: concreteTestingOrderFormDTO.tmaController,
                  labelText: "Tamaño máximo del agregado (mm)",
                  validatorText: "",
                  maxLength: 2,
                ),
                CustomSelectDropdown(
                  labelText: "Edad de diseño",
                  items: Constants.CONCRETE_DESIGN_AGES,
                  onChanged: (p0) {
                    concreteTestingOrderFormDTO.designAgeController.text = p0;
                    updateDataTableRows(
                            updateDesignAges: true, updateTestingDates: true)
                        .then(
                      (value) {
                        setState(() {
                          concreteTestingOrderFormDTO.samples = value;
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
                        controller:
                            concreteTestingOrderFormDTO.testingDateController,
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
                            initialDate:
                                concreteTestingOrderFormDTO.selectedDate,
                            firstDate: DateTime(2000),
                            lastDate: DateTime(3000));
                        if (dateTime != null) {
                          setState(
                            () {
                              concreteTestingOrderFormDTO.selectedDate =
                                  dateTime;
                              concreteTestingOrderFormDTO.testingDateController
                                  .text = Constants.formatter.format(dateTime);
                            },
                          );
                          updateDataTableRows(
                                  updateDesignAges: false,
                                  updateTestingDates: true)
                              .then(
                            (value) {
                              setState(() {
                                concreteTestingOrderFormDTO.samples = value;
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
                          ConcreteSampleFormDTO value = _buildConcreteSampleDTO(
                              designAgeAndTesting:
                                  Utils.generateTestingDatesBasedOnDesignDays(
                                      concreteTestingOrderFormDTO.selectedDate,
                                      concreteTestingOrderFormDTO
                                              .designAgeController.text));
                          setState(() {
                            concreteTestingOrderFormDTO.samples.add(value);
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
                        rows: concreteTestingOrderFormDTO.samples
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
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Selecciona una opcion:'),
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  save(true);
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Guardar y generar reporte'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  save(false);
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Guardar'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text('Cancelar'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Text("Registrar orden de muestreo"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void save(bool generateReport) {
    ConcreteTestingOrder? order;
    concreteTestingOrderFormDTO.addConcreteTestingOrder(context).then(
      (order) {
        // ORDER STEP
        return concreteTestingOrderFormDTO.addConcreteTestingSamples(order);
      },
    ).then(
      (map) {
        return concreteTestingOrderFormDTO.addConcreteTestingCylinders(map);
      },
    ).then(
      (result) {
        order = result["CONCRETE_TESTING_ORDER"] as ConcreteTestingOrder;

        if (generateReport) {
          QuickAlert.show(
            title: "Exito",
            context: context,
            type: QuickAlertType.success,
            text:
                "Orden de muestreo ${SequentialFormatter.generatePadLeftNumber(order?.id)} agregada con exito",
            autoCloseDuration: const Duration(seconds: 30),
            showConfirmBtn: true,
            confirmBtnText: "Ver reporte",
            onConfirmBtnTap: () {
              savePdf(order!).then(
                (value) {
                  if (value != null) {
                    _openPdfPath(value);
                  }
                  Navigator.popUntil(
                      context, ModalRoute.withName(Navigator.defaultRouteName));
                },
              );
            },
          );
        } else {
          QuickAlert.show(
            title: "Exito",
            context: context,
            type: QuickAlertType.success,
            text:
                "Orden de muestreo ${SequentialFormatter.generatePadLeftNumber(order?.id)} agregada con exito",
            autoCloseDuration: const Duration(seconds: 10),
            showConfirmBtn: true,
            confirmBtnText: "Ok",
          );
        }
      },
    );
  }

  void loadData() {
    customerDao.findAll().then((value) {
      concreteTestingOrderFormDTO.clients = value;
    }).whenComplete(() {
      setState(() {
        availableClients = concreteTestingOrderFormDTO.clients
            .map((customer) =>
                "${SequentialFormatter.generatePadLeftNumber(customer.id!)} - ${customer.identifier}")
            .toList();
      });
    }).then(
      (value) {
        concreteTestingOrderFormDTO.tmaController.text = "20";
        concreteTestingOrderFormDTO.testingDateController.text =
            concreteTestingOrderFormDTO.getTestingDateString();
        concreteTestingOrderFormDTO.designAgeController.text =
            Constants.CONCRETE_DESIGN_AGES.last;
      },
    );
  }

  void setSelectedCustomer(String selected) async {
    concreteTestingOrderFormDTO.customerController.text = selected;
    concreteTestingOrderFormDTO.selectedCustomer = await customerDao.findById(
        SequentialFormatter.getIdNumberFromConsecutive(selected.split("-")[0]));

    buildingSiteDao
        .findByClientId(concreteTestingOrderFormDTO.selectedCustomer!.id!)
        .then((value) {
      concreteTestingOrderFormDTO.buildingSites = value;
      setState(() {
        availableProjectSites = value
            .map((e) =>
                "${SequentialFormatter.generatePadLeftNumber(e.id!)} - ${e.siteName}")
            .toList();
      });
    });
  }

  void setSelectedProjectSite(String selected) {
    concreteTestingOrderFormDTO.buildingSiteController.text = selected;
    concreteTestingOrderFormDTO.selectedBuildingSite =
        concreteTestingOrderFormDTO.buildingSites.firstWhere((element) =>
            element.id ==
            SequentialFormatter.getIdNumberFromConsecutive(
                selected.split("-").first));

    siteResidentDao
        .findByBuildingSiteId(
            concreteTestingOrderFormDTO.selectedBuildingSite!.id!)
        .then((value) {
      setState(() {
        concreteTestingOrderFormDTO.selectedSiteResident = value.first;
        concreteTestingOrderFormDTO.siteResidentController.text =
            "${SequentialFormatter.generatePadLeftNumber(concreteTestingOrderFormDTO.selectedSiteResident?.id!)} - ${concreteTestingOrderFormDTO.selectedSiteResident?.firstName} ${concreteTestingOrderFormDTO.selectedSiteResident?.lastName}";
      });
    });
  }

  ConcreteSampleFormDTO _buildConcreteSampleDTO(
      {required List<Map<String, dynamic>> designAgeAndTesting}) {
    InputNumberField volumeInput = InputNumberField();
    volumeInput.controller.text = "7";

    return ConcreteSampleFormDTO(
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
                  concreteTestingOrderFormDTO.samples
                      .remove(concreteTestingOrderFormDTO.samples[0]);
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

  Future<List<ConcreteSampleFormDTO>> updateDataTableRows(
      {required bool updateDesignAges,
      required bool updateTestingDates}) async {
    if (concreteTestingOrderFormDTO.samples.isNotEmpty) {
      return Iterable.generate(
          concreteTestingOrderFormDTO.samples.length, (index) => index).map(
        (i) {
          if (updateDesignAges) {
            concreteTestingOrderFormDTO
                .samples[i].designAges = Iterable.generate(
                    concreteTestingOrderFormDTO.samples[i].designAges.length)
                .map(
              (j) {
                concreteTestingOrderFormDTO.samples[i].designAges[j].controller
                    .text = Constants.DESIGN_AGES[
                            concreteTestingOrderFormDTO
                                .designAgeController.text]!
                    .elementAt(j)
                    .toString();
                return concreteTestingOrderFormDTO.samples[i].designAges[j];
              },
            ).toList();
          }
          // UPDATE TESTING DATES
          if (updateTestingDates) {
            concreteTestingOrderFormDTO
                .samples[i].testingDates = Iterable.generate(
                    concreteTestingOrderFormDTO.samples[i].testingDates.length)
                .map(
              (j) {
                DateTime temp = concreteTestingOrderFormDTO.selectedDate.add(
                    Duration(
                        days: int.tryParse(concreteTestingOrderFormDTO
                                .samples[i].designAges[j].controller.text) ??
                            0));
                concreteTestingOrderFormDTO.samples[i].testingDates[j]
                    .controller.text = Constants.formatter.format(temp);
                return concreteTestingOrderFormDTO.samples[i].testingDates[j];
              },
            ).toList();
          }
          return concreteTestingOrderFormDTO.samples[i];
        },
      ).toList();
    } else {
      return concreteTestingOrderFormDTO.samples;
    }
  }

  List<ConcreteCylinder> generateConcreteSampleCylinders(
      ConcreteSampleFormDTO dto) {
    return Iterable.generate(dto.designAges.length, (index) => index).map((i) {
      int? testingAge =
          int.tryParse(dto.designAges.elementAt(i).controller.text) ?? 0;
      DateTime testingDate =
          DateTime.tryParse(dto.testingDates.elementAt(i).controller.text) ??
              DateTime.now();

      return ConcreteCylinder(testingAge: testingAge, testingDate: testingDate);
    }).toList();
  }

  void _openPdfPath(String path) {
    OpenFile.open(path);
  }

  Future<String?> savePdf(ConcreteTestingOrder order) async {
    // Generate the PDF document
    Document pdf =
        await reportGenerator.buildReport(PdfPageFormat.a4.landscape, order);

    try {
      // Request storage permissions
      if (await _requestPermissions()) {
        // Get the Downloads directory
        final downloadsDir = await getDownloadsDirectory();
        final file = File(
            "${downloadsDir?.path}/MASA_CONCRETOS_${SequentialFormatter.generatePadLeftNumber(order.id)}.pdf");

        // Save the PDF
        await file.writeAsBytes(await pdf.save());
        print("PDF saved to ${file.path}");
        return file.path;
      } else {
        print("Storage permissions are denied.");
      }
    } catch (e) {
      print("Error saving PDF: $e");
      print(e);
    }
    return null;
  }

  Future<bool> _requestPermissions() async {
    if (Platform.isAndroid) {
      return await Permission.manageExternalStorage.request().isGranted;
    }
    return true;
  }

  Future<Directory?> getDownloadsDirectory() async {
    if (Platform.isAndroid) {
      if (await Permission.manageExternalStorage.request().isGranted) {
        return Directory('/storage/emulated/0/Download');
      }
      return await getExternalStorageDirectory();
    } else {
      return await getApplicationDocumentsDirectory(); // For iOS
    }
  }
}
