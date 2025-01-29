class Appointment {
  final int? id;
  final int patientId;
  final String appointmentDate;
  final String doctorName;

  Appointment(
      {this.id,
      required this.patientId,
      required this.appointmentDate,
      required this.doctorName});

  Map<String, dynamic> toMap() {
    return {
      'patient_id': patientId,
      'appointment_date': appointmentDate,
      'doctor_name': doctorName
    };
  }
}
