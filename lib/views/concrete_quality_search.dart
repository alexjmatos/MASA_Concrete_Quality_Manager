import 'package:flutter/material.dart';
import 'package:masa_epico_concrete_manager/data/source/project_site_data_source.dart';
import 'package:masa_epico_concrete_manager/data/table/project_site_data_table.dart';
import 'package:masa_epico_concrete_manager/data/source/site_resident_data_source.dart';
import 'package:masa_epico_concrete_manager/data/table/site_resident_data_table.dart';
import 'package:masa_epico_concrete_manager/data/source/testing_order_data_source.dart';
import 'package:masa_epico_concrete_manager/data/table/testing_order_data_table.dart';
import 'package:masa_epico_concrete_manager/elements/custom_dropdown_form_field.dart';
import 'package:masa_epico_concrete_manager/models/concrete_testing_order.dart';
import 'package:masa_epico_concrete_manager/models/project_site.dart';
import 'package:masa_epico_concrete_manager/models/site_resident.dart';
import 'package:masa_epico_concrete_manager/service/concrete_testing_order_dao.dart';
import 'package:masa_epico_concrete_manager/service/customer_dao.dart';
import 'package:masa_epico_concrete_manager/service/project_site_dao.dart';
import 'package:masa_epico_concrete_manager/service/site_resident_dao.dart';

import '../data/source/customer_data_source.dart';
import '../data/table/customer_data_table.dart';
import '../models/customer.dart';

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

  final ValueNotifier<List<Customer>> _customersNotifier =
      ValueNotifier<List<Customer>>([]);
  final ValueNotifier<List<ProjectSite>> _projectSitesNotifier =
      ValueNotifier<List<ProjectSite>>([]);
  final ValueNotifier<List<SiteResident>> _siteResidentsNotifier =
      ValueNotifier<List<SiteResident>>([]);
  final ValueNotifier<List<ConcreteTestingOrder>>
      _concreteTestingOrderNotifier =
      ValueNotifier<List<ConcreteTestingOrder>>([]);

  @override
  void initState() {
    super.initState();
    _loadDataTables();
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
      customersNotifier: _customersNotifier,
    );
  }

  ProjectSiteDataTable generateProjectSiteDataTable() {
    return ProjectSiteDataTable(
      projectSitesNotifier: _projectSitesNotifier,
    );
  }

  SiteResidentDataTable generateSiteResidentDataTable() {
    return SiteResidentDataTable(
      siteResidentNotifier: _siteResidentsNotifier,
    );
  }

  ConcreteTestingDataTable generateConcreteTestingDataTable() {
    return ConcreteTestingDataTable(
      concreteTestingOrdersNotifier: _concreteTestingOrderNotifier,
    );
  }

  void _loadDataTables() {
    customerDao.getAllCustomers().then(
      (value) {
        setState(
          () {
            _customersNotifier.value = value;
          },
        );
      },
    );

    projectSiteDao.findAll().then(
      (value) {
        setState(
          () {
            _projectSitesNotifier.value = value;
          },
        );
      },
    );

    siteResidentDao.findAll().then(
      (value) {
        setState(() {
          _siteResidentsNotifier.value = value;
        });
      },
    );

    concreteTestingOrderDao.findAll().then(
      (value) {
        setState(() {
          _concreteTestingOrderNotifier.value = value;
        });
      },
    );
  }
}

enum Entity {
  Clientes,
  Obras,
  Residentes,
  Muestras;
}
