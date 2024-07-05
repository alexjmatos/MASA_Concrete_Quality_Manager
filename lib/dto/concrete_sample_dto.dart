import '../utils/sequential_counter_generator.dart';
import '../utils/utils.dart';
import 'concrete_cylinder.dart';
import 'package:pdf/widgets.dart' as pw;

class ConcreteSampleDTO {
  String remission;
  String timePlant;
  String timeBuildingSite;
  String slumping;
  String temperature;
  String location;
  List<ConcreteCylinderDTO> cylinders;

  ConcreteSampleDTO(
      this.remission,
      this.timePlant,
      this.timeBuildingSite,
      this.slumping,
      this.temperature,
      this.location,
      this.cylinders);

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
