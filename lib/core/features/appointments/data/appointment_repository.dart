import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'appointment_model.dart';

class AppointmentRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Appointment book karo
  Future<void> bookAppointment(AppointmentModel appointment) async {
    await _firestore
        .collection('appointments')
        .add(appointment.toMap());
  }

  // Current user ki appointments lao
  Future<List<AppointmentModel>> getMyAppointments() async {
    final uid = _auth.currentUser!.uid;
    final snapshot = await _firestore
        .collection('appointments')
        .where('patientId', isEqualTo: uid)
        .get();

    return snapshot.docs
        .map((doc) => AppointmentModel.fromFirestore(doc.data(), doc.id))
        .toList();
  }

  // Appointment cancel karo
  Future<void> cancelAppointment(String appointmentId) async {
    await _firestore
        .collection('appointments')
        .doc(appointmentId)
        .update({'status': 'cancelled'});
  }
}