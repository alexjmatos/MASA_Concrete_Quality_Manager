import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../dto/concrete_cylinder_dto.dart';
import '../dto/concrete_sample_dto.dart';

class PdfUtils {
  Future<Uint8List> buildPdf(PdfPageFormat format) async {
    // Create the Pdf document
    final pw.Document doc = pw.Document();

    // Add one page with centered text "Hello World"
    doc.addPage(
      pw.Page(
        pageFormat: format,
        build: (pw.Context context) {
          return _contentTable(context);
        },
      ),
    );

    // Build and return the final Pdf file data
    return await doc.save();
  }

  final List<ConcreteSampleDTO> products = [
    ConcreteSampleDTO(
        remission: "REM-001",
        plantTime: TimeOfDay.now(),
        buildingSiteTime: TimeOfDay.now(),
        realSlumpingCm: 18,
        temperatureCelsius: 38.5,
        location: "MURO CIMENTACION",
        id: 1,
        cylinders: [
          ConcreteCylinderDTO(
              id: 4,
              designAge: 14,
              testingDate: DateTime.now(),
              totalLoad: 20970,
              resistance: 118,
              median: 120,
              percentage: 47,
              buildingSiteSampleNumber: 1),
          ConcreteCylinderDTO(
              id: 4,
              designAge: 14,
              testingDate: DateTime.now(),
              totalLoad: 20970,
              resistance: 118,
              median: 120,
              percentage: 47,
              buildingSiteSampleNumber: 2),
          ConcreteCylinderDTO(
              id: 4,
              designAge: 14,
              testingDate: DateTime.now(),
              totalLoad: 20970,
              resistance: 118,
              median: 120,
              percentage: 47,
              buildingSiteSampleNumber: 3),
          ConcreteCylinderDTO(
              id: 4,
              designAge: 14,
              testingDate: DateTime.now(),
              totalLoad: 20970,
              resistance: 118,
              median: 120,
              percentage: 47,
              buildingSiteSampleNumber: 5)
        ],
        volume: 40),
  ];

  pw.Widget _contentTable(pw.Context context) {
    const tableHeaders = [
      "REMISION",
      "HORA PLANTA",
      "HORA OBRA",
      "REV REAL",
      "TEMP (°C)",
      "UBICACION",
      "NO. DE CILINDRO",
      "EDAD DE ENSAYE",
      "FECHA DE ENSAYE",
      "CARGA (KGF)",
      "RESISTENCIA F'C",
      "PROMEDIO",
      "% DE F'C"
    ];

    return pw.Expanded(
        child: pw.TableHelper.fromTextArray(
      border: null,
      cellAlignment: pw.Alignment.centerLeft,
      headerDecoration: const pw.BoxDecoration(
        borderRadius: pw.BorderRadius.all(pw.Radius.circular(2)),
        color: PdfColors.blue,
      ),
      headerHeight: 25,
      cellHeight: 40,
      cellAlignments: {
        0: pw.Alignment.center,
        1: pw.Alignment.center,
        2: pw.Alignment.center,
        3: pw.Alignment.center,
        4: pw.Alignment.center,
        5: pw.Alignment.center,
        6: pw.Alignment.center,
        7: pw.Alignment.center,
        8: pw.Alignment.center,
        9: pw.Alignment.center,
        10: pw.Alignment.center,
        11: pw.Alignment.center,
        12: pw.Alignment.center,
      },
      headerStyle: pw.TextStyle(
        color: PdfColors.white,
        fontSize: 10,
        fontWeight: pw.FontWeight.bold,
      ),
      cellStyle: const pw.TextStyle(
        color: PdfColors.black,
        fontSize: 10,
      ),
      rowDecoration: const pw.BoxDecoration(
        border: pw.Border(
          bottom: pw.BorderSide(
            color: PdfColors.black,
            width: .5,
          ),
        ),
      ),
      headers: List<String>.generate(
        tableHeaders.length,
        (col) => tableHeaders[col],
      ),
      data: List<List<pw.Widget>>.generate(
        products.length,
        (row) => List<pw.Widget>.generate(
          tableHeaders.length,
          (col) => products[row].getIndex(col),
        ),
      ),
    ));
  }
}
