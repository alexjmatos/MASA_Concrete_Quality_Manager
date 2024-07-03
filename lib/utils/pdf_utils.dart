import 'dart:typed_data';

import 'package:masa_epico_concrete_manager/utils/sequential_counter_generator.dart';
import 'package:masa_epico_concrete_manager/utils/utils.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

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
        "REM-001", "12:30", "13:30", "18", "38", "MURO CIMENTACION", [
      ConcreteCylinderDTO(1, 3, DateTime.now(), 20970, 118, 120, 47),
      ConcreteCylinderDTO(2, 7, DateTime.now(), 20970, 118, 120, 47),
      ConcreteCylinderDTO(3, 14, DateTime.now(), 20970, 118, 120, 47),
      ConcreteCylinderDTO(4, 14, DateTime.now(), 20970, 118, 120, 47)
    ])
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

class ConcreteCylinderDTO {
  int id;
  int designAge;
  DateTime testingDate;
  num? totalLoad;
  num? resistance;
  num? median;
  num? percentage;

  ConcreteCylinderDTO(this.id, this.designAge, this.testingDate, this.totalLoad,
      this.resistance, this.median, this.percentage);
}

class ConcreteSampleDTO {
  String remission;
  String timePlant;
  String timeBuildingSite;
  String slumping;
  String temperature;
  String location;
  List<ConcreteCylinderDTO> cylinders;

  ConcreteSampleDTO(this.remission, this.timePlant, this.timeBuildingSite,
      this.slumping, this.temperature, this.location, this.cylinders);

  pw.Widget getIndex(int index) {
    switch (index) {
      case 0:
        return pw.Expanded(child: pw.Text(remission));
      case 1:
        return pw.Expanded(child: pw.Text(timePlant));
      case 2:
        return pw.Expanded(child: pw.Text(timeBuildingSite));
      case 3:
        return pw.Expanded(child: pw.Text(slumping));
      case 4:
        return pw.Expanded(child: pw.Text(temperature));
      case 5:
        return pw.Expanded(child: pw.Text(location));
      case 6:
        return pw.Column(
            children: cylinders
                .map((e) =>
                    pw.Text(SequentialFormatter.generatePadLeftNumber(e.id)))
                .toList());
      case 7:
        return pw.Column(
            children:
                cylinders.map((e) => pw.Text(e.designAge.toString())).toList());
      case 8:
        return pw.Column(
            children: cylinders
                .map((e) => pw.Text(Utils.formatDate(e.testingDate)))
                .toList());
      case 9:
        return pw.Column(
            children:
                cylinders.map((e) => pw.Text(e.totalLoad.toString())).toList());
      case 10:
        return pw.Column(
            children: cylinders
                .map((e) => pw.Text(e.resistance.toString()))
                .toList());
      case 11:
        return pw.Column(
            children:
                cylinders.map((e) => pw.Text(e.median.toString())).toList());
      case 12:
        return pw.Column(
            children: cylinders
                .map((e) => pw.Text(e.percentage.toString()))
                .toList());
      default:
        return pw.Text("");
    }
  }
}
