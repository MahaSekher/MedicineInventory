class Patient {
  final int? id;
  final String name;
  final String dob;
  final String gender;
  final String phoneNumber;
  final String address;

  Patient(
      {this.id,
      required this.name,
      required this.dob,
      required this.gender,
      required this.phoneNumber,
      required this.address});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'dob': dob,
      'gender': gender,
      'phone_number': phoneNumber,
      'address': address
    };
  }
}
