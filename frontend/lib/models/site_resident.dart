// Entidad - Residente en backend
class SiteResident {
  int id;
  String firstName;
  String lastName;
  String jobPosition;
  String? phoneNumber;
  String? email;

  SiteResident({
    required this.id,
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
}
