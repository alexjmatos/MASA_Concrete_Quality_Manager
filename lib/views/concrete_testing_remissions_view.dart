import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masa_epico_concrete_manager/constants/constants.dart';
import 'package:masa_epico_concrete_manager/data/table/remission_data_table.dart';
import 'package:masa_epico_concrete_manager/elements/autocomplete.dart';
import 'package:masa_epico_concrete_manager/elements/custom_icon_button.dart';
import 'package:masa_epico_concrete_manager/elements/custom_select_dropdown.dart';
import 'package:masa_epico_concrete_manager/service/concrete_testing_remission_dao.dart';
import 'package:masa_epico_concrete_manager/service/building_site_dao.dart';
import 'package:masa_epico_concrete_manager/utils/sequential_counter_generator.dart';

import '../elements/value_notifier_list.dart';
import '../models/concrete_testing_remission.dart';
import '../models/building_site.dart';

class ConcreteRemissionForm extends StatefulWidget {
  const ConcreteRemissionForm({super.key});

  @override
  State<ConcreteRemissionForm> createState() => _ConcreteRemissionFormState();
}

class _ConcreteRemissionFormState extends State<ConcreteRemissionForm> {
  final ValueNotifierList<ConcreteTestingRemission>
      concreteTestingRemissionNotifier = ValueNotifierList([]);

  final BuildingSiteDao buildingSiteDao = BuildingSiteDao();
  final ConcreteTestingRemissionDao concreteTestingRemissionDao =
      ConcreteTestingRemissionDao();

  BuildingSite? selectedBuildingSite;
  List<BuildingSite> buildingSites = [];
  List<ConcreteTestingRemission> concreteTestingRemissions = [];
  List<String> selectionBuildingSites = [];

  bool isTablet = true;

  final TextEditingController _buildingSiteController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _loadData() {
    concreteTestingRemissionDao.findAll().then(
      (value) {
        concreteTestingRemissions = value;
        concreteTestingRemissionNotifier.value = value;
      },
    );

    buildingSiteDao.findAll().then(
      (value) {
        buildingSites = value;
        setState(
          () {
            selectionBuildingSites = value
                .map((e) => SequentialFormatter
                    .generateSequentialFormatFromBuildingSite(e))
                .toList();
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Initialize ScreenUtil
    ScreenUtil.init(context);

    // Determine if the device is a tablet
    isTablet = ScreenUtil().screenWidth > 600;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text(
          'Remisiones',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              if (isTablet)
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: AutoCompleteElement(
                          options: selectionBuildingSites,
                          onChanged: (selected) => setBuildingSite(selected),
                          controller: _buildingSiteController,
                          fieldName: "Obra"),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 2,
                      child: CustomSelectDropdown(
                        items: Constants.CONCRETE_COMPRESSION_RESISTANCES,
                        labelText: "Resistencia de diseño (F'C)",
                        onChanged: (selected) =>
                            filterByDesignResistance(selected),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 2,
                      child: CustomSelectDropdown(
                        items: Constants.CONCRETE_DESIGN_AGES,
                        labelText: "Edad de diseño (días)",
                        onChanged: (selected) => filterByDesignAge(selected),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 1,
                      child: CustomIconButton(
                        buttonColor: Colors.grey.shade800,
                        icon: Icons.cleaning_services_rounded,
                        onPressed: () => clearFields(),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 1,
                      child: CustomIconButton(
                        icon: Icons.search,
                        onPressed: () => filter(),
                      ),
                    ),
                  ],
                ),
              if (!isTablet)
                Column(
                  children: [
                    AutoCompleteElement(
                        options: selectionBuildingSites,
                        onChanged: (selected) => setBuildingSite(selected),
                        controller: _buildingSiteController,
                        fieldName: "Obra"),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: CustomSelectDropdown(
                            items: Constants.CONCRETE_COMPRESSION_RESISTANCES,
                            labelText: "Resistencia de diseño (F'C)",
                            onChanged: (selected) =>
                                filterByDesignResistance(selected),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: CustomIconButton(
                            buttonColor: Colors.grey.shade800,
                            icon: Icons.cleaning_services_rounded,
                            onPressed: () => clearFields(),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: CustomSelectDropdown(
                            items: Constants.CONCRETE_DESIGN_AGES,
                            labelText: "Edad de diseño (días)",
                            onChanged: (selected) =>
                                filterByDesignAge(selected),
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: CustomIconButton(
                            icon: Icons.search,
                            onPressed: () => filter(),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ConcreteRemissionDataTable(
                      concreteTestingRemissionNotifier:
                          concreteTestingRemissionNotifier,
                      rowsPerPage: isTablet ? 10 : 7,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void setBuildingSite(String selected) {
    _buildingSiteController.text = selected;
    selectedBuildingSite = buildingSites.firstWhere((element) =>
        element.id == SequentialFormatter.getIdNumberFromConsecutive(selected));
    concreteTestingRemissionNotifier.value = concreteTestingRemissions
        .where((element) =>
            element.concreteTestingOrder.buildingSite.id ==
            selectedBuildingSite?.id)
        .toList();
  }

  void filterByDesignResistance(String selected) {
    concreteTestingRemissionNotifier.value = concreteTestingRemissions
        .where(
          (element) =>
              element.concreteTestingOrder.designResistance?.toUpperCase() ==
              selected,
        )
        .toList();
  }

  void filterByDesignAge(String selected) {
    concreteTestingRemissionNotifier.value = concreteTestingRemissions
        .where(
          (element) =>
              element.concreteTestingOrder.designAge?.toUpperCase() == selected,
        )
        .toList();
  }

  void filter() {}

  void clearFields() {}
}
