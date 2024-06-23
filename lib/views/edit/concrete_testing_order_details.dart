import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:masa_epico_concrete_manager/elements/custom_expansion_tile.dart';
import 'package:masa_epico_concrete_manager/elements/custom_select_dropdown.dart';
import 'package:masa_epico_concrete_manager/models/concrete_volumetric_weight.dart';
import 'package:masa_epico_concrete_manager/service/concrete_testing_order_dao.dart';

import '../../constants/constants.dart';
import '../../elements/autocomplete.dart';
import '../../elements/custom_number_form_field.dart';
import '../../elements/custom_text_form_field.dart';
import '../../elements/elevated_button_dialog.dart';
import '../../elements/formatters.dart';
import '../../elements/quantity_form_field.dart';
import '../../elements/value_notifier_list.dart';
import '../../models/concrete_testing_order.dart';
import '../../models/customer.dart';
import '../../models/building_site.dart';
import '../../models/site_resident.dart';
import '../../service/concrete_volumetric_weight_dao.dart';
import '../../service/customer_dao.dart';
import '../../service/building_site_dao.dart';
import '../../service/site_resident_dao.dart';
import '../../utils/component_utils.dart';
import '../../utils/sequential_counter_generator.dart';
import '../../utils/utils.dart';

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

  final CustomerDao customerDao = CustomerDao();
  final BuildingSiteDao buildingSiteDao = BuildingSiteDao();
  final SiteResidentDao siteResidentDao = SiteResidentDao();
  final ConcreteTestingOrderDao concreteTestingOrderDao =
      ConcreteTestingOrderDao();
  final ConcreteVolumetricWeightDao concreteVolumetricWeightDao =
      ConcreteVolumetricWeightDao();

  static List<Customer> clients = [];
  static List<String> availableClients = [];

  static List<BuildingSite> buildingSites = [];
  static List<String> availableBuildingSites = [];

  late ConcreteTestingOrder selectedConcreteTestingOrder;
  Customer selectedCustomer = Customer(identifier: "", companyName: "");
  BuildingSite selectedBuildingSite = BuildingSite();
  SiteResident selectedSiteResident =
      SiteResident(firstName: "", lastName: "", jobPosition: "");
  ConcreteVolumetricWeight? selectedConcreteVolumetricWeight;

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

  List<ConcreteTestingOrder> concreteTestingOrders = [];
  List<String> selectableConcreteTestingOrders = [];
  int concreteTestingOrderId = 0;

  num volumetricWeight = 0.0;
  num totalLoad = 0.0;
  num totalLoadVolumetricWeightRelation = 0.0;
  num percentage = 0.0;

  final TextEditingController _concreteTestingOrderController =
      TextEditingController();
  final TextEditingController _tareWeightController = TextEditingController();
  final TextEditingController _materialTareWeightController =
      TextEditingController();
  final TextEditingController _materialWeightController =
      TextEditingController();
  final TextEditingController _tareVolumeController = TextEditingController();
  final TextEditingController _volumetricWeightController =
      TextEditingController();
  final TextEditingController _cementController = TextEditingController();
  final TextEditingController _coarseAggregateController =
      TextEditingController();
  final TextEditingController _fineAggregateController =
      TextEditingController();
  final TextEditingController _waterController = TextEditingController();
  final TextEditingController _additiveTypeController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _totalLoadController = TextEditingController();

  final TextEditingController _totalLoadVolumetricWeightController =
      TextEditingController();
  final TextEditingController _percentageController = TextEditingController();

  bool setTareWeight = true;
  bool setTareVolume = true;

  List<Map<String, String>> additivesRows = [];

  @override
  void initState() {
    super.initState();
    _setConcreteTestingOrderFields();
    _loadData();
  }

  void _setConcreteTestingOrderFields() async {
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

            final selectedConcreteVolumetricWeight =
                selectedConcreteTestingOrder.concreteVolumetricWeight;

            if (selectedConcreteVolumetricWeight != null) {
              _concreteTestingOrderController.text = SequentialFormatter
                  .generateSequentialFormatFromConcreteTestingOrder(
                      selectedConcreteTestingOrder);
              _tareWeightController.text =
                  (selectedConcreteVolumetricWeight.tareWeight ?? 0.0)
                      .toStringAsFixed(1);
              _materialTareWeightController.text =
                  (selectedConcreteVolumetricWeight.materialTareWeight ?? 0.0)
                      .toStringAsFixed(1);
              _materialWeightController.text =
                  (selectedConcreteVolumetricWeight.materialWeight ?? 0.0)
                      .toStringAsFixed(1);
              _tareVolumeController.text =
                  (selectedConcreteVolumetricWeight.tareVolume ?? 0.0)
                      .toStringAsFixed(3);
              _volumetricWeightController.text =
                  (selectedConcreteVolumetricWeight.volumetricWeight ?? 0.0)
                      .toStringAsFixed(1);
              _cementController.text =
                  (selectedConcreteVolumetricWeight.cementQuantity ?? 0.0)
                      .toStringAsFixed(1);
              _coarseAggregateController.text =
                  (selectedConcreteVolumetricWeight.coarseAggregateQuantity ??
                          0.0)
                      .toStringAsFixed(1);
              _fineAggregateController.text =
                  (selectedConcreteVolumetricWeight.fineAggregateQuantity ??
                          0.0)
                      .toStringAsFixed(1);
              _waterController.text =
                  (selectedConcreteVolumetricWeight.waterQuantity ?? 0.0)
                      .toStringAsFixed(1);

              additivesRows =
                  selectedConcreteVolumetricWeight.additives.entries.map(
                (e) {
                  Map<String, String> temp = {};
                  temp.putIfAbsent(
                    "Aditivo",
                    () => e.key,
                  );
                  temp.putIfAbsent(
                    "Cantidad (lt)",
                    () => e.value.toStringAsFixed(2),
                  );
                  return temp;
                },
              ).toList();

              _totalLoadController.text =
                  (selectedConcreteVolumetricWeight.totalLoad ?? 0.0)
                      .toStringAsFixed(1);
              _totalLoadVolumetricWeightController.text =
                  (selectedConcreteVolumetricWeight
                              .totalLoadVolumetricWeightRelation ??
                          0.0)
                      .toStringAsFixed(1);
              _percentageController.text =
                  (selectedConcreteVolumetricWeight.percentage ?? 0.0)
                      .toStringAsFixed(1);

              // SET GLOBAL VARIABLES
              volumetricWeight =
                  selectedConcreteVolumetricWeight.volumetricWeight ?? 0.0;
              totalLoad = selectedConcreteVolumetricWeight.totalLoad ?? 0.0;
              totalLoadVolumetricWeightRelation =
                  selectedConcreteVolumetricWeight
                          .totalLoadVolumetricWeightRelation ??
                      0.0;
              percentage = selectedConcreteVolumetricWeight.percentage ?? 0.0;
            }
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
                  title: "Peso volumetrico",
                  children: buildVolumetricWeightInfo(),
                  onExpand: () => updateTotalLoad(),
                ),
                if (!widget.readOnly)
                  ElevatedButtonDialog(
                    title: "Confirmar cambios",
                    description: "Presiona OK para realizar la operacion",
                    onOkPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        updateConcreteQualityOrder();
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
        CustomSelectDropdown(
          labelText: "F'C (kg/cm2)",
          items: Constants.CONCRETE_COMPRESSION_RESISTANCES,
          onChanged: (p0) => _designResistanceController.text = p0,
          defaultValueIndex: designResistanceIndex,
        ),
      if (widget.readOnly)
        CustomTextFormField(
          controller: _designResistanceController,
          labelText: "F'C (kg/cm2)",
          validatorText: "",
        ),
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
      if (!widget.readOnly)
        CustomSelectDropdown(
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
      CustomTextFormField(
        controller: _concreteTestingOrderController,
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
              controller: _tareWeightController,
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
        controller: _materialTareWeightController,
        onChanged: (p0) => updateMaterialWeight(p0),
        readOnly: widget.readOnly,
      ),
      const SizedBox(height: 20),
      QuantityFormField(
        labelText: "Peso del material (gr)",
        controller: _materialWeightController,
        readOnly: true,
      ),
      const SizedBox(height: 20),
      Row(
        children: [
          Expanded(
            child: QuantityFormField(
              labelText: "Volumen de la tara (cm³)",
              controller: _tareVolumeController,
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
        controller: _volumetricWeightController,
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
        controller: _cementController,
        onChanged: (p0) => updateTotalLoad(),
      ),
      const SizedBox(height: 20),
      QuantityFormField(
        labelText: "Grava (kg)",
        controller: _coarseAggregateController,
        onChanged: (p0) => updateTotalLoad(),
      ),
      const SizedBox(height: 20),
      QuantityFormField(
        labelText: "Arena (kg)",
        controller: _fineAggregateController,
        onChanged: (p0) => updateTotalLoad(),
      ),
      const SizedBox(height: 20),
      QuantityFormField(
        labelText: "Agua (kg)",
        controller: _waterController,
        onChanged: (p0) => updateTotalLoad(),
      ),
      const SizedBox(height: 16),
      if (!widget.readOnly)
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _additiveTypeController,
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
                controller: _quantityController,
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
        controller: _totalLoadController,
        onChanged: (p0) => updateTotalLoad(),
        readOnly: true,
      ),
      const SizedBox(height: 20),
      const Divider(thickness: 2.0),
      const SizedBox(height: 20),
      QuantityFormField(
        labelText: "Relación carga total y peso volumetrico",
        controller: _totalLoadVolumetricWeightController,
        onChanged: (p0) => updateTotalLoad(),
        readOnly: true,
      ),
      const SizedBox(height: 20),
      QuantityFormField(
        labelText: "Porcentaje",
        controller: _percentageController,
        onChanged: (p0) => updateTotalLoad(),
        readOnly: true,
      ),
    ];
  }

  Future<void> updateConcreteQualityOrder() async {
    selectedConcreteTestingOrder.slumping =
        int.tryParse(_slumpingController.text);
    selectedConcreteTestingOrder.volume = int.tryParse(_volumeController.text);
    selectedConcreteTestingOrder.tma = int.tryParse(_tmaController.text);
    selectedConcreteTestingOrder.designResistance =
        _designResistanceController.text;
    selectedConcreteTestingOrder.designAge = _designAgeController.text;
    selectedConcreteTestingOrder.testingDate = selectedDate;
    selectedConcreteTestingOrder.customer = selectedCustomer;
    selectedConcreteTestingOrder.buildingSite = selectedBuildingSite;
    selectedConcreteTestingOrder.siteResident = selectedSiteResident;

    final ConcreteVolumetricWeight? concreteVolumetricWeight =
        selectedConcreteTestingOrder.concreteVolumetricWeight;
    int volume = int.tryParse(_volumeController.text) ?? 7;
    num? tareWeight = num.tryParse(_tareWeightController.text);
    num? materialTareWeight = num.tryParse(_materialTareWeightController.text);
    num? materialWeight = num.tryParse(_materialWeightController.text);
    num? tareVolume = num.tryParse(_tareVolumeController.text);
    num? volumeLoad = selectedConcreteTestingOrder.volume;
    num volumetricWeight =
        num.tryParse(_volumetricWeightController.text) ?? 1.0;
    num cementQuantity = num.tryParse(_cementController.text) ?? 0.0;
    num coarseAggregateQuantity =
        num.tryParse(_coarseAggregateController.text) ?? 0.0;
    num fineAggregateQuantity =
        num.tryParse(_fineAggregateController.text) ?? 0.0;
    num waterQuantity = num.tryParse(_waterController.text) ?? 0.0;
    Map<String, num> additives = Utils.convert(additivesRows);
    num additivesTotal = additivesRows.isNotEmpty
        ? Utils.convert(additivesRows)
            .values
            .reduce((value, element) => value + element)
        : 0.0;

    totalLoad = cementQuantity +
        coarseAggregateQuantity +
        fineAggregateQuantity +
        waterQuantity +
        additivesTotal;

    totalLoadVolumetricWeightRelation = totalLoad / volumetricWeight;
    percentage = (totalLoadVolumetricWeightRelation / volume) * 100;

    ConcreteVolumetricWeight? result;

    // If concrete volumetric weight exists, then simply updated
    if (concreteVolumetricWeight != null) {
      concreteVolumetricWeight.tareWeight = tareWeight;
      concreteVolumetricWeight.materialTareWeight = materialTareWeight;
      concreteVolumetricWeight.materialWeight = materialWeight;
      concreteVolumetricWeight.tareVolume = tareVolume;
      concreteVolumetricWeight.volumeLoad = volumeLoad;
      concreteVolumetricWeight.cementQuantity = cementQuantity;
      concreteVolumetricWeight.coarseAggregateQuantity =
          coarseAggregateQuantity;
      concreteVolumetricWeight.fineAggregateQuantity = fineAggregateQuantity;
      concreteVolumetricWeight.waterQuantity = waterQuantity;
      concreteVolumetricWeight.additives = additives;

      result =
          await concreteVolumetricWeightDao.update(concreteVolumetricWeight);
    }
    // Otherwise, add it to the table and also update the concrete testing order
    else {
      ConcreteVolumetricWeight concreteVolumetricWeight =
          ConcreteVolumetricWeight(
              null,
              tareWeight,
              materialTareWeight,
              materialWeight,
              tareVolume,
              volumetricWeight,
              volumeLoad,
              cementQuantity,
              coarseAggregateQuantity,
              fineAggregateQuantity,
              waterQuantity,
              additives,
              totalLoad,
              totalLoadVolumetricWeightRelation,
              percentage);
      result = await concreteVolumetricWeightDao.add(concreteVolumetricWeight);
    }

    if (result != null) {
      selectedConcreteTestingOrder.concreteVolumetricWeight = result;
    }

    return concreteTestingOrderDao
        .update(selectedConcreteTestingOrder)
        .then((value) {
      ComponentUtils.generateSuccessMessage(
          context, "Orden de muestreo actualizado con exito");
      int index = widget.concreteTestingOrdersNotifier.value.indexWhere(
        (element) => element.id == value.id,
      );
      widget.concreteTestingOrdersNotifier.updateAtIndex(index, value);
    }).onError((error, stackTrace) {
      ComponentUtils.generateErrorMessage(context);
    });
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

  void _addRow() {
    String type = _additiveTypeController.text.trim();
    String quantity = _quantityController.text.trim();
    if (type.isNotEmpty && quantity.isNotEmpty) {
      setState(() {
        additivesRows.add({"Aditivo": type, "Cantidad (lt)": quantity});
      });
      _additiveTypeController.clear();
      _quantityController.clear();
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
          _concreteTestingOrderController.text = SequentialFormatter
              .generateSequentialFormatFromConcreteTestingOrder(
                  selectedConcreteTestingOrder);
        }
      });
    });
  }

  void setSelectedConcreteTestingOrder(String selected) {
    _concreteTestingOrderController.text = selected;
    selectedConcreteTestingOrder = concreteTestingOrders.firstWhere((element) =>
        element.id == SequentialFormatter.getIdNumberFromConsecutive(selected));
  }

  void updateMaterialWeight(String? p0) {
    _materialTareWeightController.text = p0 ?? "0.0";
    num tareWeight =
        int.tryParse(_tareWeightController.text) ?? Constants.TARE_WEIGHT;
    num volumeMaterial =
        num.tryParse(_tareVolumeController.text) ?? Constants.TARE_VOLUME;
    num? weightMaterialPlusTare =
        num.tryParse(_materialTareWeightController.text);
    num weightMaterial = (weightMaterialPlusTare ?? 0) - (tareWeight);
    volumetricWeight = (weightMaterial / volumeMaterial).floor();
    _materialWeightController.text = weightMaterial.toString();
    _volumetricWeightController.text = volumetricWeight.toString();
  }

  void updateTotalLoad() {
    int? volume = int.tryParse(_volumeController.text) ?? 7;
    num cementQuantity = num.tryParse(_cementController.text) ?? 0.0;
    num coarseAggregateQuantity =
        num.tryParse(_coarseAggregateController.text) ?? 0.0;
    num fineAggregateQuantity =
        num.tryParse(_fineAggregateController.text) ?? 0.0;
    num waterQuantity = num.tryParse(_waterController.text) ?? 0.0;
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

    _totalLoadController.text = totalLoad.floor().toString();
    _totalLoadVolumetricWeightController.text =
        totalLoadVolumetricWeightRelation.toStringAsFixed(2).toString();
    _percentageController.text = percentage.toStringAsFixed(2).toString();
  }
}
