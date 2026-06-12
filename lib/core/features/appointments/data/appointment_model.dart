class AppointmentModel {
  final String id;
  final String doctorId;
  final String doctorName;
  final String doctorSpecialty;
  final String doctorImage;
  final String patientId;
  final String date;
  final String time;
  final String status;
  final int fee;

  AppointmentModel({
    required this.id,
    required this.doctorId,
    required this.doctorName,
    required this.doctorSpecialty,
    required this.doctorImage,
    required this.patientId,
    required this.date,
    required this.time,
    required this.status,
    required this.fee,
  });

  factory AppointmentModel.fromFirestore(
      Map<String, dynamic> json, String id) {
    return AppointmentModel(
      id: id,
      doctorId: json['doctorId'] ?? '',
      doctorName: json['doctorName'] ?? '',
      doctorSpecialty: json['doctorSpecialty'] ?? '',
      doctorImage: json['doctorImage'] ?? '',
      patientId: json['patientId'] ?? '',
      date: json['date'] ?? '',
      time: json['time'] ?? '',
      status: json['status'] ?? 'pending',
      fee: int.tryParse(json['fee'].toString()) ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'doctorId': doctorId,
      'doctorName': doctorName,
      'doctorSpecialty': doctorSpecialty,
      'doctorImage': doctorImage,
      'patientId': patientId,
      'date': date,
      'time': time,
      'status': status,
      'fee': fee,
      'createdAt': DateTime.now().toIso8601String(),
    };
  }
}