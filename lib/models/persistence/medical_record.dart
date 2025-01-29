class MedicalRecord {
  final int? id;
  final int patientId;
  final String diagnosis;
  final String treatment;
  final String recordDate;

  MedicalRecord(
      {this.id,
      required this.patientId,
      required this.diagnosis,
      required this.treatment,
      required this.recordDate});

  Map<String, dynamic> toMap() {
    return {
      'patient_id': patientId,
      'diagnosis': diagnosis,
      'treatment': treatment,
      'record_date': recordDate
    };
  }
}
