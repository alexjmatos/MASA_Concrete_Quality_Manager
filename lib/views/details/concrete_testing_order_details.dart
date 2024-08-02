import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:masa_epico_concrete_manager/dto/concrete_testing_order_details_dto.dart';
import 'package:masa_epico_concrete_manager/dto/concrete_volumetric_weight_dto.dart';
import 'package:masa_epico_concrete_manager/dto/input/concrete_sample_input_dto.dart';
import 'package:masa_epico_concrete_manager/elements/custom_expansion_tile.dart';
import 'package:masa_epico_concrete_manager/elements/custom_select_dropdown.dart';
import 'package:masa_epico_concrete_manager/elements/custom_time_picker_form.dart';
import 'package:masa_epico_concrete_manager/elements/input_number_field.dart';
import 'package:masa_epico_concrete_manager/elements/input_text_field.dart';
import 'package:masa_epico_concrete_manager/models/concrete_cylinder.dart';
import 'package:masa_epico_concrete_manager/reports/report_generator.dart';
import 'package:quickalert/models/quickalert_type.dart';
import 'package:quickalert/widgets/quickalert_dialog.dart';

import '../../constants/constants.dart';
import '../../dto/input/concrete_cylinder_input_dto.dart';
import '../../elements/autocomplete.dart';
import '../../elements/custom_number_form_field.dart';
import '../../elements/custom_text_form_field.dart';
import '../../elements/elevated_button_dialog.dart';
import '../../elements/formatters.dart';
import '../../elements/quantity_form_field.dart';
import '../../elements/value_notifier_list.dart';
import '../../models/concrete_testing_order.dart';
import '../../models/concrete_sample.dart';
import '../../utils/component_utils.dart';
import '../../utils/sequential_counter_generator.dart';
import '../../utils/utils.dart';
import 'package:collection/collection.dart';
import 'dart:math' as math;

class ConcreteTestingOrderDetails extends StatefulWidget {
  final int id;
  final bool readOnly;
  final ValueNotifierList<ConcreteTestingOrder> concreteTestingOrdersNotifier;

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

  // DTOs
  late final ConcreteTestingOrderDetailsDTO dto =
      ConcreteTestingOrderDetailsDTO(
    concreteVolumetricWeightDTO: ConcreteVolumetricWeightDTO(),
    samplesDTOs: [],
    cylindersDTOs: {},
  );

  int designResistanceIndex = 0;
  int designAgeIndex = 0;

  List<ConcreteTestingOrder> concreteTestingOrders = [];
  List<String> selectableConcreteTestingOrders = [];
  int concreteTestingOrderId = 0;

  num volumetricWeight = 0.0;
  num totalLoad = 0.0;
  num totalLoadVolumetricWeightRelation = 0.0;
  num percentage = 0.0;

  bool setTareWeight = true;
  bool setTareVolume = true;

  ReportGenerator reportGenerator = ReportGenerator();

  @override
  void initState() {
    super.initState();
    _setConcreteTestingOrderFields().then((value) => _loadData());
  }

