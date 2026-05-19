import 'package:flutter_bloc/flutter_bloc.dart';

import '../../service/auth_service.dart';

enum SplashStatus { initial, authenticated, unauthenticated }

class SplashCubit extends Cubit<SplashStatus> {
  final AuthService _authService = AuthService();
  SplashCubit() : super(SplashStatus.initial);

  void checkAuth() async {
    await Future.delayed(const Duration(seconds: 2));
    if (_authService.isUserLoggedIn()) {
      emit(SplashStatus.authenticated);
    } else {
      emit(SplashStatus.unauthenticated);
    }
  }
}