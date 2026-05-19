import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../cubit/auth/auth_cubit.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_input.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _userController = TextEditingController();
  final _passController = TextEditingController();
  final _emailController = TextEditingController();
  bool _rememberMe = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: const BackButton(), elevation: 0),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const Text("Sign Up", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
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
            const SizedBox(height: 20),
            CustomInput(
              label: "Email Address",
              hint: "bill.sanders@example.com",
              controller: _emailController,
              suffix: const Icon(Icons.check, color: Colors.green, size: 20),
            ),
            const SizedBox(height: 30),
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
            BlocBuilder<AuthCubit, AuthState>(
              builder: (context, state) {
                return CustomButton(
                  text: "Sign Up",
                  isLoading: state is AuthLoading,
                  onPressed: () => context.read<AuthCubit>().signUp(
                    _emailController.text, _passController.text, _userController.text,
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