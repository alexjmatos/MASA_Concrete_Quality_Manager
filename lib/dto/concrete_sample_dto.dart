import '../constants/constants.dart';
import '../utils/sequential_counter_generator.dart';
import '../utils/utils.dart';
import 'concrete_cylinder.dart';
import 'package:pdf/widgets.dart' as pw;

class ConcreteSampleDTO {
  String remission;
  String timePlant;
  String timeBuildingSite;
  String sampleNumber;
  String slumping;
  String temperature;
  String location;
  List<ConcreteCylinderDTO> cylinders;

  ConcreteSampleDTO(
      this.remission,
      this.timePlant,
      this.timeBuildingSite,
      this.sampleNumber,
      this.slumping,
      this.temperature,
      this.location,
      this.cylinders);

  pw.TextStyle getStyle() {
    return pw.TextStyle(
        font: pw.Font.times(), fontSize: Constants.TABLE_FONT_SIZE);
  }

  pw.Widget getIndex(int index) {
    switch (index) {
      case 0:
        return pw.Expanded(child: pw.Text(remission, style: getStyle()));
      case 1:
        return pw.Expanded(child: pw.Text(timePlant, style: getStyle()));
      case 2:
        return pw.Expanded(child: pw.Text(timeBuildingSite, style: getStyle()));
      case 3:
        return pw.Expanded(child: pw.Text(sampleNumber, style: getStyle()));
      case 4:
        return pw.Expanded(child: pw.Text(slumping, style: getStyle()));
      case 5:
        return pw.Expanded(child: pw.Text(temperature, style: getStyle()));
      case 6:
        return pw.Expanded(child: pw.Text(location, style: getStyle()));
      case 7:
        return pw.Column(
            children: cylinders
                .map((e) => pw.Text(
                    SequentialFormatter.generatePadLeftNumber(e.id),
                    style: getStyle()))
                .toList());
      case 8:
        return pw.Column(
          children: cylinders
              .map((e) => pw.Text(e.designAge.toString(), style: getStyle()))
              .toList(),
        );
      case 9:
        return pw.Column(
            children: cylinders
                .map((e) =>
                    pw.Text(Utils.formatDate(e.testingDate), style: getStyle()))
                .toList());
      case 10:
        return pw.Column(
            children: cylinders
                .map((e) => pw.Text(
                    e.totalLoad != null
                        ? e.totalLoad!.toStringAsPrecision(1)
                        : "",
                    style: getStyle()))
                .toList());
      case 11:
        return pw.Column(
            children: cylinders
                .map((e) => pw.Text(
                    e.resistance != null
                        ? e.resistance!.toStringAsPrecision(1)
                        : "",
                    style: getStyle()))
                .toList());
      case 12:
        return pw.Column(
            children: cylinders
                .map((e) => pw.Text(
                    e.median != null ? e.median!.toStringAsPrecision(1) : "",
                    style: getStyle()))
                .toList());
      case 13:
        return pw.Column(
            children: cylinders
                .map((e) => pw.Text(
                    e.percentage != null
                        ? e.percentage!.toStringAsPrecision(1)
                        : "",
                    style: getStyle()))
                .toList());
      default:
        return pw.Text("");
    }
  }

  @override
  String toString() {
    return 'ConcreteSampleDTO{remission: $remission, timePlant: $timePlant, timeBuildingSite: $timeBuildingSite, sampleNumber: $sampleNumber, slumping: $slumping, temperature: $temperature, location: $location, cylinders: $cylinders}';
  }
}
