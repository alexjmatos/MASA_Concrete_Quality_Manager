import 'package:flutter/material.dart';
import 'package:masa_epico_concrete_manager/elements/autocomplete.dart';
import 'package:masa_epico_concrete_manager/models/customer.dart';
import 'package:masa_epico_concrete_manager/models/project_site.dart';
import 'package:masa_epico_concrete_manager/service/customer_dao.dart';
import 'package:masa_epico_concrete_manager/service/project_site_dao.dart';

class ConcreteQualityForm extends StatefulWidget {
  const ConcreteQualityForm({super.key});

  @override
  State<ConcreteQualityForm> createState() => _ConcreteQualityFormState();
}

class _ConcreteQualityFormState extends State<ConcreteQualityForm> {
  final _formKey = GlobalKey<FormState>();
  final CustomerDao customerDao = CustomerDao();
  final ProjectSiteDao projectSiteDao = ProjectSiteDao();

  static List<Customer> customers = [];
  static List<String> availableCustomers = [];

  static List<ProjectSite> projectSites = [];
  static List<String> availableProjectSites = [];

  String _selectedCustomer = '';
  String _selectedProjectSite = '';

  @override
  void initState() {
    super.initState();
    _getDataFromBackend();
  }

  void _getDataFromBackend() async {
    customers = await customerDao.getAllCustomers();
    setState(() {
      availableCustomers =
          customers.map((e) => "${e.companyName} - ${e.identifier}").toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Crear orden de muestreo',
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
                AutoCompleteElement(
                  fieldName: "Cliente",
                  options: availableCustomers,
                  onChanged: (p0) =>
                      setSelectedCustomerAndUpdateProjectSites(p0),
                ),
                const SizedBox(height: 20),
                AutoCompleteElement(
                  fieldName: "Obra",
                  options: availableProjectSites,
                  onChanged: (p0) =>
                      setSelectedProjectSiteAndUpdateLocationSiteResident(p0),
                ),
                const SizedBox(height: 20),
                const TextField(
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: "Dirección",
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 20),
                const TextField(
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: "Residente de obra",
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  setSelectedCustomerAndUpdateProjectSites(String selected) {
    // RETRIEVE CUSTOMER
    Customer? found = customers.firstWhere(
        (element) =>
            "${element.companyName} - ${element.identifier}" ==
            selected,
        orElse: () => Customer.emptyModel());

    // UPDATE THE LIST OF PROJECT SITES RELATED TO THE GIVEN CUSTOMER
    if (found.id != null) {
      // SET THE SELECTED CUSTOMER IN THE UI
      _selectedCustomer = selected;
      setState(() {
        projectSites = found.projects;
        availableProjectSites = projectSites.map((e) => e.siteName).toList();
      });
    }
  }

  setSelectedProjectSiteAndUpdateLocationSiteResident(String selected) {
  }
}
