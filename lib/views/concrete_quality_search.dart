import 'package:flutter/material.dart';
import 'package:masa_epico_concrete_manager/data/project_site_data_source.dart';
import 'package:masa_epico_concrete_manager/data/project_site_data_table.dart';
import 'package:masa_epico_concrete_manager/data/site_resident_data_source.dart';
import 'package:masa_epico_concrete_manager/data/site_resident_data_table.dart';
import 'package:masa_epico_concrete_manager/data/testing_order_data_source.dart';
import 'package:masa_epico_concrete_manager/data/testing_order_data_table.dart';
import 'package:masa_epico_concrete_manager/elements/custom_dropdown_form_field.dart';
import 'package:masa_epico_concrete_manager/service/concrete_testing_order_dao.dart';
import 'package:masa_epico_concrete_manager/service/customer_dao.dart';
import 'package:masa_epico_concrete_manager/service/project_site_dao.dart';
import 'package:masa_epico_concrete_manager/service/site_resident_dao.dart';

import '../data/customer_data_source.dart';
import '../data/customer_data_table.dart';

class ConcreteQualitySearch extends StatefulWidget {
  const ConcreteQualitySearch({super.key});

  @override
  State<ConcreteQualitySearch> createState() => _ConcreteQualitySearchState();
}

class _ConcreteQualitySearchState extends State<ConcreteQualitySearch> {
  Entity _selected = Entity.Clientes;
  CustomerDao customerDao = CustomerDao();
  ProjectSiteDao projectSiteDao = ProjectSiteDao();
  SiteResidentDao siteResidentDao = SiteResidentDao();
  ConcreteTestingOrderDao concreteTestingOrderDao = ConcreteTestingOrderDao();
  late CustomerData customerData;
  late ProjectSiteData projectSiteData;
  late SiteResidentData siteResidentData;
  late ConcreteTestingOrderData concreteTestingOrderData;

  @override
  void initState() {
    super.initState();
    customerData = CustomerData(customers: []);
    projectSiteData = ProjectSiteData(projectSites: []);

    customerDao.getAllCustomers().then(
      (value) {
        setState(
          () {
            customerData = CustomerData(customers: value);
          },
        );
      },
    );

    projectSiteDao.findAll().then(
      (value) {
        setState(
          () {
            projectSiteData = ProjectSiteData(projectSites: value);
          },
        );
      },
    );

    siteResidentDao.findAll().then(
      (value) {
        setState(() {
          siteResidentData = SiteResidentData(siteResidents: value);
        });
      },
    );

    concreteTestingOrderDao.findAll().then(
      (value) {
        setState(() {
          concreteTestingOrderData =
              ConcreteTestingOrderData(concreteTestingOrders: value);
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CustomDropdownFormField(
                labelText: "Registro",
                items: Entity.values.asNameMap().keys.toList(),
                onChanged: (p0) {
                  setState(() {
                    _selected = Entity.values.byName(p0);
                  });
                },
              ),
              const SizedBox(
                height: 20,
              ),
              if (_selected == Entity.Clientes)
                generateCustomerDataTable()
              else if (_selected == Entity.Obras)
                generateProjectSiteDataTable()
              else if (_selected == Entity.Residentes)
                generateSiteResidentDataTable()
              else if (_selected == Entity.Muestras)
                generateConcreteTestingDataTable()
            ],
          ),
        ),
      ),
    );
  }

  CustomerDataTable generateCustomerDataTable() {
    return CustomerDataTable(
      customerData: customerData,
    );
  }

  ProjectSiteDataTable generateProjectSiteDataTable() {
    return ProjectSiteDataTable(
      projectSiteData: projectSiteData,
    );
  }

  SiteResidentDataTable generateSiteResidentDataTable() {
    return SiteResidentDataTable(
      siteResidentData: siteResidentData,
    );
  }

  ConcreteTestingDataTable generateConcreteTestingDataTable() {
    return ConcreteTestingDataTable(
        concreteTestingOrderData: concreteTestingOrderData);
  }
}

enum Entity {
  Clientes,
  Obras,
  Residentes,
  Muestras;
}
