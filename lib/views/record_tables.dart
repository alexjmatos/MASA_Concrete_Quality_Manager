import 'package:flutter/material.dart';
import 'package:masa_epico_concrete_manager/data/table/building_site_data_table.dart';
import 'package:masa_epico_concrete_manager/data/table/site_resident_data_table.dart';
import 'package:masa_epico_concrete_manager/elements/custom_select_dropdown.dart';
import 'package:masa_epico_concrete_manager/elements/value_notifier_list.dart';
import 'package:masa_epico_concrete_manager/models/concrete_testing_order.dart';
import 'package:masa_epico_concrete_manager/models/building_site.dart';
import 'package:masa_epico_concrete_manager/models/site_resident.dart';
import 'package:masa_epico_concrete_manager/service/concrete_testing_order_dao.dart';
import 'package:masa_epico_concrete_manager/service/customer_dao.dart';
import 'package:masa_epico_concrete_manager/service/building_site_dao.dart';
import 'package:masa_epico_concrete_manager/service/site_resident_dao.dart';
import 'package:masa_epico_concrete_manager/views/search/concrete_testing_sample_search.dart';

import '../data/table/customer_data_table.dart';
import '../data/table/testing_order_data_table.dart';
import '../models/customer.dart';

class ConcreteQualitySearch extends StatefulWidget {
  const ConcreteQualitySearch({super.key});

  @override
  State<ConcreteQualitySearch> createState() => _ConcreteQualitySearchState();
}

class _ConcreteQualitySearchState extends State<ConcreteQualitySearch> {
  late Entity selected; // Default selected entity
  CustomerDAO customerDao = CustomerDAO(); // DAO for customers
  BuildingSiteDAO projectSiteDao = BuildingSiteDAO(); // DAO for project sites
  SiteResidentDAO siteResidentDao = SiteResidentDAO(); // DAO for site residents
  ConcreteTestingOrderDAO concreteTestingOrderDao =
      ConcreteTestingOrderDAO(); // DAO for concrete testing orders

  final TextEditingController selectController = TextEditingController();

  final ValueNotifierList<Customer> _customersNotifier =
      ValueNotifierList([]); // Notifier for customers
  final ValueNotifierList<BuildingSite> _buildingSitesNotifier =
      ValueNotifierList([]); // Notifier for project sites
  final ValueNotifierList<SiteResident> _siteResidentsNotifier =
      ValueNotifierList([]); // Notifier for site residents
  final ValueNotifierList<ConcreteTestingOrder> _concreteTestingOrderNotifier =
      ValueNotifierList([]); // Notifier for concrete testing orders

  @override
  void initState() {
    super.initState();
    _loadDataTables(); // Load data when the widget is initialized
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              CustomSelectDropdown(
                labelText: "Registro",
                items: Entity.values
                    .asNameMap()
                    .values
                    .map((e) => e.value)
                    .toList(),
                onChanged: (p0) {
                  setState(
                    () {
                      selected = Entity.values
                          .asNameMap()
                          .values
                          .firstWhere((element) => element.value == p0);
                    },
                  );
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: _buildDataTable(),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDataTable() {
    switch (selected) {
      case Entity.customers:
        return generateCustomerDataTable();
      case Entity.sites:
        return generateProjectSiteDataTable();
      case Entity.residents:
        return generateSiteResidentDataTable();
      case Entity.orders:
        return generateConcreteTestingDataTable();
      default:
        return Container(); // Return an empty container for an undefined entity
    }
  }

  // Helper method to generate Customer Data Table
  CustomerDataTable generateCustomerDataTable() {
    return CustomerDataTable(
      customersNotifier: _customersNotifier,
    );
  }

  // Helper method to generate Project Site Data Table
  ProjectSiteDataTable generateProjectSiteDataTable() {
    return ProjectSiteDataTable(
      projectSitesNotifier: _buildingSitesNotifier,
    );
  }

  // Helper method to generate Site Resident Data Table
  SiteResidentDataTable generateSiteResidentDataTable() {
    return SiteResidentDataTable(
      siteResidentNotifier: _siteResidentsNotifier,
    );
  }

  // Helper method to generate Concrete Testing Data Table
  ConcreteTestingDataTable generateConcreteTestingDataTable() {
    return ConcreteTestingDataTable(
      concreteTestingOrdersNotifier: _concreteTestingOrderNotifier,
    );
  }

  ConcreteTestingSampleSearch generateConcreteTestingRemissionSearchView() {
    return const ConcreteTestingSampleSearch();
  }

  // Method to load data for all tables
  Future<void> _loadDataTables() async {
    selected = Entity.values.first;

    await customerDao.findAll().then(
      (value) {
        _customersNotifier.set(value); // Update customers notifier
      },
    );

    await projectSiteDao.findAll().then(
      (value) {
        _buildingSitesNotifier.set(value);
      },
    );

    await siteResidentDao.findAll().then(
      (value) {
        _siteResidentsNotifier.set(value);
      },
    );

    await concreteTestingOrderDao.findAll().then(
      (value) {
        _concreteTestingOrderNotifier.set(value);
      },
    );
  }
}

// Enum to define different entities
enum Entity {
  orders("Ordenes de muestreo"),
  sites("Obras"),
  customers("Clientes"),
  residents("Residentes de obra");

  final String value;

  const Entity(this.value);

  String getValue() {
    return value;
  }
}
