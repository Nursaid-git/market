import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final _client = Supabase.instance.client;
  Future<AuthResponse> loginUser(String email, String password) async {
    return await _client.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  Future<AuthResponse> signUpUser(String email, String password, String username) async {
    return await _client.auth.signUp(
      email: email,
      password: password,
      data: {'display_name': username},
    );
  }
  bool isUserLoggedIn() {
    return _client.auth.currentSession != null;
  }
  Future<void> signInWithGoogle() async {
    await _client.auth.signInWithOAuth(OAuthProvider.google);
  }

  Future<void> signInWithFacebook() async {
    await _client.auth.signInWithOAuth(OAuthProvider.facebook);
  }

  Future<void> resetPassword(String email) async {
    await _client.auth.resetPasswordForEmail(email);
  }
}

