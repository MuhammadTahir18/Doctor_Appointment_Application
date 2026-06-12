import 'package:flutter_bloc/flutter_bloc.dart';
import '../data/doctor_model.dart';
import '../data/doctor_repository.dart';
part 'doctor_state.dart';

class DoctorCubit extends Cubit<DoctorState> {
  final DoctorRepository _repo = DoctorRepository();

  DoctorCubit() : super(DoctorInitial());

  Future<void> loadDoctors() async {
    emit(DoctorLoading());
    try {
      final doctors = await _repo.getDoctors();
      emit(DoctorLoaded(doctors));
    } catch (e) {
      emit(DoctorError(e.toString()));
    }
  }

  Future<void> searchDoctors(String query) async {
    if (query.isEmpty) {
      loadDoctors();
      return;
    }
    emit(DoctorLoading());
    try {
      final doctors = await _repo.searchDoctors(query);
      emit(DoctorLoaded(doctors));
    } catch (e) {
      emit(DoctorError(e.toString()));
    }
  }
  Future<void> filterByCategory(String category) async {
    emit(DoctorLoading());
    try {
      final doctors = await _repo.getDoctors();
      final filtered = doctors.where((d) =>
          d.specialty.toLowerCase().contains(category.toLowerCase())
      ).toList();
      emit(DoctorLoaded(filtered));
    } catch (e) {
      emit(DoctorError(e.toString()));
    }
  }
}