class Car {
  final String carNumber;
  final DateTime checkInTime;
  final DateTime? checkOutTime;

  Car({
    required this.carNumber,
    required this.checkInTime,
    this.checkOutTime,
  });
  factory Car.fromMap(Map<String, dynamic> map) {
    return Car(
      carNumber: map['carNumber'] as String,
      checkInTime: DateTime.parse(map['checkInTime'] as String),
      checkOutTime: map['checkOutTime'] != null
          ? DateTime.parse(map['checkOutTime'] as String)
          : null,
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'carNumber': carNumber,
      'checkInTime': checkInTime.toIso8601String(),
      'checkOutTime': checkOutTime?.toIso8601String(),
    };
  }
}
