import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/theme/colors.dart';
import '../../core/widgets/laza_logo.dart';
import '../../cubit/splash/splash_cubit.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashStatus>(
      listener: (context, state) {
        if (state == SplashStatus.unauthenticated) {
          Navigator.pushReplacementNamed(context, '/intro'); // На Screen 02
        } else if (state == SplashStatus.authenticated) {
          Navigator.pushReplacementNamed(context, '/home');
        }
      },
      child: const Scaffold(
        backgroundColor: AppColors.primary,
        body: Center(child: LazaLogo()),
      ),
    );
  }
}