// Entidad - Direccion en el backend
class Location {
  String? id;
  int? sequence;
  String district;
  String street;
  String number;
  String city;
  String state;
  String zipCode;

  Location(
      {this.id,
      this.sequence,
      required this.district,
      required this.street,
      required this.number,
      required this.city,
      required this.state,
      required this.zipCode});

  @override
  String toString() {
    return '$street, $city, $state $zipCode';
  }

  Map<String, dynamic> toMap() => <String, dynamic>{
        "consecutivo": sequence,
        "colonia": district,
        "calle": street,
        "numero": number,
        "municipio": city,
        "codigo_postal": zipCode,
        "estado": state,
      };

  static Location toModel(Map<String, dynamic> json) {
    String id = json['id'];
    int sequence = json['consecutivo'] as int;
    String district = json['colonia'];
    String street = json['calle'];
    String number = json['numero'];
    String city = json['municipio'];
    String state = json['estado'];
    String zipCode = json['codigo_postal'];
    return Location(
        id: id,
        sequence: sequence,
        district: district,
        street: street,
        number: number,
        city: city,
        state: state,
        zipCode: zipCode);
  }

  static Location emptyModel() {
    return Location(
        district: "", street: "", number: "", city: "", state: "", zipCode: "");
  }
}
