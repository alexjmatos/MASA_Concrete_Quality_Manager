import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:masa_epico_concrete_manager/dto/form/customer_form_dto.dart';
import 'package:masa_epico_concrete_manager/elements/custom_text_form_field.dart';
import 'package:masa_epico_concrete_manager/elements/elevated_button_dialog.dart';
import 'package:masa_epico_concrete_manager/models/customer.dart';
import 'package:masa_epico_concrete_manager/service/customer_dao.dart';
import 'package:masa_epico_concrete_manager/utils/component_utils.dart';
import 'package:masa_epico_concrete_manager/utils/pdf_utils.dart';
import 'package:masa_epico_concrete_manager/utils/sequential_counter_generator.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class CustomerForm extends StatefulWidget {
  const CustomerForm({super.key});

  @override
  State<CustomerForm> createState() => _CustomerFormState();
}

class _CustomerFormState extends State<CustomerForm> {
  final _formKey = GlobalKey<FormState>();

  final CustomerDAO customerDao = CustomerDAO();

  // Data for General Customer Info
  late final CustomerFormDTO customerFormDTO;
  PdfUtils pdfUtils = PdfUtils();
  File? _pdfFile;

  @override
  void initState() {
    super.initState();
    customerFormDTO = CustomerFormDTO(
        identifierController: TextEditingController(),
        companyNameController: TextEditingController());
    _generatePdfAndSave();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text(
          'Datos del cliente',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _generatePdfAndSave, // Regenerate and reload the PDF
          ),
        ],
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
                  controller: customerFormDTO.identifierController,
                  labelText: "Nombre o Razón Social",
                  validatorText:
                      "El nombre o razon social del cliente no puede quedar vacio",
                ),
                const SizedBox(height: 20),
                CustomTextFormField.withValidator(
                  controller: customerFormDTO.companyNameController,
                  labelText: "RFC (Opcional)",
                  validatorText: "El RFC debe tener 10 caracteres",
                  validator: (p0) {
                    if (p0!.isNotEmpty && p0.length != 10) {
                      return "El RFC debe tener 10 caracteres";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),
                Center(
                  child: ElevatedButtonDialog(
                    title: "Agregar cliente",
                    description: "Presiona OK para realizar la operacion",
                    onOkPressed: () {
                      if (_formKey.currentState!.validate()) {
                        addCustomer();
                        // _openPdf();
                        Navigator.pop(context);
                        _formKey.currentState!.reset();
                      } else {
                        Navigator.pop(context, 'Cancel');
                      }
                    },
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void addCustomer() {
    // Minimal implementation - manager and location empty
    Customer customer = Customer(
      identifier: customerFormDTO.getIdentifier(),
      companyName: customerFormDTO.getCompanyName(),
    );

    Future<Customer> future = customerDao.add(customer);

    future.then((value) {
      ComponentUtils.generateSuccessMessage(context,
          "Cliente ${SequentialFormatter.generatePadLeftNumber(value.id!)} - ${value.identifier} agregado con exito");
    }).onError((error, stackTrace) {
      ComponentUtils.generateErrorMessage(context);
    });
  }

  Future<void> _generatePdfAndSave() async {
    // Generate the PDF document
    Uint8List pdfData = await pdfUtils.buildPdf(PdfPageFormat.a4.landscape);

    // Save the PDF document to a temporary file
    final output = await getTemporaryDirectory();
    final file = File("${output.path}/example.pdf");
    await file.writeAsBytes(pdfData);

    setState(() {
      _pdfFile = file;
    });
  }

  void _openPdf() {
    if (_pdfFile != null) {
      OpenFile.open(_pdfFile!.path);
    }
  }
}
