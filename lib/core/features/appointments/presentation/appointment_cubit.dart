import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../data/appointment_model.dart';
import '../data/appointment_repository.dart';
part 'appointment_state.dart';

class AppointmentCubit extends Cubit<AppointmentState> {
  final AppointmentRepository _repo = AppointmentRepository();

  AppointmentCubit() : super(AppointmentInitial());

  Future<void> bookAppointment({
    required String doctorId,
    required String doctorName,
    required String doctorSpecialty,
    required String doctorImage,
    required String date,
    required String time,
    required int fee,
  }) async {
    emit(AppointmentLoading());
    try {
      final uid = FirebaseAuth.instance.currentUser!.uid;

      final appointment = AppointmentModel(
        id: '',
        doctorId: doctorId,
        doctorName: doctorName,
        doctorSpecialty: doctorSpecialty,
        doctorImage: doctorImage,
        patientId: uid,
        date: date,
        time: time,
        status: 'pending',
        fee: fee,
      );

      await _repo.bookAppointment(appointment);
      emit(AppointmentSuccess('Appointment booked successfully!'));
    } catch (e) {
      emit(AppointmentError(e.toString()));
    }
  }

  Future<void> loadMyAppointments() async {
    emit(AppointmentLoading());
    try {
      final appointments = await _repo.getMyAppointments();
      emit(AppointmentLoaded(appointments));
    } catch (e) {
      emit(AppointmentError(e.toString()));
    }
  }

  Future<void> cancelAppointment(String id) async {
    try {
      await _repo.cancelAppointment(id);
      loadMyAppointments(); // Reload karo
    } catch (e) {
      emit(AppointmentError(e.toString()));
    }
  }
}