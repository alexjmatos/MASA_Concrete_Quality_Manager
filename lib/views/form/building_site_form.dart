import 'package:flutter/material.dart';
import 'package:masa_epico_concrete_manager/dto/form/building_site_form_dto.dart';
import 'package:masa_epico_concrete_manager/elements/autocomplete.dart';
import 'package:masa_epico_concrete_manager/elements/custom_text_form_field.dart';
import 'package:masa_epico_concrete_manager/elements/elevated_button_dialog.dart';
import 'package:masa_epico_concrete_manager/service/customer_dao.dart';
import 'package:masa_epico_concrete_manager/service/building_site_dao.dart';
import 'package:masa_epico_concrete_manager/service/site_resident_dao.dart';

class ProjectSiteAndResidentForm extends StatefulWidget {
  const ProjectSiteAndResidentForm({super.key});

  @override
  State<ProjectSiteAndResidentForm> createState() =>
      _ProjectSiteAndResidentFormState();
}

class _ProjectSiteAndResidentFormState
    extends State<ProjectSiteAndResidentForm> {
  final _formKey = GlobalKey<FormState>();

  // DAOs
  final BuildingSiteDAO buildingSiteDAO = BuildingSiteDAO();
  final CustomerDAO customerDAO = CustomerDAO();
  final SiteResidentDAO siteResidentDAO = SiteResidentDAO();

  // FORM DTOs
  late BuildingSiteFormDTO buildingSiteFormDTO;

  // LIST OF OPTIONS
  List<String> selectionCustomers = [];
  List<String> selectionSiteResidents = [];

  @override
  void initState() {
    super.initState();
    buildingSiteFormDTO = BuildingSiteFormDTO(
        customerController: TextEditingController(),
        siteResidentController: TextEditingController(),
        firstNameController: TextEditingController(),
        lastNameController: TextEditingController(),
        jobPositionController: TextEditingController(),
        siteNameController: TextEditingController(),
        siteResidents: []);
    loadCustomerAndSiteResidentData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text(
          'Datos de la obra y residente',
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
                CustomTextFormField(
                  controller: buildingSiteFormDTO.siteNameController,
                  labelText: "Identificador",
                  validatorText:
                      "El identificador de la obra no puede quedar vacio",
                ),
                const SizedBox(height: 20),
                AutoCompleteElement(
                  fieldName: "Cliente asignado",
                  options: buildingSiteFormDTO.getSelectionCustomers(),
                  onChanged: (p0) =>
                      buildingSiteFormDTO.customerController.text = p0,
                  controller: buildingSiteFormDTO.customerController,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Residente de obra (Opcional)',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Divider(),
                const SizedBox(height: 20),
                AutoCompleteElement(
                  fieldName: "Residentes de obra (Busqueda)",
                  options: buildingSiteFormDTO.getSelectionSiteResidents(),
                  validate: false,
                  onChanged: (p0) {
                    buildingSiteFormDTO.setSiteResident(p0);
                    setState(
                      () {
                        buildingSiteFormDTO.updateSiteResidentInfo();
                      },
                    );
                  },
                  controller: buildingSiteFormDTO.siteResidentController,
                ),
                const SizedBox(height: 20),
                CustomTextFormField.noValidation(
                  controller: buildingSiteFormDTO.firstNameController,
                  labelText: "Nombre",
                  readOnly: true,
                ),
                const SizedBox(height: 20),
                CustomTextFormField.noValidation(
                  controller: buildingSiteFormDTO.lastNameController,
                  labelText: "Apellidos",
                  readOnly: true,
                ),
                const SizedBox(height: 20),
                CustomTextFormField.noValidation(
                  controller: buildingSiteFormDTO.jobPositionController,
                  labelText: "Puesto",
                  readOnly: true,
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButtonDialog(
                    title: "Agregar obra",
                    description: "Presiona OK para realizar la operacion",
                    onOkPressed: () {
                      if (_formKey.currentState!.validate()) {
                        buildingSiteFormDTO.addProjectSite(
                            context, buildingSiteDAO, siteResidentDAO);
                        Navigator.popUntil(
                          context,
                          ModalRoute.withName(Navigator.defaultRouteName),
                        );
                        _formKey.currentState!.reset();
                      } else {
                        Navigator.pop(context, 'Cancel');
                      }
                    },
                    textColor: Colors.white,
                    icon: Icons.save,
                    iconColor: Colors.white,
                    buttonColor: Colors.blue,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void loadCustomerAndSiteResidentData() {
    customerDAO.findAll().then((value) {
      buildingSiteFormDTO.customers = value;
    }).whenComplete(() {
      setState(() {
        selectionCustomers = buildingSiteFormDTO.getSelectionCustomers();
      });
    });

    siteResidentDAO.findAll().then((value) {
      buildingSiteFormDTO.siteResidents = value;
    }).whenComplete(() {
      setState(() {
        selectionSiteResidents =
            buildingSiteFormDTO.getSelectionSiteResidents();
      });
    });
  }
}
