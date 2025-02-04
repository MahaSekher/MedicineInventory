class MyProfile {
  final String email;
  final String name;
  final String? phone;
  final String? address;
  final String? emergencyContact;
  final String? dob; // Date of Birth
  final String? gender;
  final double? height;
  final double? weight;
  final String? image;

  MyProfile({
    required this.email,
    required this.name,
    this.phone,
    this.address,
    this.emergencyContact,
    this.dob,
    this.gender,
    this.height,
    this.weight,
    this.image,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'phone': phone,
      'address': address,
      'emergency_contact': emergencyContact,
      'dob': dob,
      'gender': gender,
      'height': height,
      'weight': weight,
      'image': image,
    };
  }

  static MyProfile fromMap(Map<String, dynamic> map) {
    return MyProfile(
      email: map['email'],
      name: map['name'],
      phone: map['phone'],
      address: map['address'],
      emergencyContact: map['emergency_contact'],
      dob: map['dob'],
      gender: map['gender'],
      height: map['height'],
      weight: map['weight'],
      image: map['image'],
    );
  }

  MyProfile copyWith({
    String? email,
    String? name,
    String? phone,
    String? address,
    String? emergencyContact,
    String? dob,
    String? gender,
    double? height,
    double? weight,
    String? image,
  }) {
    return MyProfile(
      email: email ?? this.email,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      address: address ?? this.address,
      emergencyContact: emergencyContact ?? this.emergencyContact,
      dob: dob ?? this.dob,
      gender: gender ?? this.gender,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      image: image ?? this.image,
    );
  }
}
