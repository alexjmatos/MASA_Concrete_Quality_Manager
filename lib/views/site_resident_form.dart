import 'package:flutter/material.dart';
import 'package:masa_epico_concrete_manager/dto/form/site_resident_form_dto.dart';
import 'package:masa_epico_concrete_manager/elements/custom_text_form_field.dart';
import 'package:masa_epico_concrete_manager/elements/elevated_button_dialog.dart';

class SiteResidentForm extends StatefulWidget {
  const SiteResidentForm({super.key});

  @override
  State<SiteResidentForm> createState() => _SiteResidentFormState();
}

class _SiteResidentFormState extends State<SiteResidentForm> {
  final _formKey = GlobalKey<FormState>();
  late final SiteResidentFormDTO siteResidentFormDTO;

  @override
  void initState() {
    super.initState();
    siteResidentFormDTO = SiteResidentFormDTO(
        firstNameController: TextEditingController(),
        lastNameController: TextEditingController(),
        jobPositionController: TextEditingController());
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
                  controller: siteResidentFormDTO.firstNameController,
                  labelText: "Nombre",
                  validatorText: 'El campo nombre no puede quedar vacio',
                ),
                const SizedBox(height: 20),
                CustomTextFormField.withValidator(
                  controller: siteResidentFormDTO.lastNameController,
                  labelText: "Apellidos",
                  validatorText: 'El campo apellido no puede quedar vacio',
                ),
                const SizedBox(height: 20),
                CustomTextFormField.noValidation(
                  controller: siteResidentFormDTO.jobPositionController,
                  labelText: "Puesto",
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButtonDialog(
                    title: "Agregar residente de obra",
                    description: "Presiona OK para realizar la operacion",
                    onOkPressed: () {
                      if (_formKey.currentState!.validate()) {
                        siteResidentFormDTO.addSiteResident(context);
                        Navigator.pop(context);
                        _formKey.currentState!.reset();
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
}
