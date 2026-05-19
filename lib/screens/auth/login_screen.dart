import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/auth/auth_cubit.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _userController = TextEditingController();
  final _passController = TextEditingController();
  bool _rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: const BackButton(), elevation: 0),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const Text("Welcome", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            const Text("Please enter your data to continue", style: TextStyle(color: Colors.grey)),
            const SizedBox(height: 50),
            CustomInput(
              label: "Username",
              hint: "Esther Howard",
              controller: _userController,
              suffix: const Icon(Icons.check, color: Colors.green, size: 20),
            ),
            const SizedBox(height: 20),
            CustomInput(
              label: "Password",
              hint: "••••••••",
              controller: _passController,
              isPassword: true,
              suffix: const Text("Strong", style: TextStyle(color: Colors.green, fontSize: 11)),
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () => Navigator.pushNamed(context, '/forgot_password'),
                child: const Text("Forgot password?", style: TextStyle(color: Color(0xFFEA4335))),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Remember me", style: TextStyle(fontWeight: FontWeight.w500)),
                Switch.adaptive(
                  value: _rememberMe,
                  activeColor: Colors.green,
                  onChanged: (v) => setState(() => _rememberMe = v),
                ),
              ],
            ),
            const Spacer(),
            const Text(
              "By connecting your account confirm that you agree with our Term and Condition",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),
            const SizedBox(height: 20),
            BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                return CustomButton(
                  text: "Login",
                  isLoading: state is AuthLoading,
                  onPressed: () => context.read<AuthCubit>().login(
                    _userController.text, _passController.text,
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
