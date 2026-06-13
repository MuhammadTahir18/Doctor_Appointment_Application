import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  AuthCubit() : super(AuthInitial());

  Future<void> checkAuthStatus() async {
    final user = _auth.currentUser;
    if (user != null) {
      emit(AuthSuccess(uid: user.uid, email: user.email!));
    } else {
      emit(AuthInitial());
    }
  }

  Future<void> register(String name, String email, String password) async {
    emit(AuthLoading());
    print('=== REGISTER STARTED ===');
    try {
      final result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      print('=== USER CREATED: ${result.user!.uid} ===');

      await _firestore.collection('users').doc(result.user!.uid).set({
        'name': name,
        'email': email,
        'role': 'patient',
        'createdAt': FieldValue.serverTimestamp(),
      });
      print('=== FIRESTORE SAVED ===');

      emit(AuthSuccess(uid: result.user!.uid, email: email));
      print('=== AUTH SUCCESS EMITTED ===');

    } on FirebaseAuthException catch (e) {
      print('=== FIREBASE ERROR: ${e.code} ===');
      emit(AuthError(_getError(e.code)));
    } catch (e) {
      print('=== GENERAL ERROR: $e ===');
      emit(AuthError('Something went wrong'));
    }
  }

  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    try {
      final result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Firestore se role lao
      final doc = await _firestore
          .collection('users')
          .doc(result.user!.uid)
          .get();
      final role = doc.data()?['role'] ?? 'patient';

      emit(AuthSuccess(
        uid: result.user!.uid,
        email: result.user!.email!,
        role: role,
      ));
    } on FirebaseAuthException catch (e) {
      emit(AuthError(_getError(e.code)));
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    emit(AuthInitial());
  }

  String _getError(String code) {
    switch (code) {
      case 'user-not-found': return 'Email not registered';
      case 'wrong-password': return 'Wrong password';
      case 'email-already-in-use': return 'Email already registered';
      case 'weak-password': return 'Password too weak';
      default: return 'Something went wrong';
    }
  }
}