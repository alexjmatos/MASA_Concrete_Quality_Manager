// Entidad - Direccion en el backend
class Location {
  String? id;
  String district;
  String street;
  String number;
  String city;
  String state;
  String zipCode;

  Location(
      {this.id,
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
        "colonia": district,
        "calle": street,
        "numero": number,
        "municipio": city,
        "codigo_postal": zipCode,
        "estado": state,
      };
}
