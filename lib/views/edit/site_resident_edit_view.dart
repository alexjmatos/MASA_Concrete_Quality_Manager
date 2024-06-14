import 'package:flutter/material.dart';
import 'package:masa_epico_concrete_manager/elements/custom_text_form_field.dart';
import 'package:masa_epico_concrete_manager/elements/elevated_button_dialog.dart';
import 'package:masa_epico_concrete_manager/models/site_resident.dart';
import 'package:masa_epico_concrete_manager/service/site_resident_dao.dart';
import 'package:masa_epico_concrete_manager/utils/component_utils.dart';
import 'package:masa_epico_concrete_manager/utils/sequential_counter_generator.dart';

class SiteResidentDetails extends StatefulWidget {
  final int id;
  final bool readOnly;
  final ValueNotifier<List<SiteResident>> siteResidentNotifier;

  const SiteResidentDetails(
      {super.key,
      required this.id,
      required this.readOnly,
      required this.siteResidentNotifier});

  @override
  State<SiteResidentDetails> createState() => _SiteResidentDetailsState();
}

class _SiteResidentDetailsState extends State<SiteResidentDetails> {
  final _formKey = GlobalKey<FormState>();

  final SiteResidentDao siteResidentDao = SiteResidentDao();

  // Data for Site Resident
  final TextEditingController _nombresController = TextEditingController();
  final TextEditingController _apellidosController = TextEditingController();
  final TextEditingController _puestoController = TextEditingController();

  late SiteResident selectedSiteResident;

  @override
  void initState() {
    super.initState();
    siteResidentDao.findById(widget.id).then(
      (value) {
        selectedSiteResident = value;
        setState(
          () {
            _nombresController.text = value.firstName;
            _apellidosController.text = value.lastName;
            _puestoController.text = value.jobPosition;
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text(
          'Datos del residente',
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
                CustomTextFormField.withValidator(
                  controller: _nombresController,
                  labelText: "Nombre",
                  validatorText: 'El campo nombre no puede quedar vacio',
                ),
                const SizedBox(height: 20),
                CustomTextFormField.withValidator(
                  controller: _apellidosController,
                  labelText: "Apellidos",
                  validatorText: 'El campo apellido no puede quedar vacio',
                ),
                const SizedBox(height: 20),
                CustomTextFormField.noValidation(
                  controller: _puestoController,
                  labelText: "Puesto",
                ),
                const SizedBox(height: 20),
                if (!widget.readOnly)
                  ElevatedButtonDialog(
                    title: "Editar residente de obra",
                    description: "Presiona OK para realizar la operacion",
                    onOkPressed: () {
                      if (_formKey.currentState!.validate()) {
                        editSiteResident();
                        siteResidentDao.findAll().then(
                              (value) =>
                                  widget.siteResidentNotifier.value = value,
                            );
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

  Future<void> editSiteResident() async {
    String nombreResidente = _nombresController.text.trim();
    String apellidosResidente = _apellidosController.text.trim();
    String puestoResidente = _puestoController.text.trim();

    selectedSiteResident.firstName = nombreResidente;
    selectedSiteResident.lastName = apellidosResidente;
    selectedSiteResident.jobPosition = puestoResidente;

    var future = siteResidentDao.update(selectedSiteResident);
    future.then((value) {
      ComponentUtils.generateSuccessMessage(context,
          "Residente ${SequentialFormatter.generatePadLeftNumber(value.id!)} - ${value.firstName} - ${value.lastName} actualizado con exito");
    }).onError((error, stackTrace) {
      ComponentUtils.generateErrorMessage(context);
    });
  }

  void updateSiteResidentInfo() {
    _nombresController.text = selectedSiteResident.firstName.trim();
    _apellidosController.text = selectedSiteResident.lastName.trim();
    _puestoController.text = selectedSiteResident.jobPosition.trim();
  }
}
