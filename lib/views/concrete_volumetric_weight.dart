import 'package:flutter/material.dart';
import 'package:masa_epico_concrete_manager/elements/custom_text_form_field.dart';
import 'package:masa_epico_concrete_manager/elements/quantity_form_field.dart';
import 'package:masa_epico_concrete_manager/models/concrete_volumetric_weight.dart';
import 'package:masa_epico_concrete_manager/service/concrete_testing_order_dao.dart';
import 'package:masa_epico_concrete_manager/service/concrete_volumetric_weight_dao.dart';
import 'package:masa_epico_concrete_manager/utils/component_utils.dart';
import 'package:masa_epico_concrete_manager/utils/sequential_counter_generator.dart';

import '../constants/constants.dart';
import '../elements/autocomplete.dart';
import '../models/concrete_testing_order.dart';

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
  ConcreteTestingOrderDao concreteTestingOrderDao = ConcreteTestingOrderDao();
  ConcreteVolumetricWeightDao concreteVolumetricWeightDao =
      ConcreteVolumetricWeightDao();

  List<ConcreteTestingOrder> concreteTestingOrders = [];
  List<String> selectableConcreteTestingOrders = [];
  int concreteTestingOrderId = 0;
  ConcreteTestingOrder? selectedConcreteTestingOrder;

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
  final TextEditingController _retardantAdditiveController =
      TextEditingController();
  final TextEditingController _otherAdditiveController =
      TextEditingController();
  final TextEditingController _totalLoadController = TextEditingController();

  final TextEditingController _totalLoadVolumetricWeightController =
      TextEditingController();
  final TextEditingController _percentageController = TextEditingController();
  final TextEditingController _commentsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadConcreteTestingOrders();
    concreteTestingOrderId = widget.concreteTestingOrderId;
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
                if (concreteTestingOrderId == 0)
                  AutoCompleteElement(
                    fieldName: "Orden de muestreo",
                    options: selectableConcreteTestingOrders,
                    onChanged: (p0) => setSelectedConcreteTestingOrder(p0),
                    controller: _concreteTestingOrderController,
                  ),
                if (concreteTestingOrderId != 0)
                  CustomTextFormField(
                      controller: _concreteTestingOrderController,
                      labelText: "Orden de muestreo",
                      readOnly: true,
                      validatorText: ""),
                const SizedBox(height: 20),
                QuantityFormField(
                  labelText: "Peso de la tara (gr)",
                  controller: _tareWeightController,
                  readOnly: true,
                ),
                const SizedBox(height: 20),
                QuantityFormField(
                  labelText: "Peso del material + tara (gr)",
                  controller: _materialTareWeightController,
                  onChanged: (p0) => updateMaterialWeight(p0!),
                ),
                const SizedBox(height: 20),
                QuantityFormField(
                  labelText: "Peso del material",
                  controller: _materialWeightController,
                  readOnly: true,
                ),
                const SizedBox(height: 20),
                QuantityFormField(
                  labelText: "Volumen de la tara",
                  controller: _tareVolumeController,
                  readOnly: true,
                ),
                const SizedBox(height: 20),
                QuantityFormField(
                  labelText: "Peso volumetrico",
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
                QuantityFormField(
                  labelText: "Aditivo retardante (lt)",
                  controller: _retardantAdditiveController,
                  onChanged: (p0) => updateTotalLoad(),
                ),
                const SizedBox(height: 20),
                QuantityFormField(
                  labelText: "Aditivo 383 (lt)",
                  controller: _otherAdditiveController,
                  onChanged: (p0) => updateTotalLoad(),
                ),
                const SizedBox(height: 20),
                QuantityFormField(
                  labelText: "Carga total",
                  controller: _totalLoadController,
                  onChanged: (p0) => updateTotalLoad(),
                ),
                const SizedBox(height: 20),
                const Divider(thickness: 2.0),
                const SizedBox(height: 20),
                QuantityFormField(
                  labelText: "Relación carga total y peso volumetrico",
                  controller: _totalLoadVolumetricWeightController,
                  onChanged: (p0) => updateTotalLoad(),
                ),
                const SizedBox(height: 20),
                QuantityFormField(
                  labelText: "Porcentaje",
                  controller: _percentageController,
                  onChanged: (p0) => updateTotalLoad(),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      addConcreteVolumetricWeight();
                    }
                  },
                  child: const Text("Registrar peso volumetrico"),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void loadConcreteTestingOrders() {
    concreteTestingOrderDao
        .findAll()
        .then((value) => concreteTestingOrders = value)
        .then((value) {
      setState(() {
        selectableConcreteTestingOrders =
            value.map((e) => formatConcreteTestingOrder(e)).toList();
        if (concreteTestingOrderId != 0) {
          selectedConcreteTestingOrder = concreteTestingOrders
              .firstWhere((element) => element.id == concreteTestingOrderId);
          setState(() {
            _concreteTestingOrderController.text =
                formatConcreteTestingOrder(selectedConcreteTestingOrder!);
          });
        }
      });
    });
  }

  String formatConcreteTestingOrder(ConcreteTestingOrder e) {
    return "${SequentialIdGenerator.generatePadLeftNumber(e.id!)} - ${e.customer.identifier} : ${e.projectSite.siteName} - (${e.testingDate?.day}/${e.testingDate?.month}/${e.testingDate?.year})";
  }

  void setSelectedConcreteTestingOrder(String selected) {
    selectedConcreteTestingOrder = concreteTestingOrders.firstWhere((element) => element.id == SequentialIdGenerator.getIdNumberFromConsecutive(selected));
  }

  void updateMaterialWeight(String value) {
    int? weightMaterialPlusTare = int.tryParse(value);
    int? weightMaterial = weightMaterialPlusTare! - Constants.TARE_WEIGHT;
    num volumeMaterial = Constants.TARE_VOLUME;
    volumetricWeight = (weightMaterial / volumeMaterial).floor();
    setState(() {
      _materialWeightController.text = weightMaterial.toString();
      _volumetricWeightController.text = volumetricWeight.toString();
    });
  }

  void updateTotalLoad() {
    num cementQuantity = num.tryParse(_cementController.text) ?? 0.0;
    num coarseAggregateQuantity =
        num.tryParse(_coarseAggregateController.text) ?? 0.0;
    num fineAggregateQuantity =
        num.tryParse(_fineAggregateController.text) ?? 0.0;
    num waterQuantity = num.tryParse(_waterController.text) ?? 0.0;
    num retardantAdditiveQuantity =
        num.tryParse(_retardantAdditiveController.text) ?? 0.0;
    num otherAdditiveQuantity =
        num.tryParse(_otherAdditiveController.text) ?? 0.0;

    totalLoad = cementQuantity +
        coarseAggregateQuantity +
        fineAggregateQuantity +
        waterQuantity +
        retardantAdditiveQuantity +
        otherAdditiveQuantity;

    totalLoadVolumetricWeightRelation = totalLoad / volumetricWeight;
    percentage = (totalLoadVolumetricWeightRelation / 7.0) * 100;

    setState(() {
      _totalLoadController.text = totalLoad.floor().toString();
      _totalLoadVolumetricWeightController.text =
          totalLoadVolumetricWeightRelation.toStringAsFixed(2).toString();
      _percentageController.text = percentage.toStringAsFixed(2).toString();
    });
  }

  void addConcreteVolumetricWeight() {
    num? tareWeight = num.tryParse(_tareWeightController.text);
    num? materialTareWeight = num.tryParse(_materialTareWeightController.text);
    num? materialWeight = num.tryParse(_materialWeightController.text);
    num? tareVolume = num.tryParse(_tareVolumeController.text);
    num? volumeLoad = selectedConcreteTestingOrder?.volume;
    num? cementQuantity = num.tryParse(_cementController.text);
    num? coarseAggregateQuantity =
        num.tryParse(_coarseAggregateController.text);
    num? fineAggregateQuantity = num.tryParse(_fineAggregateController.text);
    num? waterQuantity = num.tryParse(_waterController.text);
    num? retardantAdditiveQuantity =
        num.tryParse(_retardantAdditiveController.text);
    num? otherAdditiveQuantity = num.tryParse(_otherAdditiveController.text);

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
            retardantAdditiveQuantity,
            otherAdditiveQuantity,
            totalLoad,
            totalLoadVolumetricWeightRelation,
            percentage);

    // ADD THE CONCRETE VOLUMETRIC WEIGHT
    concreteVolumetricWeightDao
        .addConcreteVolumetricWeight(concreteVolumetricWeight)
        .then((value) {
      selectedConcreteTestingOrder?.concreteVolumetricWeight = value;
      // UPDATE THE CONCRETE TESTING ORDER

      concreteTestingOrderDao
          .updateConcreteTestingDao(selectedConcreteTestingOrder!)
          .then((value) {
        ComponentUtils.generateSuccessMessage(
            context, "Peso volumetrico registrado con exito");
      }).onError((error, stackTrace) {
        ComponentUtils.generateErrorMessage(context);
      });
    });
  }
}
