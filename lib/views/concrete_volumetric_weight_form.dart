import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:masa_epico_concrete_manager/dto/concrete_testing_order_dto.dart';
import 'package:masa_epico_concrete_manager/elements/custom_text_form_field.dart';
import 'package:masa_epico_concrete_manager/elements/elevated_button_dialog.dart';
import 'package:masa_epico_concrete_manager/elements/formatters.dart';
import 'package:masa_epico_concrete_manager/elements/quantity_form_field.dart';
import 'package:masa_epico_concrete_manager/service/concrete_testing_order_dao.dart';
import 'package:masa_epico_concrete_manager/service/concrete_volumetric_weight_dao.dart';
import 'package:masa_epico_concrete_manager/utils/component_utils.dart';
import 'package:masa_epico_concrete_manager/utils/sequential_counter_generator.dart';
import 'package:masa_epico_concrete_manager/utils/utils.dart';

import '../constants/constants.dart';
import '../database/app_database.dart';
import '../database/tables.dart';
import '../dto/concrete_volumetric_weight_dto.dart';
import '../elements/autocomplete.dart';

class ConcreteVolumetricWeightForm extends StatefulWidget {
  final int concreteTestingOrderId;

  const ConcreteVolumetricWeightForm(
      {super.key, this.concreteTestingOrderId = 0});

  const ConcreteVolumetricWeightForm.withTestingOrderId(
      {required this.concreteTestingOrderId, super.key});

  @override
  State<ConcreteVolumetricWeightForm> createState() =>
      _ConcreteVolumetricWeightState();
}

