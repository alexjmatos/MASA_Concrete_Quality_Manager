import 'package:masa_epico_concrete_manager/models/project_site.dart';

class SiteResident {
  int? id;
  String firstName;
  String lastName;
  String jobPosition;
  List<BuildingSite> projectSites = [];

  SiteResident({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.jobPosition,
  });

  Map<String, Object?> toMap() {
    return {
      "id": id,
      "first_name": firstName,
      "last_name": lastName,
      "job_position": jobPosition
    };
  }

  static SiteResident toModel(Map<String, Object?>? map) {
    return SiteResident(
        id: (map?["id"] ?? 0) as int,
        firstName: (map?["first_name"] ?? "") as String,
        lastName: (map?["last_name"] ?? "") as String,
        jobPosition: (map?["job_position"] ?? "") as String);
  }

  @override
  String toString() {
    return 'SiteResident{id: $id, firstName: $firstName, lastName: $lastName, jobPosition: $jobPosition}';
  }
}
