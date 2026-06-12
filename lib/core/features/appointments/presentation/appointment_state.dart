part of 'appointment_cubit.dart';

abstract class AppointmentState {}

class AppointmentInitial extends AppointmentState {}

class AppointmentLoading extends AppointmentState {}

class AppointmentSuccess extends AppointmentState {
  final String message;
  AppointmentSuccess(this.message);
}

class AppointmentLoaded extends AppointmentState {
  final List<AppointmentModel> appointments;
  AppointmentLoaded(this.appointments);
}

class AppointmentError extends AppointmentState {
  final String message;
  AppointmentError(this.message);
}