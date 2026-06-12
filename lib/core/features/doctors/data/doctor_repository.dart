import 'package:cloud_firestore/cloud_firestore.dart';
import 'doctor_model.dart';

class DoctorRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Sare doctors Firestore se lao
  Future<List<DoctorModel>> getDoctors() async {
    final snapshot = await _firestore.collection('doctors').get();
    return snapshot.docs
        .map((doc) => DoctorModel.fromFirestore(doc.data(), doc.id))
        .toList();
  }

  // Search by name ya specialty
  Future<List<DoctorModel>> searchDoctors(String query) async {
    final snapshot = await _firestore.collection('doctors').get();
    final all = snapshot.docs
        .map((doc) => DoctorModel.fromFirestore(doc.data(), doc.id))
        .toList();

    return all.where((doc) =>
    doc.name.toLowerCase().contains(query.toLowerCase()) ||
        doc.specialty.toLowerCase().contains(query.toLowerCase())
    ).toList();
  }
}