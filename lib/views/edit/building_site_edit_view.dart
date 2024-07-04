import 'package:flutter/material.dart';
import 'package:masa_epico_concrete_manager/database/app_database.dart';
import 'package:masa_epico_concrete_manager/dto/building_site_dto.dart';
import 'package:masa_epico_concrete_manager/dto/customer_dto.dart';
import 'package:masa_epico_concrete_manager/dto/site_resident_dto.dart';
import 'package:masa_epico_concrete_manager/elements/custom_select_dropdown.dart';
import 'package:masa_epico_concrete_manager/elements/custom_text_form_field.dart';
import 'package:masa_epico_concrete_manager/elements/elevated_button_dialog.dart';
import 'package:masa_epico_concrete_manager/service/customer_dao.dart';
import 'package:masa_epico_concrete_manager/service/building_site_dao.dart';
import 'package:masa_epico_concrete_manager/service/site_resident_dao.dart';
import 'package:masa_epico_concrete_manager/utils/component_utils.dart';
import 'package:masa_epico_concrete_manager/utils/sequential_counter_generator.dart';

class BuildingSiteDetails extends StatefulWidget {
  final int id;
  final bool readOnly;
  final ValueNotifier<List<BuildingSiteDTO>> projectSitesNotifier;

  const BuildingSiteDetails(
      {super.key,
      required this.id,
      required this.readOnly,
      required this.projectSitesNotifier});

  @override
  State<BuildingSiteDetails> createState() => _BuildingSiteDetailsState();
}

class _BuildingSiteDetailsState extends State<BuildingSiteDetails> {
  final _formKey = GlobalKey<FormState>();

  final BuildingSiteDAO projectSiteDao = BuildingSiteDAO();
  final CustomerDAO customerDao = CustomerDAO();
  final SiteResidentDAO siteResidentDao = SiteResidentDAO();

  // Data for General Site Project Info
  final TextEditingController _obraController = TextEditingController();
  final TextEditingController _customerController = TextEditingController();
  final TextEditingController _siteResidentController = TextEditingController();

  // Data for Site Resident
  final TextEditingController _nombresController = TextEditingController();
  final TextEditingController _apellidosController = TextEditingController();
  final TextEditingController _puestoController = TextEditingController();

  static List<CustomerDTO> customers = [];
  static List<String> selectionCustomers = [];
  static List<SiteResidentDTO> siteResidents = [];
  static List<String> selectionSiteResidents = [];

  late BuildingSiteDTO selectedBuildingSite;
  SiteResidentDTO? selectedSiteResident;
  CustomerDTO? selectedCustomer;

  int selectedCustomerIndex = -1;
  int selectedSiteResidentIndex = -1;