  Future<void> _setConcreteTestingOrderFields() async {
    dto.selectedConcreteTestingOrder =
        await dto.concreteTestingOrderDao.findById(widget.id);

    setState(
      () {
        // SET CUSTOMER
        dto.selectedCustomer = dto.selectedConcreteTestingOrder.customer;
        dto.customerController.text =
            SequentialFormatter.generateSequentialFormatFromCustomer(
                dto.selectedConcreteTestingOrder.customer);

        // SET BUILDING SITE
        dto.selectedBuildingSite =
            dto.selectedConcreteTestingOrder.buildingSite;
        dto.buildingSiteController.text =
            SequentialFormatter.generateSequentialFormatFromBuildingSite(
                dto.selectedConcreteTestingOrder.buildingSite);

        // SET SITE RESIDENT
        dto.selectedSiteResident =
            dto.selectedConcreteTestingOrder.siteResident!;
        dto.siteResidentController.text =
            SequentialFormatter.generateSequentialFormatFromSiteResident(
                dto.selectedConcreteTestingOrder.siteResident);

        // SET DESIGN RESISTANCE
        dto.designResistanceController.text =
            dto.selectedConcreteTestingOrder.designResistance!;

        designResistanceIndex = Constants.CONCRETE_COMPRESSION_RESISTANCES
            .indexOf(dto.selectedConcreteTestingOrder.designResistance!);

        dto.slumpingController.text =
            dto.selectedConcreteTestingOrder.slumping.toString();

        dto.volumeController.text =
            dto.selectedConcreteTestingOrder.volume.toString();

        dto.tmaController.text =
            dto.selectedConcreteTestingOrder.tma.toString();

        dto.designAgeController.text =
            dto.selectedConcreteTestingOrder.designAge!;

        designAgeIndex = Constants.CONCRETE_DESIGN_AGES
            .indexOf(dto.selectedConcreteTestingOrder.designAge!);

        dto.selectedDate = dto.selectedConcreteTestingOrder.testingDate!;

        dto.testingDateController.text = Constants.formatter
            .format(dto.selectedConcreteTestingOrder.testingDate!);

        // final selectedConcreteVolumetricWeight = selectedConcreteTestingOrder
        //     .concreteSamples?.first.concreteVolumetricWeight;

        if (dto.selectedConcreteTestingOrder.concreteSamples != null) {
          dto.samples = dto.selectedConcreteTestingOrder.concreteSamples!;
          dto.cylinders = dto.selectedConcreteTestingOrder.concreteSamples!
              .map((e) => e.concreteCylinders)
              .expand((element) => element)
              .toList();
          dto.cylindersDTOs =
              groupBy(generateDTO(dto.cylinders), (cy) => cy.sampleNumber);
        }
      },
    );
  }

