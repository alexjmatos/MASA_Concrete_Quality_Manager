// Entidad - Gerente en backend
class Manager {
  String? id;
  int? sequence;
  String firstName;
  String lastName;
  String jobPosition;
  String? phoneNumber;
  String? email;

  Manager({
    this.id,
    this.sequence,
    required this.firstName,
    required this.lastName,
    required this.jobPosition,
    this.phoneNumber,
    this.email,
  });

  @override
  String toString() {
    return 'Manager: { firstName: $firstName, lastName: $lastName, jobPosition: $jobPosition, phoneNumber: $phoneNumber, email: $email }';
  }

  Map<String, dynamic> toMap() => <String, dynamic>{
        "consecutivo": sequence,
        "nombres": firstName,
        "apellidos": lastName,
        "puesto": jobPosition,
        "telefono": phoneNumber,
        "email": email,
      };

  static Manager emptyModel() {
    return Manager(lastName: "", jobPosition: "", firstName: '');
  }
}
