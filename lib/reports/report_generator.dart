import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:masa_epico_concrete_manager/models/concrete_testing_order.dart';
import 'package:masa_epico_concrete_manager/utils/sequential_counter_generator.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../constants/constants.dart';
import '../dto/concrete_cylinder.dart';
import '../dto/concrete_sample_dto.dart';
import '../dto/concrete_testing_order_dto.dart';
import '../models/concrete_sample.dart';
import '../utils/utils.dart';

class ReportGenerator {
  Future<pw.ImageProvider> loadImageFromAssets(String path) async {
    final data = await rootBundle.load(path);
    return pw.MemoryImage(data.buffer.asUint8List());
  }

  Future<pw.Document> buildReport(
      PdfPageFormat format, ConcreteTestingOrder concreteTestingOrder) async {
    // Create the Pdf document
    final pw.Document doc = pw.Document();
    final image = await loadImageFromAssets('assets/masacontrol.png');
    final dto = modelToDTO(concreteTestingOrder);

    // Add one page with centered text "Hello World"
    doc.addPage(
      pw.Page(
        pageFormat: format,
        build: (pw.Context context) {
          return pw.Column(
            children: [
              _generateHeaderTable(dto, image, 1),
              pw.SizedBox(height: 12),
              _generateGeneralInfoTable(dto, 3),
              pw.SizedBox(height: 12),
              _generateContentTable(context,
                  samplesToDTO(concreteTestingOrder.concreteSamples), 5),
            ],
          );
        },
      ),
    );
    // Build and return the final Pdf file data
    return doc;
  }

