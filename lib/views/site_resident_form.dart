import 'package:flutter/material.dart';
import 'package:masa_epico_concrete_manager/elements/custom_text_form_field.dart';
import 'package:masa_epico_concrete_manager/elements/elevated_button_dialog.dart';
import 'package:masa_epico_concrete_manager/models/site_resident.dart';
import 'package:masa_epico_concrete_manager/service/site_resident_dao.dart';
import 'package:masa_epico_concrete_manager/utils/component_utils.dart';
import 'package:masa_epico_concrete_manager/utils/sequential_counter_generator.dart';

class SiteResidentForm extends StatefulWidget {
  const SiteResidentForm({super.key});

  @override
  State<SiteResidentForm> createState() => _SiteResidentFormState();
}

class _SiteResidentFormState extends State<SiteResidentForm> {
  final _formKey = GlobalKey<FormState>();

  final SiteResidentDao siteResidentDao = SiteResidentDao();

  // Data for Site Resident
  final TextEditingController _nombresController = TextEditingController();
  final TextEditingController _apellidosController = TextEditingController();
  final TextEditingController _puestoController = TextEditingController();

  SiteResident? _selectedSiteResident;

  @override
  void initState() {
    super.initState();
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
                ElevatedButtonDialog(
                  title: "Agregar residente de obra",
                  description: "Presiona OK para realizar la operacion",
                  onOkPressed: () {
                    if (_formKey.currentState!.validate()) {
                      addSiteResident();
                      Navigator.pop(context);
                      _formKey.currentState!.reset();
                    } else {
                      Navigator.pop(context, 'Cancel');
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> addSiteResident() async {
    String nombreResidente = _nombresController.text.trim();
    String apellidosResidente = _apellidosController.text.trim();
    String puestoResidente = _puestoController.text.trim();

    SiteResident siteResident = SiteResident(
      firstName: nombreResidente,
      lastName: apellidosResidente,
      jobPosition: puestoResidente,
    );
    var future = siteResidentDao.addSiteResident(siteResident);
    future.then((value) {
      ComponentUtils.generateSuccessMessage(context,
          "Residente ${SequentialIdGenerator.generatePadLeftNumber(value.id!)} - ${value.firstName} - ${value.lastName} agregada con exito");
    }).onError((error, stackTrace) {
      ComponentUtils.generateErrorMessage(context);
    });
  }

  void updateSiteResidentInfo() {
    _nombresController.text = _selectedSiteResident!.firstName.trim();
    _apellidosController.text = _selectedSiteResident!.lastName.trim();
    _puestoController.text = _selectedSiteResident!.jobPosition.trim();
  }
}
