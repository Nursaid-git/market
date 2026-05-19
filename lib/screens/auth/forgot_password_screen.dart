import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/widgets/auth_header.dart';
import '../../cubit/auth/auth_cubit.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/custom_input.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(leading: const BackButton(), elevation: 0),
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is ForgotPasswordSuccess) {
            // Переход на экран ввода кода (Screen 11)
            Navigator.pushNamed(context, '/verification', arguments: _emailController.text);
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error), backgroundColor: Colors.red),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const AuthHeader(
                title: "Forgot Password",
                imagePath: "assets/images/cloud_lock.png",
              ),
              const SizedBox(height: 40),
              CustomInput(
                label: "Email Address",
                hint: "bill.sanders@example.com",
                controller: _emailController,
                suffix: const Icon(Icons.check, color: Colors.green, size: 20),
              ),
              const Spacer(),
              const Text(
                "Please write your email to receive a confirmation code to set a new password.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.grey, fontSize: 13),
              ),
              const SizedBox(height: 20),
              BlocBuilder<AuthCubit, AuthState>(
                builder: (context, state) {
                  return CustomButton(
                    text: "Confirm Mail",
                    isLoading: state is AuthLoading,
                    onPressed: () {
                      context.read<AuthCubit>().forgotPassword(_emailController.text);
                    },
                  );
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}