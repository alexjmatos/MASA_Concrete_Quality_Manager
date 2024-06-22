import 'package:flutter/material.dart';
import 'package:masa_epico_concrete_manager/constants/constants.dart';
import 'package:masa_epico_concrete_manager/data/source/remission_data_source.dart';
import 'package:masa_epico_concrete_manager/data/table/remission_data_table.dart';
import 'package:masa_epico_concrete_manager/elements/autocomplete.dart';
import 'package:masa_epico_concrete_manager/elements/custom_radio_button.dart';
import 'package:masa_epico_concrete_manager/elements/custom_select_dropdown.dart';
import 'package:masa_epico_concrete_manager/service/concrete_testing_remission_dao.dart';

import '../elements/value_notifier_list.dart';
import '../models/concrete_testing_remission.dart';

class ConcreteRemissionForm extends StatefulWidget {
  const ConcreteRemissionForm({super.key});

  @override
  State<ConcreteRemissionForm> createState() => _ConcreteRemissionFormState();
}

class _ConcreteRemissionFormState extends State<ConcreteRemissionForm> {
  final ValueNotifierList<ConcreteTestingRemission>
      concreteTestingRemissionNotifier = ValueNotifierList([]);
  final ConcreteTestingRemissionDao concreteTestingRemissionDao =
      ConcreteTestingRemissionDao();
  final TextEditingController _buildingSiteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadConcreteRemissionDataTable();
  }

  void _loadConcreteRemissionDataTable() {
    concreteTestingRemissionDao.findAll().then(
      (value) {
        concreteTestingRemissionNotifier.value = value;
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
              Row(
                children: [
                  Expanded(
                    child: AutoCompleteElement(
                        options: const ["Option 1"],
                        onChanged: (p0) {},
                        controller: _buildingSiteController,
                        fieldName: "Obra"),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: CustomSelectDropdown(
                      items: Constants.CONCRETE_COMPRESSION_RESISTANCES,
                      labelText: "Resistencia de diseño (F'C)",
                      onChanged: (value) {},
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: CustomSelectDropdown(
                      items: Constants.CONCRETE_DESIGN_AGES,
                      labelText: "Edad de diseño (días)",
                      onChanged: (value) {},
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              CustomRadioButton(
                options: const [
                  "Más reciente",
                  "Más antiguo",
                  "Por identificador (ID)"
                ],
                onChanged: (value) {},
              ),
              Row(
                children: [
                  Expanded(
                    child: ConcreteRemissionDataTable(
                        concreteTestingRemissionNotifier:
                            concreteTestingRemissionNotifier),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
