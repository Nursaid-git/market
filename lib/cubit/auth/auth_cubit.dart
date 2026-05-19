import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../service/auth_service.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthService _service = AuthService();
  AuthCubit() : super(AuthInitial());

  Future<void> signUp(String email, String password, String username) async {
    emit(AuthLoading());
    try {
      await _service.signUpUser(email, password, username);
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> login(String username, String password) async {
    emit(AuthLoading());
    try {
      // В Supabase логин обычно идет по email, поэтому здесь может потребоваться
      // логика конвертации username в email или вход по email.
      await _service.loginUser("$username@example.com", password);
      emit(AuthSuccess());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> forgotPassword(String email) async {
    emit(AuthLoading());
    try {
      await _service.resetPassword(email);
      emit(ForgotPasswordSuccess());
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