  Future<void> _loadData() async {
    await dto.customerDao.findAll().then((value) {
      dto.clients = value;
    }).whenComplete(() {
      setState(() {
        dto.availableClients = dto.clients
            .map(
              (customer) =>
                  SequentialFormatter.generateSequentialFormatFromCustomer(
                      customer),
            )
            .toList();
      });
    });

    await dto.buildingSiteDao
        .findByClientId(dto.selectedConcreteTestingOrder.customer.id!)
        .then(
      (value) {
        dto.buildingSites = value;
        setState(() {
          dto.availableBuildingSites = dto.buildingSites
              .map(
                (e) => SequentialFormatter
                    .generateSequentialFormatFromBuildingSite(e),
              )
              .toList();
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
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomExpansionTile(
                  title: "Informacion general",
                  children: buildGeneralInfo(),
                  onExpand: () {},
                ),
                CustomExpansionTile(
                  title: "Muestras",
                  children: buildConcreteSamplesInfo(),
                  onExpand: () => updateConcreteSamples(),
                ),
                const SizedBox(height: 16),
                if (!widget.readOnly)
                  Center(
                    child: ElevatedButtonDialog(
                      title: "Confirmar cambios",
                      description: "Presiona OK para realizar la operacion",
                      onOkPressed: () {
                        save(generateReport: false);
                        Navigator.of(context).pop();
                      },
                      textColor: Colors.white,
                      icon: Icons.save,
                      iconColor: Colors.white,
                      buttonColor: Colors.blue,
                    ),
                  ),
                const SizedBox(height: 16),
                Center(
                  child: ElevatedButtonDialog(
                    title: "Guardar y generar formato",
                    description:
                        "Presiona OK para generar el formato de remision",
                    onOkPressed: () async {
                      save(generateReport: true);
                      Navigator.of(context).pop();
                    },
                    textColor: Colors.white,
                    icon: Icons.picture_as_pdf,
                    iconColor: Colors.white,
                    buttonColor: Colors.orange,
                  ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: ElevatedButton.icon(
                    onPressed: () => Navigator.popUntil(context,
                        ModalRoute.withName(Navigator.defaultRouteName)),
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
        options: dto.availableClients,
        onChanged: (p0) => setSelectedCustomer(p0),
        controller: dto.customerController,
        readOnly: widget.readOnly,
      ),
      const SizedBox(height: 20),
      AutoCompleteElement(
        fieldName: "Obra",
        options: dto.availableBuildingSites,
        onChanged: (p0) => setSelectedProjectSite(p0),
        controller: dto.buildingSiteController,
        readOnly: widget.readOnly,
      ),
      const SizedBox(height: 20),
      CustomTextFormField.noValidation(
        controller: dto.siteResidentController,
        labelText: "Residente",
        readOnly: true,
      ),
      const SizedBox(height: 20),
      const Text(
        'Informacion de la orden de muestreo',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      const Divider(),
      const SizedBox(height: 20),
      if (!widget.readOnly)
        CustomSelectDropdown(
          labelText: "F'C (kg/cm2)",
          items: Constants.CONCRETE_COMPRESSION_RESISTANCES,
          onChanged: (p0) => dto.designResistanceController.text = p0,
          defaultValueIndex: designResistanceIndex,
        ),
      if (widget.readOnly)
        CustomTextFormField(
          controller: dto.designResistanceController,
          labelText: "F'C (kg/cm2)",
          validatorText: "",
          readOnly: widget.readOnly,
        ),
      const SizedBox(height: 20),
      CustomNumberFormField(
        labelText: "Revenimiento (cm)",
        controller: dto.slumpingController,
        validatorText: "",
        readOnly: widget.readOnly,
        maxLength: 2,
      ),
      CustomNumberFormField(
        controller: dto.volumeController,
        labelText: "Volumen (m3)",
        validatorText: "",
        readOnly: widget.readOnly,
        maxLength: 3,
      ),
      CustomNumberFormField(
        controller: dto.tmaController,
        labelText: "Tamaño máximo del agregado (mm)",
        validatorText: "",
        readOnly: widget.readOnly,
        maxLength: 2,
      ),
      if (!widget.readOnly)
        CustomSelectDropdown(
            labelText: "Edad de diseño",
            items: Constants.CONCRETE_DESIGN_AGES,
            onChanged: (p0) => dto.designAgeController.text = p0,
            defaultValueIndex: designAgeIndex),
      if (widget.readOnly)
        CustomTextFormField(
          controller: dto.designAgeController,
          labelText: "Edad de diseño",
          validatorText: "",
          readOnly: widget.readOnly,
        ),
      const SizedBox(height: 20),
      CustomTextFormField.noValidation(
        controller: dto.testingDateController,
        labelText: "Fecha de muestreo",
        readOnly: true,
      ),
      const SizedBox(height: 20),
      if (!widget.readOnly)
        TextButton(
          onPressed: () async {
            final DateTime? dateTime = await showDatePicker(
                context: context,
                initialDate: dto.selectedDate,
                firstDate: DateTime(2000),
                lastDate: DateTime(3000));
            if (dateTime != null) {
              setState(
                () {
                  dto.selectedDate = dateTime;
                  dto.testingDateController.text =
                      Constants.formatter.format(dto.selectedDate);
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
      CustomTextFormField(
        controller:
            dto.concreteVolumetricWeightDTO.concreteTestingOrderController,
        labelText: "Orden de muestreo",
        validatorText: "",
        readOnly: true,
      ),
      const SizedBox(height: 20),
      Row(
        children: [
          Expanded(
            child: QuantityFormField(
              labelText: "Peso de la tara (gr)",
              controller: dto.concreteVolumetricWeightDTO.tareWeightController,
              readOnly: setTareWeight,
            ),
          ),
          const SizedBox(width: 4),
          if (!widget.readOnly)
            Expanded(
              child: CheckboxListTile(
                title: const Text("Bloquear"),
                value: setTareWeight,
                onChanged: (value) {
                  setState(
                    () {
                      setTareWeight = !setTareWeight;
                    },
                  );
                },
              ),
            ),
        ],
      ),
      const SizedBox(height: 20),
      QuantityFormField(
        labelText: "Peso del material + tara (gr)",
        controller:
            dto.concreteVolumetricWeightDTO.materialTareWeightController,
        onChanged: (p0) => updateMaterialWeight(p0),
        readOnly: widget.readOnly,
      ),
      const SizedBox(height: 20),
      QuantityFormField(
        labelText: "Peso del material (gr)",
        controller: dto.concreteVolumetricWeightDTO.materialWeightController,
        readOnly: true,
      ),
      const SizedBox(height: 20),
      Row(
        children: [
          Expanded(
            child: QuantityFormField(
              labelText: "Volumen de la tara (cm³)",
              controller: dto.concreteVolumetricWeightDTO.tareVolumeController,
              readOnly: setTareVolume,
            ),
          ),
          const SizedBox(width: 4),
          if (!widget.readOnly)
            Expanded(
              child: CheckboxListTile(
                title: const Text("Bloquear"),
                value: setTareVolume,
                onChanged: (value) {
                  setState(
                    () {
                      setTareVolume = !setTareVolume;
                    },
                  );
                },
              ),
            ),
        ],
      ),
      const SizedBox(height: 20),
      QuantityFormField(
        labelText: "Peso volumetrico (gr/cm³)",
        controller: dto.concreteVolumetricWeightDTO.volumetricWeightController,
        readOnly: true,
      ),
      const SizedBox(height: 20),
      const Text(
        'Material de carga',
        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      const Divider(),
      const SizedBox(height: 20),
      QuantityFormField(
        labelText: "Cemento (kg)",
        controller: dto.concreteVolumetricWeightDTO.cementController,
        onChanged: (p0) => updateTotalLoad(),
      ),
      const SizedBox(height: 20),
      QuantityFormField(
        labelText: "Grava (kg)",
        controller: dto.concreteVolumetricWeightDTO.coarseAggregateController,
        onChanged: (p0) => updateTotalLoad(),
      ),
      const SizedBox(height: 20),
      QuantityFormField(
        labelText: "Arena (kg)",
        controller: dto.concreteVolumetricWeightDTO.fineAggregateController,
        onChanged: (p0) => updateTotalLoad(),
      ),
      const SizedBox(height: 20),
      QuantityFormField(
        labelText: "Agua (kg)",
        controller: dto.concreteVolumetricWeightDTO.waterController,
        onChanged: (p0) => updateTotalLoad(),
      ),
      const SizedBox(height: 16),
      if (!widget.readOnly)
        Row(
          children: [
            Expanded(
              child: TextField(
                controller:
                    dto.concreteVolumetricWeightDTO.additiveTypeController,
                decoration: const InputDecoration(
                  labelText: "Tipo de aditivo",
                  border: OutlineInputBorder(),
                ),
                inputFormatters: [UppercaseInputFormatter()],
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: TextField(
                controller: dto.concreteVolumetricWeightDTO.quantityController,
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(
                  labelText: "Cantidad (lt)",
                  border: OutlineInputBorder(),
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                ],
              ),
            ),
          ],
        ),
      if (!widget.readOnly) const SizedBox(height: 16),
      if (!widget.readOnly)
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ElevatedButton.icon(
              onPressed: _addRow,
              label: const Text(
                'Agregar',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.lightGreen,
                textStyle: const TextStyle(fontSize: 16),
              ),
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
            const SizedBox(width: 16),
            ElevatedButton.icon(
              onPressed: _removeRow,
              label: const Text(
                'Remover',
                style: TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.deepOrange,
                textStyle: const TextStyle(fontSize: 16),
              ),
              icon: const Icon(
                Icons.remove,
                color: Colors.white,
              ),
            ),
          ],
        ),
      const SizedBox(height: 16),
      Row(
        children: [
          DataTable(
            headingRowColor:
                WidgetStateColor.resolveWith((states) => Colors.grey.shade300),
            headingTextStyle: const TextStyle(fontWeight: FontWeight.bold),
            border: TableBorder.all(width: 1, color: Colors.grey),
            columns: const [
              DataColumn(label: Text('Aditivo')),
              DataColumn(label: Text('Cantidad (lt)')),
            ],
            rows: dto.additivesRows
                .map(
                  (row) => DataRow(
                    cells: [
                      DataCell(Text(
                        row['Aditivo']!,
                      )),
                      DataCell(Text(
                        row['Cantidad (lt)']!,
                      )),
                    ],
                  ),
                )
                .toList(),
          ),
        ],
      ),
      const SizedBox(height: 20),
      QuantityFormField(
        labelText: "Carga total",
        controller: dto.concreteVolumetricWeightDTO.totalLoadController,
        onChanged: (p0) => updateTotalLoad(),
        readOnly: true,
      ),
      const SizedBox(height: 20),
      const Divider(thickness: 2.0),
      const SizedBox(height: 20),
      QuantityFormField(
        labelText: "Relación carga total y peso volumetrico",
        controller:
            dto.concreteVolumetricWeightDTO.totalLoadVolumetricWeightController,
        onChanged: (p0) => updateTotalLoad(),
        readOnly: true,
      ),
      const SizedBox(height: 20),
      QuantityFormField(
        labelText: "Porcentaje",
        controller: dto.concreteVolumetricWeightDTO.percentageController,
        onChanged: (p0) => updateTotalLoad(),
        readOnly: true,
      ),
    ];
  }

  List<ExpansionTile> buildConcreteSamplesInfo() {
    dto.samplesDTOs = dto.samples.map((ConcreteSample sample) {
      return ConcreteSampleInputDTO.fromModel(sample);
    }).toList();

    return Iterable.generate(dto.samplesDTOs.length).map((i) {
      List<Widget> widgets = [];
      widgets.addAll([
        const SizedBox(height: 20),
        CustomTextFormField(
          controller: dto.samplesDTOs[i].remissionController,
          labelText: "Remision",
          validatorText: "",
          readOnly: widget.readOnly,
        ),
        const SizedBox(height: 20),
        CustomNumberFormField(
          controller: dto.samplesDTOs[i].volumeController,
          labelText: "Volumen",
          validatorText: "",
          readOnly: widget.readOnly,
        ),
        CustomTimePickerForm(
          timeController: dto.samplesDTOs[i].plantTime,
          timeOfDay: dto.samplesDTOs[i].plantTimeOfDay,
          label: "Hora en planta",
          readOnly: widget.readOnly,
          orientation: PickerOrientation.horizontal,
        ),
        const SizedBox(height: 20),
        CustomTimePickerForm(
          timeController: dto.samplesDTOs[i].buildingSiteTime,
          timeOfDay: dto.samplesDTOs[i].buildingTimeOfDay,
          label: "Hora en obra",
          readOnly: widget.readOnly,
          orientation: PickerOrientation.horizontal,
        ),
        const SizedBox(height: 20),
        CustomNumberFormField(
          controller: dto.samplesDTOs[i].temperature,
          labelText: "Temperatura (°C)",
          validatorText: "",
          readOnly: widget.readOnly,
        ),
        CustomNumberFormField(
          controller: dto.samplesDTOs[i].realSlumpingController,
          labelText: "Revenimiento real (cm)",
          validatorText: "",
          readOnly: widget.readOnly,
        ),
        CustomTextFormField(
          controller: dto.samplesDTOs[i].locationController,
          labelText: "Ubicacion / Elemento",
          validatorText: "",
          readOnly: widget.readOnly,
        ),
        const SizedBox(height: 20),
      ]);

      widgets.add(generateDataTable(dto.cylindersDTOs.values.elementAt(i)));

      return ExpansionTile(
          title: Text(
              "${SequentialFormatter.generatePadLeftNumber(dto.samples[i].id)} - ${dto.samples[i].remission}"),
          children: widgets);
    }).toList();
  }

  void save({required bool generateReport}) async {
    dto
        .updateConcreteTestingOrder()
        .then((value) => dto.updateConcreteSamples())
        .then((value) => dto.updateConcreteCylinders())
        .then((value) => dto.getUpdated(dto.selectedConcreteTestingOrder.id))
        .whenComplete(
      () {
        if (generateReport) {
          QuickAlert.show(
            title: "Exito",
            context: context,
            type: QuickAlertType.success,
            text:
                "Orden de muestreo ${SequentialFormatter.generatePadLeftNumber(dto.selectedConcreteTestingOrder.id)} actualizada con exito",
            autoCloseDuration: const Duration(seconds: 30),
            showConfirmBtn: true,
            confirmBtnText: "Ver formato",
            onConfirmBtnTap: () {
              reportGenerator.savePdf(dto.selectedConcreteTestingOrder).then(
                (value) {
                  if (value != null) {
                    reportGenerator.openPdfPath(value);
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
                "Orden de muestreo ${SequentialFormatter.generatePadLeftNumber(dto.selectedConcreteTestingOrder.id)} actualizada con exito con exito",
            autoCloseDuration: const Duration(seconds: 10),
            showConfirmBtn: true,
            confirmBtnText: "Ok",
            onConfirmBtnTap: () {
              Navigator.popUntil(
                  context, ModalRoute.withName(Navigator.defaultRouteName));
            },
          );
        }
      },
    );
  }

  void setSelectedCustomer(String selected) async {
    dto.customerController.text = selected;
    dto.selectedCustomer = await dto.customerDao.findById(
        SequentialFormatter.getIdNumberFromConsecutive(selected.split("-")[0]));

    dto.buildingSiteDao.findByClientId(dto.selectedCustomer.id!).then((value) {
      dto.buildingSites = value;
      setState(() {
        dto.availableBuildingSites = dto.buildingSites
            .map((e) =>
                "${SequentialFormatter.generatePadLeftNumber(e.id!)} - ${e.siteName}")
            .toList();
      });
    });
  }

  void setSelectedProjectSite(String selected) {
    dto.buildingSiteController.text = selected;
    dto.selectedBuildingSite = dto.buildingSites.firstWhere((element) =>
        element.id ==
        SequentialFormatter.getIdNumberFromConsecutive(
            selected.split("-").first));

    dto.siteResidentDao.findByBuildingSiteId(dto.selectedBuildingSite.id!).then(
      (value) {
        dto.selectedSiteResident = value.first;
        setState(
          () {
            dto.siteResidentController.text =
                SequentialFormatter.generateSequentialFormatFromSiteResident(
                    dto.selectedSiteResident);
          },
        );
      },
    );
  }

  void _addRow() {
    String type =
        dto.concreteVolumetricWeightDTO.additiveTypeController.text.trim();
    String quantity =
        dto.concreteVolumetricWeightDTO.quantityController.text.trim();
    if (type.isNotEmpty && quantity.isNotEmpty) {
      setState(() {
        dto.additivesRows.add({"Aditivo": type, "Cantidad (lt)": quantity});
      });
      dto.concreteVolumetricWeightDTO.additiveTypeController.clear();
      dto.concreteVolumetricWeightDTO.quantityController.clear();
      updateTotalLoad();
    } else {
      ComponentUtils.showSnackbar(
          context, "Introduce el tipo de aditivo y la cantidad en litros",
          isError: true);
    }
  }

  void _removeRow() {
    if (dto.additivesRows.isNotEmpty) {
      setState(
        () {
          dto.additivesRows.removeLast();
        },
      );
    }
    updateTotalLoad();
  }

  Future<void> loadConcreteTestingOrders() async {
    concreteTestingOrderId = widget.id;

    await dto.concreteTestingOrderDao
        .findAll()
        .then((value) => concreteTestingOrders = value)
        .then((value) {
      setState(() {
        selectableConcreteTestingOrders = value
            .map((e) => SequentialFormatter
                .generateSequentialFormatFromConcreteTestingOrder(e))
            .toList();
        if (concreteTestingOrderId != 0) {
          dto.selectedConcreteTestingOrder = concreteTestingOrders
              .firstWhere((element) => element.id == concreteTestingOrderId);
          dto.concreteVolumetricWeightDTO.concreteTestingOrderController.text =
              SequentialFormatter
                  .generateSequentialFormatFromConcreteTestingOrder(
                      dto.selectedConcreteTestingOrder);
        }
      });
    });
  }

  void setSelectedConcreteTestingOrder(String selected) {
    dto.concreteVolumetricWeightDTO.concreteTestingOrderController.text =
        selected;
    dto.selectedConcreteTestingOrder = concreteTestingOrders.firstWhere(
        (element) =>
            element.id ==
            SequentialFormatter.getIdNumberFromConsecutive(selected));
  }

  void updateMaterialWeight(String? p0) {
    dto.concreteVolumetricWeightDTO.materialTareWeightController.text =
        p0 ?? "0.0";
    num tareWeight = int.tryParse(
            dto.concreteVolumetricWeightDTO.tareWeightController.text) ??
        Constants.TARE_WEIGHT;
    num volumeMaterial = num.tryParse(
            dto.concreteVolumetricWeightDTO.tareVolumeController.text) ??
        Constants.TARE_VOLUME;
    num? weightMaterialPlusTare = num.tryParse(
        dto.concreteVolumetricWeightDTO.materialTareWeightController.text);
    num weightMaterial = (weightMaterialPlusTare ?? 0) - (tareWeight);
    volumetricWeight = (weightMaterial / volumeMaterial).floor();
    dto.concreteVolumetricWeightDTO.materialWeightController.text =
        weightMaterial.toString();
    dto.concreteVolumetricWeightDTO.volumetricWeightController.text =
        volumetricWeight.toString();
  }

  void updateTotalLoad() {
    int? volume = int.tryParse(dto.volumeController.text) ?? 7;
    num cementQuantity =
        num.tryParse(dto.concreteVolumetricWeightDTO.cementController.text) ??
            0.0;
    num coarseAggregateQuantity = num.tryParse(
            dto.concreteVolumetricWeightDTO.coarseAggregateController.text) ??
        0.0;
    num fineAggregateQuantity = num.tryParse(
            dto.concreteVolumetricWeightDTO.fineAggregateController.text) ??
        0.0;
    num waterQuantity =
        num.tryParse(dto.concreteVolumetricWeightDTO.waterController.text) ??
            0.0;
    num additives = dto.additivesRows.isNotEmpty
        ? Utils.convert(dto.additivesRows)
            .values
            .reduce((value, element) => value + element)
        : 0.0;

    totalLoad = cementQuantity +
        coarseAggregateQuantity +
        fineAggregateQuantity +
        waterQuantity +
        additives;

    totalLoadVolumetricWeightRelation = totalLoad / volumetricWeight;
    percentage = (totalLoadVolumetricWeightRelation / volume) * 100;

    dto.concreteVolumetricWeightDTO.totalLoadController.text =
        totalLoad.floor().toString();
    dto.concreteVolumetricWeightDTO.totalLoadVolumetricWeightController.text =
        totalLoadVolumetricWeightRelation.toStringAsFixed(2).toString();
    dto.concreteVolumetricWeightDTO.percentageController.text =
        percentage.toStringAsFixed(2).toString();
  }

  void updateConcreteSamples() {}

  Column generateDataTable(List<ConcreteCylinderInputDTO> selection) {
    return Column(
      children: [
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
                headingTextStyle: const TextStyle(fontWeight: FontWeight.bold),
                border: TableBorder.all(width: 1, color: Colors.grey),
                columns: const [
                  DataColumn(
                      label: Expanded(
                          child: Text('EDAD DE ENSAYE',
                              textAlign: TextAlign.center))),
                  DataColumn(
                      label: Expanded(
                          child: Text('FECHA DE ENSAYE',
                              textAlign: TextAlign.center))),
                  DataColumn(
                      label: Expanded(
                          child: Text('CARGA TOTAL (KG)',
                              textAlign: TextAlign.center))),
                  DataColumn(
                      label: Expanded(
                          child: Text('DIAMETRO (CM)',
                              textAlign: TextAlign.center))),
                  DataColumn(
                      label: Expanded(
                          child: Text('RESISTENCIA (KGF/CM2)',
                              textAlign: TextAlign.center))),
                  DataColumn(
                      label: Expanded(
                          child:
                              Text('PORCENTAJE', textAlign: TextAlign.center))),
                  DataColumn(
                      label: Expanded(
                          child:
                              Text('PROMEDIO', textAlign: TextAlign.center))),
                ],
                rows: selection == null
                    ? []
                    : selection
                        .map(
                          (entry) => DataRow(
                            key: ValueKey(entry.id),
                            onLongPress: () {},
                            cells: [
                              DataCell(
                                Center(child: entry.designAge),
                              ),
                              DataCell(
                                Center(child: entry.testingDate),
                              ),
                              DataCell(
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(child: entry.totalLoad),
                                ),
                              ),
                              DataCell(
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(child: entry.diameter),
                                ),
                              ),
                              DataCell(
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(child: entry.resistance),
                                ),
                              ),
                              DataCell(
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(child: entry.percentage),
                                ),
                              ),
                              DataCell(
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Center(child: entry.median),
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
        const SizedBox(
          height: 20,
        )
      ],
    );
  }

  List<ConcreteCylinderInputDTO> generateDTO(List<ConcreteCylinder> value) {
    return value.map(
      (cylinder) {
        // NON EDITABLE FIELD - ONLY CHANGES BASED ON THE CONCRETE TESTING DATE
        InputTextField testingDateInput = InputTextField(
          onChange: (p0) {},
          readOnly: true,
        );
        testingDateInput.controller.text =
            Constants.formatter.format(cylinder.testingDate);

        // EDITABLE FIELD - CHANGES THE TESTING DESIGN DATE
        InputNumberField designAgeInput = InputNumberField(
          acceptDecimalPoint: false,
          onChange: (p0) {
            int? days = int.tryParse(p0);
            if (days != null) {
              testingDateInput.controller.text = Constants.formatter.format(dto
                  .selectedConcreteTestingOrder.testingDate!
                  .add(Duration(days: days)));
            }
          },
          controller: TextEditingController(),
        );
        designAgeInput.controller.text = cylinder.testingAge.toString();

        // CONTROLLERS
        TextEditingController percentageController = TextEditingController();
        TextEditingController resistanceController = TextEditingController();
        TextEditingController totalLoadController = TextEditingController();
        TextEditingController diameterController = TextEditingController();

        // SET INITIAL VALUES
        totalLoadController.text = cylinder.totalLoad?.toStringAsFixed(1) ?? "";
        diameterController.text = cylinder.diameter?.toStringAsFixed(1) ?? "";
        resistanceController.text =
            cylinder.resistance?.toStringAsFixed(1) ?? "";
        percentageController.text =
            cylinder.percentage?.toStringAsFixed(1) ?? "";

        // RESISTANCE - NON EDITABLE FIELD - CHANGES BASED ON THE TOTAL LOAD AND DEFAULT VALUE
        InputNumberField resistance = InputNumberField(
          controller: resistanceController,
          onChange: (p0) {},
          readOnly: true,
        );

        // EDITABLE FIELD - TOTAL LOAD
        InputNumberField totalLoadInput = InputNumberField(
          onChange: (p0) {
            // CALCULATE AREA
            num? diameter = num.tryParse(diameterController.text);
            num? totalLoad = num.tryParse(p0);

            if (diameter != null && totalLoad != null) {
              // CALCULATE RESISTANCE
              num area = (math.pi * math.pow(diameter, 2)) / 4;
              num resistance = totalLoad / area;
              num? designResistance = num.tryParse(
                  dto.selectedConcreteTestingOrder.designResistance ?? "");

              // SET THE FIELD
              resistanceController.text = resistance.toStringAsFixed(1);
              if (designResistance != null) {
                num percentage = (resistance / designResistance) * 100;
                percentageController.text = percentage.toStringAsFixed(1);
              }
            }
          },
          controller: totalLoadController,
        );

        // EDITABLE FIELD - DEFAULT VALUE 15 CM
        InputNumberField diameterInput = InputNumberField(
          onChange: (p0) {
            // CALCULATE AREA
            num? diameter = num.tryParse(p0);
            num? totalLoad = num.tryParse(totalLoadController.text);
            num? designResistance = num.tryParse(
                dto.selectedConcreteTestingOrder.designResistance ?? "");

            if (diameter != null && totalLoad != null) {
              // CALCULATE RESISTANCE
              num area = (math.pi * math.pow(diameter, 2)) / 4;
              num resistance = totalLoad / area;

              // SET THE FIELDS RESISTANCE AND PERCENTAGE
              resistanceController.text = resistance.toStringAsFixed(1);
              if (designResistance != null) {
                num percentage = (resistance / designResistance) * 100;
                percentageController.text = percentage.toStringAsFixed(1);
              }
            }
          },
          controller: diameterController,
        );

        // PERCENTAGE - NON EDITABLE
        InputNumberField percentage = InputNumberField(
          onChange: (p0) {},
          controller: percentageController,
          readOnly: true,
        );

        // MEDIAN - NON EDITABLE
        InputNumberField median = InputNumberField(
          onChange: (p0) {},
          controller: TextEditingController(),
          readOnly: true,
        );

        return ConcreteCylinderInputDTO(
            cylinder.id!,
            cylinder.sampleNumber ?? 0,
            designAgeInput,
            testingDateInput,
            totalLoadInput,
            diameterInput,
            resistance,
            percentage,
            median);
      },
    ).toList();
  }

  void generatePDFDocument(ConcreteTestingOrder order) {
    reportGenerator.savePdf(order).then(
      (value) {
        if (value != null) {
          reportGenerator.openPdfPath(value);
        }
      },
    );
  }
}
