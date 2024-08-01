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
import 'package:masa_epico_concrete_manager/models/concrete_volumetric_weight.dart';
import 'package:masa_epico_concrete_manager/service/concrete_testing_order_dao.dart';

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
import '../../models/customer.dart';
import '../../models/building_site.dart';
import '../../models/site_resident.dart';
import '../../service/concrete_sample_dao.dart';
import '../../service/concrete_volumetric_weight_dao.dart';
import '../../service/customer_dao.dart';
import '../../service/building_site_dao.dart';
import '../../service/site_resident_dao.dart';
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

  final CustomerDAO customerDao = CustomerDAO();
  final BuildingSiteDAO buildingSiteDao = BuildingSiteDAO();
  final SiteResidentDAO siteResidentDao = SiteResidentDAO();
  final ConcreteTestingOrderDAO concreteTestingOrderDao =
      ConcreteTestingOrderDAO();
  final ConcreteVolumetricWeightDAO concreteVolumetricWeightDao =
      ConcreteVolumetricWeightDAO();
  final ConcreteSampleDAO concreteSampleDAO = ConcreteSampleDAO();

  // DTOs
  late final ConcreteTestingOrderDetailsDTO dto =
      ConcreteTestingOrderDetailsDTO(
    concreteVolumetricWeightDTO: ConcreteVolumetricWeightDTO(),
    samples: [],
    cylinders: [],
  );

  static List<Customer> clients = [];
  static List<String> availableClients = [];

  static List<BuildingSite> buildingSites = [];
  static List<String> availableBuildingSites = [];

  late ConcreteTestingOrder selectedConcreteTestingOrder;
  Customer selectedCustomer = Customer(identifier: "", companyName: "");
  BuildingSite selectedBuildingSite = BuildingSite(siteName: "");
  SiteResident selectedSiteResident =
      SiteResident(firstName: "", lastName: "", jobPosition: "");
  ConcreteVolumetricWeight? selectedConcreteVolumetricWeight;

  DateTime selectedDate = DateTime.now();
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

  List<Map<String, String>> additivesRows = [];
  List<ConcreteSample> samples = [];
  List<ConcreteCylinder> cylinders = [];

  @override
  void initState() {
    super.initState();
    _setConcreteTestingOrderFields().then((value) => _loadData());
  }

  Future<void> _setConcreteTestingOrderFields() async {
    selectedConcreteTestingOrder =
        await concreteTestingOrderDao.findById(widget.id);

    setState(
      () {
        // SET CUSTOMER
        selectedCustomer = selectedConcreteTestingOrder.customer;
        dto.customerController.text =
            SequentialFormatter.generateSequentialFormatFromCustomer(
                selectedConcreteTestingOrder.customer);

        // SET BUILDING SITE
        selectedBuildingSite = selectedConcreteTestingOrder.buildingSite;
        dto.buildingSiteController.text =
            SequentialFormatter.generateSequentialFormatFromBuildingSite(
                selectedConcreteTestingOrder.buildingSite);

        // SET SITE RESIDENT
        selectedSiteResident = selectedConcreteTestingOrder.siteResident!;
        dto.siteResidentController.text =
            SequentialFormatter.generateSequentialFormatFromSiteResident(
                selectedConcreteTestingOrder.siteResident);

        // SET DESIGN RESISTANCE
        dto.designResistanceController.text =
            selectedConcreteTestingOrder.designResistance!;

        designResistanceIndex = Constants.CONCRETE_COMPRESSION_RESISTANCES
            .indexOf(selectedConcreteTestingOrder.designResistance!);

        dto.slumpingController.text =
            selectedConcreteTestingOrder.slumping.toString();

        dto.volumeController.text =
            selectedConcreteTestingOrder.volume.toString();

        dto.tmaController.text = selectedConcreteTestingOrder.tma.toString();

        dto.designAgeController.text = selectedConcreteTestingOrder.designAge!;

        designAgeIndex = Constants.CONCRETE_DESIGN_AGES
            .indexOf(selectedConcreteTestingOrder.designAge!);

        selectedDate = selectedConcreteTestingOrder.testingDate!;

        dto.testingDateController.text = Constants.formatter
            .format(selectedConcreteTestingOrder.testingDate!);

        // final selectedConcreteVolumetricWeight = selectedConcreteTestingOrder
        //     .concreteSamples?.first.concreteVolumetricWeight;

        if (selectedConcreteTestingOrder.concreteSamples != null) {
          samples = selectedConcreteTestingOrder.concreteSamples!;
          cylinders = selectedConcreteTestingOrder.concreteSamples!
              .map((e) => e.concreteCylinders)
              .expand((element) => element)
              .toList();
        }

        // if (selectedConcreteVolumetricWeight != null) {
        //   dto.concreteVolumetricWeightDTO.concreteTestingOrderController.text =
        //       SequentialFormatter
        //           .generateSequentialFormatFromConcreteTestingOrder(
        //               selectedConcreteTestingOrder);
        //   dto.concreteVolumetricWeightDTO.tareWeightController.text =
        //       (selectedConcreteVolumetricWeight.tareWeight ?? 0.0)
        //           .toStringAsFixed(1);
        //   dto.concreteVolumetricWeightDTO.materialTareWeightController.text =
        //       (selectedConcreteVolumetricWeight.materialTareWeight ?? 0.0)
        //           .toStringAsFixed(1);
        //   dto.concreteVolumetricWeightDTO.materialWeightController.text =
        //       (selectedConcreteVolumetricWeight.materialWeight ?? 0.0)
        //           .toStringAsFixed(1);
        //   dto.concreteVolumetricWeightDTO.tareVolumeController.text =
        //       (selectedConcreteVolumetricWeight.tareVolume ?? 0.0)
        //           .toStringAsFixed(3);
        //   dto.concreteVolumetricWeightDTO.volumetricWeightController.text =
        //       (selectedConcreteVolumetricWeight.volumetricWeight ?? 0.0)
        //           .toStringAsFixed(1);
        //   dto.concreteVolumetricWeightDTO.cementController.text =
        //       (selectedConcreteVolumetricWeight.cementQuantity ?? 0.0)
        //           .toStringAsFixed(1);
        //   dto.concreteVolumetricWeightDTO.coarseAggregateController.text =
        //       (selectedConcreteVolumetricWeight.coarseAggregateQuantity ?? 0.0)
        //           .toStringAsFixed(1);
        //   dto.concreteVolumetricWeightDTO.fineAggregateController.text =
        //       (selectedConcreteVolumetricWeight.fineAggregateQuantity ?? 0.0)
        //           .toStringAsFixed(1);
        //   dto.concreteVolumetricWeightDTO.waterController.text =
        //       (selectedConcreteVolumetricWeight.waterQuantity ?? 0.0)
        //           .toStringAsFixed(1);
        //
        //   additivesRows =
        //       selectedConcreteVolumetricWeight.additives.entries.map(
        //     (e) {
        //       Map<String, String> temp = {};
        //       temp.putIfAbsent(
        //         "Aditivo",
        //         () => e.key,
        //       );
        //       temp.putIfAbsent(
        //         "Cantidad (lt)",
        //         () => e.value.toStringAsFixed(2),
        //       );
        //       return temp;
        //     },
        //   ).toList();
        //
        //   dto.concreteVolumetricWeightDTO.totalLoadController.text =
        //       (selectedConcreteVolumetricWeight.totalLoad ?? 0.0)
        //           .toStringAsFixed(1);
        //   dto.concreteVolumetricWeightDTO.totalLoadVolumetricWeightController
        //       .text = (selectedConcreteVolumetricWeight
        //               .totalLoadVolumetricWeightRelation ??
        //           0.0)
        //       .toStringAsFixed(1);
        //   dto.concreteVolumetricWeightDTO.percentageController.text =
        //       (selectedConcreteVolumetricWeight.percentage ?? 0.0)
        //           .toStringAsFixed(1);
        //
        //   // SET GLOBAL VARIABLES
        //   volumetricWeight =
        //       selectedConcreteVolumetricWeight.volumetricWeight ?? 0.0;
        //   totalLoad = selectedConcreteVolumetricWeight.totalLoad ?? 0.0;
        //   totalLoadVolumetricWeightRelation = selectedConcreteVolumetricWeight
        //           .totalLoadVolumetricWeightRelation ??
        //       0.0;
        //   percentage = selectedConcreteVolumetricWeight.percentage ?? 0.0;
        // }
      },
    );
  }

  Future<void> _loadData() async {
    await customerDao.findAll().then((value) {
      clients = value;
    }).whenComplete(() {
      setState(() {
        availableClients = clients
            .map(
              (customer) =>
                  SequentialFormatter.generateSequentialFormatFromCustomer(
                      customer),
            )
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
                // CustomExpansionTile(
                //   title: "Pesos volumetricos",
                //   children: buildVolumetricWeightInfo(),
                //   onExpand: () => updateTotalLoad(),
                // ),
                const SizedBox(height: 16),
                if (!widget.readOnly)
                  Center(
                    child: ElevatedButtonDialog(
                      title: "Confirmar cambios",
                      description: "Presiona OK para realizar la operacion",
                      onOkPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          updateConcreteQualityOrder();
                          concreteTestingOrderDao.findAll().then(
                            (value) {
                              widget.concreteTestingOrdersNotifier.value =
                                  value;
                            },
                          );
                          Navigator.popUntil(context,
                              ModalRoute.withName(Navigator.defaultRouteName));
                          _formKey.currentState!.reset();
                        } else {
                          Navigator.pop(context, 'Cancel');
                        }
                      },
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
        options: availableClients,
        onChanged: (p0) => setSelectedCustomer(p0),
        controller: dto.customerController,
        readOnly: widget.readOnly,
      ),
      const SizedBox(height: 20),
      AutoCompleteElement(
        fieldName: "Obra",
        options: availableBuildingSites,
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
                initialDate: selectedDate,
                firstDate: DateTime(2000),
                lastDate: DateTime(3000));
            if (dateTime != null) {
              setState(
                () {
                  selectedDate = dateTime;
                  dto.testingDateController.text =
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
            rows: additivesRows
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
    dto.samples = samples.map((ConcreteSample sample) {
      return ConcreteSampleInputDTO.fromModel(sample);
    }).toList();

    return Iterable.generate(samples.length).map((i) {
      List<Widget> widgets = [];
      widgets.addAll([
        const SizedBox(height: 20),
        CustomTextFormField(
          controller: dto.samples[i].remissionController,
          labelText: "Remision",
          validatorText: "",
          readOnly: widget.readOnly,
        ),
        const SizedBox(height: 20),
        CustomNumberFormField(
          controller: dto.samples[i].volumeController,
          labelText: "Volumen",
          validatorText: "",
          readOnly: widget.readOnly,
        ),
        CustomTimePickerForm(
          timeController: dto.samples[i].plantTime,
          timeOfDay: dto.samples[i].plantTimeOfDay,
          label: "Hora en planta",
          readOnly: widget.readOnly,
          orientation: PickerOrientation.horizontal,
        ),
        const SizedBox(height: 20),
        CustomTimePickerForm(
          timeController: dto.samples[i].buildingSiteTime,
          timeOfDay: dto.samples[i].buildingTimeOfDay,
          label: "Hora en obra",
          readOnly: widget.readOnly,
          orientation: PickerOrientation.horizontal,
        ),
        const SizedBox(height: 20),
        CustomNumberFormField(
          controller: dto.samples[i].temperature,
          labelText: "Temperatura (°C)",
          validatorText: "",
          readOnly: widget.readOnly,
        ),
        CustomNumberFormField(
          controller: dto.samples[i].realSlumpingController,
          labelText: "Revenimiento real (cm)",
          validatorText: "",
          readOnly: widget.readOnly,
        ),
        CustomTextFormField(
          controller: dto.samples[i].locationController,
          labelText: "Ubicacion / Elemento",
          validatorText: "",
          readOnly: widget.readOnly,
        ),
        const SizedBox(height: 20),
      ]);
      widgets.addAll(generateDataTable(samples[i]));

      return ExpansionTile(
          title: Text(
              "${SequentialFormatter.generatePadLeftNumber(samples[i].id)} - ${samples[i].remission}"),
          children: widgets);
    }).toList();
  }

  Future<void> updateConcreteQualityOrder() async {
    // UPDATE GENERAL INFO
    selectedConcreteTestingOrder.slumping =
        int.tryParse(dto.slumpingController.text);
    selectedConcreteTestingOrder.volume =
        int.tryParse(dto.volumeController.text);
    selectedConcreteTestingOrder.tma = int.tryParse(dto.tmaController.text);
    selectedConcreteTestingOrder.designResistance =
        dto.designResistanceController.text;
    selectedConcreteTestingOrder.designAge = dto.designAgeController.text;
    selectedConcreteTestingOrder.testingDate = selectedDate;
    selectedConcreteTestingOrder.customer = selectedCustomer;
    selectedConcreteTestingOrder.buildingSite = selectedBuildingSite;
    selectedConcreteTestingOrder.siteResident = selectedSiteResident;

    concreteTestingOrderDao.update(selectedConcreteTestingOrder);

    // UPDATE CONCRETE SAMPLES
    for (var samp in samples) {
      // RETRIEVE THE INPUT ELEMENT
      var input =
          dto.samples.firstWhereOrNull((element) => element.id == samp.id);

      // UPDATE THE SAMPLE
      if (input != null) {
        samp.remission = input.remissionController.text.trim();
        samp.volume = num.tryParse(input.volumeController.text.trim());
        samp.plantTime = Utils.convertStringToTimeOfDay(input.plantTime.text);
        samp.buildingSiteTime =
            Utils.convertStringToTimeOfDay(input.buildingSiteTime.text);
        samp.temperature = num.tryParse(input.temperature.text.trim());
        samp.realSlumping =
            num.tryParse(input.realSlumpingController.text.trim());
        samp.location = input.locationController.text.trim();
      }
    }

    concreteSampleDAO.updateAllConcreteSamples(samples);

    // UPDATE CONCRETE CYLINDERS
    for (var cylinder in cylinders) {
      var cylinderDTO = dto.cylinders
          .expand((element) => element)
          .firstWhereOrNull((element) => element.id == cylinder.id);

      if (cylinderDTO != null) {
        // UPDATE THE FIELDS
        cylinder.testingAge =
            int.tryParse(cylinderDTO.designAge.controller.text) ?? 0;
        cylinder.testingDate =
            Utils.convertToDateTime(cylinderDTO.testingDate.controller.text);
        cylinder.totalLoad =
            num.tryParse(cylinderDTO.totalLoad.controller.text.trim());
        cylinder.diameter =
            num.tryParse(cylinderDTO.diameter.controller.text.trim());
        cylinder.resistance =
            num.tryParse(cylinderDTO.resistance.controller.text.trim());
        print(
            "------------------------------------------------------------------------");
        print(cylinderDTO);
        print(cylinder);
        print(
            "------------------------------------------------------------------------");
      }
    }

    concreteSampleDAO.updateAllConcreteCylinders(cylinders);

    //
    // final ConcreteVolumetricWeight? concreteVolumetricWeight =
    //     selectedConcreteTestingOrder
    //         .concreteSamples?.first.concreteVolumetricWeight;
    // int volume = int.tryParse(_volumeController.text) ?? 7;
    // num? tareWeight = num.tryParse(_tareWeightController.text);
    // num? materialTareWeight = num.tryParse(_materialTareWeightController.text);
    // num? materialWeight = num.tryParse(_materialWeightController.text);
    // num? tareVolume = num.tryParse(_tareVolumeController.text);
    // num? volumeLoad = selectedConcreteTestingOrder.volume;
    // num volumetricWeight =
    //     num.tryParse(_volumetricWeightController.text) ?? 1.0;
    // num cementQuantity = num.tryParse(_cementController.text) ?? 0.0;
    // num coarseAggregateQuantity =
    //     num.tryParse(_coarseAggregateController.text) ?? 0.0;
    // num fineAggregateQuantity =
    //     num.tryParse(_fineAggregateController.text) ?? 0.0;
    // num waterQuantity = num.tryParse(_waterController.text) ?? 0.0;
    // Map<String, num> additives = Utils.convert(additivesRows);
    // num additivesTotal = additivesRows.isNotEmpty
    //     ? Utils.convert(additivesRows)
    //         .values
    //         .reduce((value, element) => value + element)
    //     : 0.0;
    //
    // totalLoad = cementQuantity +
    //     coarseAggregateQuantity +
    //     fineAggregateQuantity +
    //     waterQuantity +
    //     additivesTotal;
    //
    // totalLoadVolumetricWeightRelation = totalLoad / volumetricWeight;
    // percentage = (totalLoadVolumetricWeightRelation / volume) * 100;
    //
    // ConcreteVolumetricWeight? result;
    //
    // // If concrete volumetric weight exists, then simply updated
    // if (concreteVolumetricWeight != null) {
    //   concreteVolumetricWeight.tareWeight = tareWeight;
    //   concreteVolumetricWeight.materialTareWeight = materialTareWeight;
    //   concreteVolumetricWeight.materialWeight = materialWeight;
    //   concreteVolumetricWeight.tareVolume = tareVolume;
    //   concreteVolumetricWeight.volumeLoad = volumeLoad;
    //   concreteVolumetricWeight.cementQuantity = cementQuantity;
    //   concreteVolumetricWeight.coarseAggregateQuantity =
    //       coarseAggregateQuantity;
    //   concreteVolumetricWeight.fineAggregateQuantity = fineAggregateQuantity;
    //   concreteVolumetricWeight.waterQuantity = waterQuantity;
    //   concreteVolumetricWeight.additives = additives;
    //
    //   result =
    //       await concreteVolumetricWeightDao.update(concreteVolumetricWeight);
    // }
    // // Otherwise, add it to the table and also update the concrete testing order
    // else {
    //   ConcreteVolumetricWeight concreteVolumetricWeight =
    //       ConcreteVolumetricWeight(
    //           null,
    //           tareWeight,
    //           materialTareWeight,
    //           materialWeight,
    //           tareVolume,
    //           volumetricWeight,
    //           volumeLoad,
    //           cementQuantity,
    //           coarseAggregateQuantity,
    //           fineAggregateQuantity,
    //           waterQuantity,
    //           additives,
    //           totalLoad,
    //           totalLoadVolumetricWeightRelation,
    //           percentage);
    //   result = await concreteVolumetricWeightDao.add(concreteVolumetricWeight);
    // }
    //
    // if (result != null) {
    //   selectedConcreteTestingOrder
    //       .concreteSamples?.firstOrNull?.concreteVolumetricWeight = result;
    // }

    // UPDATE THE CONCRETE TESTING ORDER AND SAMPLES

    // return concreteTestingOrderDao
    //     .update(selectedConcreteTestingOrder)
    //     .then((value) {
    //   ComponentUtils.generateSuccessMessage(
    //       context, "Orden de muestreo actualizado con exito");
    //   int index = widget.concreteTestingOrdersNotifier.value.indexWhere(
    //     (element) => element.id == value.id,
    //   );
    //   widget.concreteTestingOrdersNotifier.updateAtIndex(index, value);
    // }).onError((error, stackTrace) {
    //   ComponentUtils.generateErrorMessage(context);
    // });

    // // SET THE CONCRETE SAMPLES
    // if (selectedConcreteTestingOrder.concreteSamples != null) {
    //   // UPDATE CONCRETE SAMPLES
    //   concreteSampleDAO.updateAllConcreteSamples(
    //       selectedConcreteTestingOrder.concreteSamples!);
    //
    //   // UPDATE CYLINDERS
    //   var cylinders = dto.cylinders.expand((element) => element).map(
    //     (cy) {
    //       return ConcreteCylinder(
    //           id: cy.id,
    //           testingAge: int.tryParse(cy.designAge.controller.text) ?? 0,
    //           testingDate:
    //               Utils.convertToDateTime(cy.testingDate.controller.text));
    //     },
    //   ).toList();
    // }
  }

  void setSelectedCustomer(String selected) async {
    dto.customerController.text = selected;
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
    dto.buildingSiteController.text = selected;
    selectedBuildingSite = buildingSites.firstWhere((element) =>
        element.id ==
        SequentialFormatter.getIdNumberFromConsecutive(
            selected.split("-").first));

    siteResidentDao.findByBuildingSiteId(selectedBuildingSite.id!).then(
      (value) {
        selectedSiteResident = value.first;
        setState(
          () {
            dto.siteResidentController.text =
                SequentialFormatter.generateSequentialFormatFromSiteResident(
                    selectedSiteResident);
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
        additivesRows.add({"Aditivo": type, "Cantidad (lt)": quantity});
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
    if (additivesRows.isNotEmpty) {
      setState(
        () {
          additivesRows.removeLast();
        },
      );
    }
    updateTotalLoad();
  }

  Future<void> loadConcreteTestingOrders() async {
    concreteTestingOrderId = widget.id;

    await concreteTestingOrderDao
        .findAll()
        .then((value) => concreteTestingOrders = value)
        .then((value) {
      setState(() {
        selectableConcreteTestingOrders = value
            .map((e) => SequentialFormatter
                .generateSequentialFormatFromConcreteTestingOrder(e))
            .toList();
        if (concreteTestingOrderId != 0) {
          selectedConcreteTestingOrder = concreteTestingOrders
              .firstWhere((element) => element.id == concreteTestingOrderId);
          dto.concreteVolumetricWeightDTO.concreteTestingOrderController.text =
              SequentialFormatter
                  .generateSequentialFormatFromConcreteTestingOrder(
                      selectedConcreteTestingOrder);
        }
      });
    });
  }

  void setSelectedConcreteTestingOrder(String selected) {
    dto.concreteVolumetricWeightDTO.concreteTestingOrderController.text =
        selected;
    selectedConcreteTestingOrder = concreteTestingOrders.firstWhere((element) =>
        element.id == SequentialFormatter.getIdNumberFromConsecutive(selected));
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
    num additives = additivesRows.isNotEmpty
        ? Utils.convert(additivesRows)
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

  List<Widget> generateDataTable(ConcreteSample sample) {
    var groupBySampleNumber =
        groupBy(sample.concreteCylinders, (cy) => cy.sampleNumber);

    var cylinders = groupBySampleNumber.values.map((value) {
      return generateDTO(value);
    }).toList();

    // SAVE THE CYLINDERS FOR REFERENCE
    dto.cylinders.addAll(cylinders);

    return cylinders.map((dto) {
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
                  headingTextStyle:
                      const TextStyle(fontWeight: FontWeight.bold),
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
                            child: Text('PORCENTAJE',
                                textAlign: TextAlign.center))),
                    DataColumn(
                        label: Expanded(
                            child:
                                Text('PROMEDIO', textAlign: TextAlign.center))),
                  ],
                  rows: dto
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
    }).toList();
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
              testingDateInput.controller.text = Constants.formatter.format(
                  selectedConcreteTestingOrder.testingDate!
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
                  selectedConcreteTestingOrder.designResistance ?? "");

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
                selectedConcreteTestingOrder.designResistance ?? "");

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
}