  @override
  void initState() {
    super.initState();
    loadProjectSiteData();
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
                  controller: _obraController,
                  labelText: "Identificador",
                  readOnly: widget.readOnly,
                  validatorText:
                      "El identificador de la obra no puede quedar vacio",
                ),
                const SizedBox(height: 20),
                if (widget.readOnly)
                  CustomTextFormField.noValidation(
                    controller: _customerController,
                    labelText: "Cliente",
                    readOnly: widget.readOnly,
                  ),
                if (!widget.readOnly)
                  CustomSelectDropdown(
                    labelText: "Cliente",
                    items: selectionCustomers,
                    onChanged: (p0) {
                      selectedCustomer = customers.firstWhere(
                        (element) =>
                            element.id ==
                            SequentialFormatter.getIdNumberFromConsecutive(
                                p0.split("-")[0]),
                      );
                    },
                    defaultValueIndex: selectedCustomerIndex,
                  ),
                const SizedBox(height: 20),
                const Text(
                  'Residente de obra',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Divider(),
                const SizedBox(height: 20),
                if (widget.readOnly)
                  CustomTextFormField.noValidation(
                    controller: _siteResidentController,
                    labelText: "Residente",
                    readOnly: widget.readOnly,
                  ),
                if (!widget.readOnly)
                  CustomSelectDropdown(
                    labelText: "Residentes",
                    items: selectionSiteResidents,
                    onChanged: (p0) {
                      selectedSiteResident = siteResidents.firstWhere(
                        (element) =>
                            element.id ==
                            SequentialFormatter.getIdNumberFromConsecutive(
                                p0.split("-")[0]),
                      );
                    },
                    defaultValueIndex: selectedSiteResidentIndex,
                  ),
                const SizedBox(height: 20),
                if (!widget.readOnly)
                  ElevatedButtonDialog(
                    title: "Modificar obra",
                    description: "Presiona OK para realizar la operacion",
                    onOkPressed: () {
                      if (_formKey.currentState!.validate()) {
                        updateProjectSite();
                        projectSiteDao.findAll().then(
                              (value) =>
                                  widget.projectSitesNotifier.value = value,
                            );
                        Navigator.popUntil(context,
                            ModalRoute.withName(Navigator.defaultRouteName));
                        _formKey.currentState!.reset();
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

  void updateProjectSite() {
    selectedBuildingSite.id = widget.id;
    selectedBuildingSite.siteName = _obraController.text;
    selectedBuildingSite.customer = selectedCustomer;
    selectedBuildingSite.siteResident = selectedSiteResident;

    Future<BuildingSite?> future = projectSiteDao.update(BuildingSite(
        id: selectedBuildingSite.id,
        siteName: selectedBuildingSite.siteName ?? "",
        customerId: selectedBuildingSite.customer!.id!,
        siteResidentId: selectedBuildingSite.siteResident?.id));

    future.then((value) {
      if (value != null) {
        ComponentUtils.generateSuccessMessage(context,
            "Obra ${SequentialFormatter.generatePadLeftNumber(value.id!)} - ${value.siteName} actualizada con exito");
        loadProjectSiteData();
      } else {
        ComponentUtils.generateErrorMessage(context);
      }
    }).onError((error, stackTrace) {
      ComponentUtils.generateErrorMessage(context);
    });
  }

  void updateSiteResidentInfo() {
    _nombresController.text = selectedSiteResident!.firstName!;
    _apellidosController.text = selectedSiteResident!.lastName!;
    _puestoController.text = selectedSiteResident!.jobPosition!;
  }

  Future<void> loadProjectSiteData() async {
    await projectSiteDao.findById(widget.id).then(
      (value) {
        selectedBuildingSite = BuildingSiteDTO(id: value.id);
        selectedCustomer = value.customer;
        selectedSiteResident = value.siteResident;
        selectedSiteResident = selectedBuildingSite.siteResident;
        selectedCustomer = selectedBuildingSite.customer;
        _obraController.text = selectedBuildingSite.siteName!;
      },
    );

    await customerDao.findAll().then((value) {
      customers = value;
    }).then((value) {
      setState(() {
        selectionCustomers = customers
            .map((customer) =>
                SequentialFormatter.generateSequentialFormatFromCustomer(
                    customer))
            .toList();
      });
    });

    await siteResidentDao.findAll().then((value) {
      siteResidents = value;
    }).then(
      (value) {
        setState(
          () {
            selectionSiteResidents = siteResidents
                .map((siteResident) =>
                    "${SequentialFormatter.generatePadLeftNumber(siteResident.id!)} - ${siteResident.lastName} ${siteResident.firstName}")
                .toList();
          },
        );
      },
    );

    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        setState(() {
          selectedCustomerIndex = customers.indexOf(customers.firstWhere(
            (element) => element.id == selectedCustomer?.id!,
          ));

          if (selectedSiteResident != null) {
            selectedSiteResidentIndex =
                siteResidents.indexOf(siteResidents.firstWhere(
              (element) => element.id == selectedSiteResident?.id!,
            ));
            _siteResidentController.text =
                selectionSiteResidents[selectedSiteResidentIndex];
          }
          _customerController.text = selectionCustomers[selectedCustomerIndex];
        });
      },
    );
  }
}
