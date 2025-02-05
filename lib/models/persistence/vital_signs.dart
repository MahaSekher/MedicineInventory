class VitalSigns {
  final int? id;
  final String email;
  final String date;
  final String time;
  final double temperature;
  final String bloodPressure;
  final int heartRate;
  final int respiratoryRate;

  VitalSigns({
    this.id,
    required this.email,
    required this.date,
    required this.time,
    required this.temperature,
    required this.bloodPressure,
    required this.heartRate,
    required this.respiratoryRate
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'date': date,
      'time' : time,
      'temperature': temperature,
      'blood_pressure': bloodPressure,
      'heart_rate': heartRate,
      'respiratory_rate': respiratoryRate,
    };
  }

  static VitalSigns fromMap(Map<String, dynamic> map) {
    return VitalSigns(
      id: map['id'],
      email: map['email'],
      date: map['date'],
      time: map['time'],
      temperature: map['temperature'],
      bloodPressure: map['blood_pressure'],
      heartRate: map['heart_rate'],
      respiratoryRate: map['respiratory_rate'],
    );
  }
}
