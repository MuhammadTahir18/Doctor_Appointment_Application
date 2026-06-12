class DoctorModel {
  final String id;
  final String name;
  final String specialty;
  final double rating;
  final int experience;
  final int fee;
  final String address;
  final double lat;
  final double lng;
  final String about;
  final String image;
  final bool isAvailable;

  DoctorModel({
    required this.id,
    required this.name,
    required this.specialty,
    required this.rating,
    required this.experience,
    required this.fee,
    required this.address,
    required this.lat,
    required this.lng,
    required this.about,
    required this.image,
    required this.isAvailable,
  });

  factory DoctorModel.fromFirestore(Map<String, dynamic> json, String id) {
    return DoctorModel(
      id: id,
      name: json['name'] ?? '',
      specialty: json['specialty'] ?? '',
      // String se convert kar rahe hain kyunki Firestore mein string save kiya tha
      rating: double.tryParse(json['rating'].toString()) ?? 0.0,
      experience: int.tryParse(json['experience'].toString()) ?? 0,
      fee: int.tryParse(json['fee'].toString()) ?? 0,
      address: json['address'] ?? '',
      lat: double.tryParse(json['lat'].toString()) ?? 0.0,
      lng: double.tryParse(json['lng'].toString()) ?? 0.0,
      about: json['about'] ?? '',
      image: json['image'] ?? '',
      isAvailable: json['isAvailable'].toString() == 'true',
    );
  }
}