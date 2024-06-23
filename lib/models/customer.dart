import 'building_site.dart';

class Customer {
  int? id;
  String identifier;
  String companyName;

  // ONE TO MANY
  List<BuildingSite> projects;

  Customer({
    this.id,
    required this.identifier,
    required this.companyName,
    List<BuildingSite>? projects,
  }) : projects = projects ?? [];

  Map<String, Object?> toMap() {
    return {"id": id, "identifier": identifier, "company_name": companyName};
  }

  static Customer toModel(Map<String, Object?>? map) {
    return Customer(
        id: (map?["id"] ?? 0) as int,
        identifier: (map?["identifier"] ?? "") as String,
        companyName: (map?["company_name"] ?? "") as String);
  }

  static Customer emptyModel() {
    return Customer(identifier: "", companyName: "");
  }
}