class _ConcreteVolumetricWeightState
    extends State<ConcreteVolumetricWeightForm> {
  final _formKey = GlobalKey<FormState>();
  ConcreteTestingOrderDAO concreteTestingOrderDao = ConcreteTestingOrderDAO();
  ConcreteVolumetricWeightDAO concreteVolumetricWeightDao =
      ConcreteVolumetricWeightDAO();

  List<ConcreteTestingOrderDTO> concreteTestingOrders = [];
  List<String> selectableConcreteTestingOrders = [];
  int concreteTestingOrderId = 0;
  late ConcreteTestingOrderDTO selectedConcreteTestingOrder;

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

  List<Map<String, String>> rows = [];

  @override
  void initState() {
    super.initState();
    loadConcreteTestingOrders();
    _tareWeightController.text = Constants.TARE_WEIGHT.toString();
    _tareVolumeController.text = Constants.TARE_VOLUME.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text(
          'Peso volumetrico',
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
                if (widget.concreteTestingOrderId == 0)
                  AutoCompleteElement(
                    fieldName: "Orden de muestreo",
                    options: selectableConcreteTestingOrders,
                    onChanged: (p0) => setSelectedConcreteTestingOrder(p0),
                    controller: _concreteTestingOrderController,
                  ),
                if (widget.concreteTestingOrderId != 0)
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
                    const SizedBox(width: 8),
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
                    )
                  ],
                ),
                const SizedBox(height: 20),
                QuantityFormField(
                  labelText: "Peso del material + tara (gr)",
                  controller: _materialTareWeightController,
                  onChanged: (p0) => updateMaterialWeight(p0),
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
                    const SizedBox(width: 8),
                    Expanded(
                      child: CheckboxListTile(
                        title: const Text("Bloquear"),
                        value: setTareVolume,
                        onChanged: (value) {
                          setState(() {
                            setTareVolume = !setTareVolume;
                          });
                        },
                      ),
                    )
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
                const SizedBox(height: 20),
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
                        keyboardType: const TextInputType.numberWithOptions(
                            decimal: true),
                        decoration: const InputDecoration(
                          labelText: "Cantidad (lt)",
                          border: OutlineInputBorder(),
                        ),
                        inputFormatters: [
                          FilteringTextInputFormatter.allow(
                              RegExp(r'^\d*\.?\d*')),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
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
                      headingRowColor: WidgetStateColor.resolveWith(
                          (states) => Colors.grey.shade300),
                      headingTextStyle:
                          const TextStyle(fontWeight: FontWeight.bold),
                      border: TableBorder.all(width: 1, color: Colors.grey),
                      columns: const [
                        DataColumn(label: Text('Aditivo')),
                        DataColumn(label: Text('Cantidad (lt)')),
                      ],
                      rows: rows
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
                const SizedBox(height: 20),
                ElevatedButtonDialog(
                  title: "Registrar peso volumetrico",
                  description:
                      "Presiona OK para registrar el peso volumetrico de la muestra",
                  onOkPressed: () {
                    if (_formKey.currentState!.validate()) {
                      addConcreteVolumetricWeight();
                      Navigator.pop(context);
                      _formKey.currentState!.reset();
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _addRow() {
    String type = _additiveTypeController.text.trim();
    String quantity = _quantityController.text.trim();
    if (type.isNotEmpty && quantity.isNotEmpty) {
      setState(() {
        rows.add({"Aditivo": type, "Cantidad (lt)": quantity});
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
    if (rows.isNotEmpty) {
      setState(
        () {
          rows.removeLast();
        },
      );
    }
    updateTotalLoad();
  }

  Future<void> loadConcreteTestingOrders() async {
    concreteTestingOrderId = widget.concreteTestingOrderId;

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
    int? weightMaterialPlusTare =
        int.tryParse(_materialTareWeightController.text);
    num weightMaterial = (weightMaterialPlusTare ?? 0) - (tareWeight);
    volumetricWeight = (weightMaterial / volumeMaterial).floor();
    _materialWeightController.text = weightMaterial.toString();
    _volumetricWeightController.text = volumetricWeight.toString();
  }

  void updateTotalLoad() {
    num cementQuantity = num.tryParse(_cementController.text) ?? 0.0;
    num coarseAggregateQuantity =
        num.tryParse(_coarseAggregateController.text) ?? 0.0;
    num fineAggregateQuantity =
        num.tryParse(_fineAggregateController.text) ?? 0.0;
    num waterQuantity = num.tryParse(_waterController.text) ?? 0.0;
    num additives = rows.isNotEmpty
        ? Utils.convert(rows).values.reduce((value, element) => value + element)
        : 0.0;

    totalLoad = cementQuantity +
        coarseAggregateQuantity +
        fineAggregateQuantity +
        waterQuantity +
        additives;

    totalLoadVolumetricWeightRelation = totalLoad / volumetricWeight;
    percentage = (totalLoadVolumetricWeightRelation / 7.0) * 100;

    _totalLoadController.text = totalLoad.floor().toString();
    _totalLoadVolumetricWeightController.text =
        totalLoadVolumetricWeightRelation.toStringAsFixed(2).toString();
    _percentageController.text = percentage.toStringAsFixed(2).toString();
  }

  Future<void> addConcreteVolumetricWeight() async {
    num? tareWeight = num.tryParse(_tareWeightController.text);
    num? materialTareWeight = num.tryParse(_materialTareWeightController.text);
    num? materialWeight = num.tryParse(_materialWeightController.text);
    num? tareVolume = num.tryParse(_tareVolumeController.text);
    num? volumeLoad = selectedConcreteTestingOrder.volumeM3;
    num? cementQuantity = num.tryParse(_cementController.text);
    num? coarseAggregateQuantity =
        num.tryParse(_coarseAggregateController.text);
    num? fineAggregateQuantity = num.tryParse(_fineAggregateController.text);
    num? waterQuantity = num.tryParse(_waterController.text);

    ConcreteVolumetricWeight concreteVolumetricWeight =
        ConcreteVolumetricWeight(
            tareWeightGr: tareWeight != null ? tareWeight.toDouble() : 0,
            materialTareWeightGr:
                materialTareWeight != null ? materialTareWeight.toDouble() : 0,
            materialWeightGr:
                materialWeight != null ? materialWeight.toDouble() : 0,
            tareVolumeCm3: tareVolume != null ? tareVolume.toDouble() : 0,
            volumetricWeightGrCm3: volumetricWeight.toDouble(),
            volumeLoadM3: volumeLoad != null ? volumeLoad.toDouble() : 0,
            cementQuantityKg:
                cementQuantity != null ? cementQuantity.toDouble() : 0,
            coarseAggregateKg: coarseAggregateQuantity != null
                ? coarseAggregateQuantity.toDouble()
                : 0,
            fineAggregateKg: fineAggregateQuantity != null
                ? fineAggregateQuantity.toDouble()
                : 0,
            waterKg: waterQuantity != null ? waterQuantity.toDouble() : 0,
            additives: Utils.convert(rows).toString(),
            totalLoadKg: totalLoad.toDouble(),
            totalLoadVolumetricWeightRelation:
                totalLoadVolumetricWeightRelation.toDouble(),
            percentage: percentage.toDouble());

    // ADD THE CONCRETE VOLUMETRIC WEIGHT
    await concreteVolumetricWeightDao.add(concreteVolumetricWeight).then(
        (value) => selectedConcreteTestingOrder
                .concreteSamples?.firstOrNull?.concreteVolumetricWeight =
            ConcreteVolumetricWeightDTO.fromModel(value));
    // UPDATE THE CONCRETE TESTING ORDER

    ConcreteTestingOrder toUpdate = ConcreteTestingOrder(
        id: selectedConcreteTestingOrder.id,
        designResistance: selectedConcreteTestingOrder.designResistance ?? "",
        slumpingCm: selectedConcreteTestingOrder.slumpingCm ?? 0,
        totalVolumeM3: selectedConcreteTestingOrder.slumpingCm ?? 0,
        tmaMm: selectedConcreteTestingOrder.tmaMm ?? 0,
        designAge: selectedConcreteTestingOrder.designAge ?? "",
        testingDate: selectedConcreteTestingOrder.testingDate ?? DateTime.now(),
        customerId: selectedConcreteTestingOrder.slumpingCm ?? 0,
        buildingSiteId: selectedConcreteTestingOrder.slumpingCm ?? 0);

    await concreteTestingOrderDao.update(toUpdate).then((value) {
      ComponentUtils.generateSuccessMessage(
          context, "Peso volumetrico registrado con exito");
    }).onError((error, stackTrace) {
      ComponentUtils.generateErrorMessage(context);
    });
  }
}
