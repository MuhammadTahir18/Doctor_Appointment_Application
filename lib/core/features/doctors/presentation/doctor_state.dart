part of 'doctor_cubit.dart';

abstract class DoctorState {}

class DoctorInitial extends DoctorState {}

class DoctorLoading extends DoctorState {}

class DoctorLoaded extends DoctorState {
  final List<DoctorModel> doctors;
  DoctorLoaded(this.doctors);
}

class DoctorError extends DoctorState {
  final String message;
  DoctorError(this.message);
}