  pw.Widget _generateHeaderTable(
      ConcreteTestingOrderDTO dto, pw.ImageProvider image, int flex) {
    return pw.Row(
      children: [
        pw.Expanded(
          flex: 5,
          child: pw.Column(
            children: [
              pw.Text(
                "VERIFICACION DE CALIDAD DE CONCRETO",
                style: pw.TextStyle(
                    font: pw.Font.timesBold(),
                    fontSize: Constants.TITLE_FONT_SIZE),
              ),
              pw.SizedBox(height: 8),
              pw.Text(
                "MUESTREO Y ENSAYE",
                style: pw.TextStyle(
                    font: pw.Font.timesBold(),
                    fontSize: Constants.TITLE_FONT_SIZE),
              ),
              pw.SizedBox(height: 8),
              pw.Row(
                children: [
                  pw.Expanded(
                    child: pw.Column(
                      children: [
                        pw.Row(children: [
                          pw.Text(
                            "CLIENTE: ",
                            style: pw.TextStyle(
                                font: pw.Font.timesBold(),
                                fontSize: Constants.INFO_FONT_SIZE),
                          ),
                          pw.SizedBox(width: 8),
                          pw.Text(
                            dto.customerIdentifier,
                            style: pw.TextStyle(
                                font: pw.Font.times(),
                                fontSize: Constants.INFO_FONT_SIZE),
                          ),
                        ]),
                        pw.SizedBox(height: 8),
                        pw.Row(children: [
                          pw.Text(
                            "DIRECCION: ",
                            style: pw.TextStyle(
                                font: pw.Font.timesBold(),
                                fontSize: Constants.INFO_FONT_SIZE),
                          ),
                          pw.SizedBox(width: 8),
                          pw.Text(
                            dto.location,
                            style: pw.TextStyle(
                                font: pw.Font.times(),
                                fontSize: Constants.INFO_FONT_SIZE),
                          ),
                        ])
                      ],
                    ),
                  ),
                  pw.Expanded(
                    child: pw.Column(
                      children: [
                        pw.Row(
                          children: [
                            pw.Text(
                              "OBRA: ",
                              style: pw.TextStyle(
                                  font: pw.Font.timesBold(),
                                  fontSize: Constants.INFO_FONT_SIZE),
                            ),
                            pw.SizedBox(width: 8),
                            pw.Text(
                              dto.siteName,
                              style: pw.TextStyle(
                                  font: pw.Font.times(),
                                  fontSize: Constants.INFO_FONT_SIZE),
                            ),
                          ],
                        ),
                        pw.SizedBox(height: 8),
                        pw.Row(
                          children: [
                            pw.Text(
                              "RESIDENTE: ",
                              style: pw.TextStyle(
                                  font: pw.Font.timesBold(),
                                  fontSize: Constants.INFO_FONT_SIZE),
                            ),
                            pw.SizedBox(width: 8),
                            pw.Text(
                              dto.siteResidentName,
                              style: pw.TextStyle(
                                  font: pw.Font.times(),
                                  fontSize: Constants.INFO_FONT_SIZE),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  pw.Expanded(
                    child: pw.Column(
                      children: [
                        pw.Row(children: [
                          pw.Text(
                            "FOLIO: ",
                            style: pw.TextStyle(
                                font: pw.Font.timesBold(),
                                fontSize: Constants.INFO_FONT_SIZE),
                          ),
                          pw.SizedBox(width: 8),
                          pw.Text(
                            "MASA-CONC-${SequentialFormatter.generatePadLeftNumber(dto.id)}",
                            style: pw.TextStyle(
                                font: pw.Font.times(),
                                fontSize: Constants.INFO_FONT_SIZE),
                          ),
                        ])
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ),
        pw.Expanded(
          flex: 1,
          child: pw.Column(
            children: [pw.Image(image)],
          ),
        )
      ],
    );
  }

  pw.Widget _generateGeneralInfoTable(ConcreteTestingOrderDTO dto, int flex) {
    const tableHeaders = [
      "F'C (kg/cm\u00B2)",
      "REV (cm)",
      "VOLUMEN (m\u00B3)",
      "TMA (mm)",
      "EDAD DE DISEÑO (días)",
      "FECHA",
      "PROVEEDOR",
    ];

    return pw.Expanded(
      flex: flex,
      child: pw.TableHelper.fromTextArray(
        columnWidths: {
          0: const pw.FlexColumnWidth(1),
          1: const pw.FlexColumnWidth(1),
          2: const pw.FlexColumnWidth(1),
          3: const pw.FlexColumnWidth(1),
          4: const pw.FlexColumnWidth(1),
          5: const pw.FlexColumnWidth(1),
          6: const pw.FlexColumnWidth(1),
        },
        border: pw.TableBorder.all(color: PdfColors.black, width: 0.5),
        cellAlignment: pw.Alignment.centerLeft,
        headerDecoration: const pw.BoxDecoration(
          color: PdfColors.lightBlue,
        ),
        headerHeight: 25,
        cellHeight: 25,
        cellAlignments: {
          for (int i = 0; i < tableHeaders.length; i++) i: pw.Alignment.center,
        },
        headerStyle: pw.TextStyle(
          color: PdfColors.white,
          fontSize: Constants.TABLE_FONT_SIZE,
          fontWeight: pw.FontWeight.bold,
        ),
        cellStyle: const pw.TextStyle(
          color: PdfColors.black,
          fontSize: Constants.TABLE_FONT_SIZE,
        ),
        headers: List<String>.generate(
          tableHeaders.length,
          (col) => tableHeaders[col],
        ),
        data: [
          [
            generateCell(dto.resistance),
            generateCell(dto.slumping),
            generateCell(dto.totalVolume),
            generateCell(dto.tma),
            generateCell(dto.designAge),
            generateCell(dto.date),
            generateCell(dto.provider),
          ],
        ],
      ),
    );
  }

  pw.Widget _generateContentTable(
      pw.Context context, List<ConcreteSampleDTO> samples, int flex) {
    for (var element in samples) {
      print(element);
    }

    const tableHeaders = [
      "REMISION",
      "HORA PLANTA",
      "HORA OBRA",
      "MUESTRA",
      "REV REAL (CM)",
      "TEMP (°C)",
      "TRAMO (UBICACION)",
      "NO. DE CILINDRO",
      "EDAD DE ENSAYE",
      "FECHA DE ENSAYE",
      "CARGA (KGF)",
      "F'C",
      "PROMEDIO",
      "% DE F'C"
    ];

    return pw.Expanded(
      flex: flex,
      child: pw.TableHelper.fromTextArray(
        columnWidths: {
          0: const pw.FlexColumnWidth(1.5), // REMISION
          1: const pw.FlexColumnWidth(1.25), // HORA PLANTA
          2: const pw.FlexColumnWidth(1), // HORA OBRA
          3: const pw.FlexColumnWidth(1.5), // MUESTRA
          4: const pw.FlexColumnWidth(1), // REV REAL
          5: const pw.FlexColumnWidth(1), // TEMPERATURA
          6: const pw.FlexColumnWidth(2), // TRAMO (UBICACION)
          7: const pw.FlexColumnWidth(1.5), // NO. DE CILINDRO
          8: const pw.FlexColumnWidth(1.5), // EDAD DE ENSAYE
          9: const pw.FlexColumnWidth(1.5), // FECHA DE ENSAYE
          10: const pw.FlexColumnWidth(1), // CARGA
          11: const pw.FlexColumnWidth(1), // F'C
          12: const pw.FlexColumnWidth(1.5), // PROMEDIO
          13: const pw.FlexColumnWidth(1), // % DE F'C
        },
        border: pw.TableBorder.all(color: PdfColors.black, width: 0.5),
        cellAlignment: pw.Alignment.centerLeft,
        headerDecoration: const pw.BoxDecoration(
          color: PdfColors.blue800,
        ),
        headerHeight: 25,
        cellHeight: 25,
        cellAlignments: {
          for (int i = 0; i < tableHeaders.length; i++) i: pw.Alignment.center,
        },
        headerStyle: pw.TextStyle(
          color: PdfColors.white,
          fontSize: Constants.TABLE_FONT_SIZE,
          fontWeight: pw.FontWeight.bold,
        ),
        cellStyle: const pw.TextStyle(
          color: PdfColors.black,
          fontSize: Constants.TABLE_FONT_SIZE,
        ),
        headers: List<String>.generate(
          tableHeaders.length,
          (col) => tableHeaders[col],
        ),
        data: List<List<pw.Widget>>.generate(
          samples.length,
          (row) => List<pw.Widget>.generate(
            tableHeaders.length,
            (col) => samples[row].getIndex(col),
          ),
        ),
      ),
    );
  }

  Future<String> loadSvgFromAssets(String assetPath) async {
    final svgString = await rootBundle.loadString(assetPath);
    return svgString;
  }

  List<ConcreteSampleDTO> samplesToDTO(List<ConcreteSample>? samples) {
    if (samples != null) {
      return samples.map((e) {
        return ConcreteSampleDTO(
            e.remission ?? "",
            e.volume != null ? e.volume!.toStringAsFixed(1) : "",
            Utils.formatTimeOfDay(e.plantTime ?? TimeOfDay.now()),
            Utils.formatTimeOfDay(e.buildingSiteTime ?? TimeOfDay.now()),
            (e.concreteCylinders.first.sampleNumber ?? 0).toString(),
            e.realSlumping != null ? e.realSlumping!.toStringAsFixed(1) : "",
            e.temperature != null ? e.temperature!.toStringAsFixed(1) : "",
            e.location ?? "",
            e.concreteCylinders.map((c) {
              return ConcreteCylinderDTO(c.id!, c.testingAge, c.testingDate,
                  c.totalLoad, c.resistance, c.median, c.percentage);
            }).toList());
      }).toList();
    } else {
      return List.empty();
    }
  }

  ConcreteTestingOrderDTO modelToDTO(ConcreteTestingOrder testingOrder) {
    return ConcreteTestingOrderDTO(
        testingOrder.id ?? 0,
        testingOrder.customer.identifier,
        testingOrder.buildingSite.siteName,
        "",
        // LOCATION IS EMPTY FROM THE MOMENT
        "${testingOrder.siteResident?.firstName} ${testingOrder.siteResident?.lastName}",
        testingOrder.designResistance ?? "",
        testingOrder.slumping != null
            ? testingOrder.slumping!.toStringAsFixed(1)
            : "",
        testingOrder.volume != null
            ? testingOrder.volume!.toStringAsFixed(1)
            : "",
        testingOrder.tma != null ? testingOrder.tma!.toStringAsFixed(1) : "",
        testingOrder.designAge ?? "",
        testingOrder.testingDate != null
            ? Constants.formatter.format(testingOrder.testingDate!)
            : "",
        "EPICO CONCRETOS");
  }

  pw.Widget generateCell(String cellValue) {
    return pw.Expanded(
        child: pw.Text(cellValue,
            style: pw.TextStyle(
                font: pw.Font.times(), fontSize: Constants.TABLE_FONT_SIZE)));
  }
}
