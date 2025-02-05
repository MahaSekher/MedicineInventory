class Settings {
  final String email;
  final bool expiryAlert;
  final int expiryDays;
  final bool inventoryAlert;
  final int inventoryDays;
  final bool appointmentAlert;
  final int appointmentMinutes;

  Settings({
    required this.email,
    required this.expiryAlert,
    required this.expiryDays,
    required this.inventoryAlert,
    required this.inventoryDays,
    required this.appointmentAlert,
    required this.appointmentMinutes,
  });



  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'expiry_alert': expiryAlert ? 1 : 0,
      'expiry_days': expiryDays,
      'inventory_alert': inventoryAlert ? 1 : 0,
      'inventory_days': inventoryDays,
      'appointment_alert': appointmentAlert ? 1 : 0,
      'appointment_minutes': appointmentMinutes,
    };
  }

  static Settings fromMap(Map<String, dynamic> map) {
    return Settings(
      email: map['email'],
      expiryAlert: map['expiry_alert'] == 1,
      expiryDays: map['expiry_days'],
      inventoryAlert: map['inventory_alert'] == 1,
      inventoryDays: map['inventory_days'],
      appointmentAlert: map['appointment_alert'] == 1,
      appointmentMinutes: map['appointment_minutes'],
    );
  }

  Settings copyWith({
    String? email,
    bool? expiryAlert,
    int? expiryDays,
    bool? inventoryAlert,
    int? inventoryDays,
    bool? appointmentAlert,
    int? appointmentMinutes,
  }) {
    return Settings(
      email: email ?? this.email,
      expiryAlert: expiryAlert ?? this.expiryAlert,
      expiryDays: expiryDays ?? this.expiryDays,
      inventoryAlert: inventoryAlert ?? this.inventoryAlert,
      inventoryDays: inventoryDays ?? this.inventoryDays,
      appointmentAlert: appointmentAlert ?? this.appointmentAlert,
      appointmentMinutes: appointmentMinutes ?? this.appointmentMinutes,
    );
  }
}
