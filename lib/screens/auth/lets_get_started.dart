import 'package:flutter/material.dart';

import '../../core/widgets/social_button.dart';
import '../../widgets/custom_button.dart';

class LetsGetStartedScreen extends StatelessWidget {
  const LetsGetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(), // Кнопка назад как на скрине
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text(
              "Let’s Get Started",
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 150), // Отступ до кнопок

            SocialButton(
              text: "Facebook",
              iconPath: "assets/icons/facebook.png",
              color: const Color(0xFF4267B2),
              onPressed: () {},
            ),
            const SizedBox(height: 10),
            SocialButton(
              text: "Twitter",
              iconPath: "assets/icons/twitter.png",
              color: const Color(0xFF1DA1F2),
              onPressed: () {},
            ),
            const SizedBox(height: 10),
            SocialButton(
              text: "Google",
              iconPath: "assets/icons/google.png",
              color: const Color(0xFFEA4335),
              onPressed: () {},
            ),

            const Spacer(),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account? ", style: TextStyle(color: Colors.grey)),
                GestureDetector(
                  onTap: () {}, // Переход на Login
                  child: const Text("Signin", style: TextStyle(fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            const SizedBox(height: 20),
            CustomButton(
              text: "Create an Account",
              onPressed: () {}, // Переход на Sign Up
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}