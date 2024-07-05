import 'dart:typed_data';

import 'package:masa_epico_concrete_manager/models/concrete_testing_order.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../dto/concrete_cylinder.dart';
import '../dto/concrete_sample_dto.dart';
import '../models/concrete_sample.dart';
import '../utils/utils.dart';

class ReportGenerator {
  Future<Uint8List> buildReport(
      PdfPageFormat format, ConcreteTestingOrder concreteTestingOrder) async {
    // Create the Pdf document
    final pw.Document doc = pw.Document();

    // Add one page with centered text "Hello World"
    doc.addPage(
      pw.Page(
        pageFormat: format,
        build: (pw.Context context) {
          return _contentTable(
              context, samplesToDTO(concreteTestingOrder.concreteSamples));
        },
      ),
    );
    // Build and return the final Pdf file data
    return await doc.save();
  }

  List<ConcreteSampleDTO> samplesToDTO(List<ConcreteSample>? samples) {
    if (samples != null) {
      return samples.map((e) {
        return ConcreteSampleDTO(
            e.remission ?? "",
            Utils.formatTimeOfDay(e.plantTime),
            Utils.formatTimeOfDay(e.buildingSiteTime),
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

  pw.Widget _contentTable(pw.Context context, List<ConcreteSampleDTO> samples) {
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
        samples.length,
        (row) => List<pw.Widget>.generate(
          tableHeaders.length,
          (col) => samples[row].getIndex(col),
        ),
      ),
    ));
  }
}
