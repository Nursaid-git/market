import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../core/widgets/gender_button.dart';
import '../cubit/intro/intro_cubit.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset('assets/images/intro_bg.png', fit: BoxFit.cover, width: double.infinity),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              margin: const EdgeInsets.all(15),
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text("Look Good, Feel Good", style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  const Text("Create your individual & unique style", style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 25),
                  BlocBuilder<IntroCubit, String?>(
                    builder: (context, selected) {
                      return Row(
                        children: [
                          GenderButton(text: "Men", isSelected: selected == 'men', onPressed: () => context.read<IntroCubit>().selectGender('men')),
                          const SizedBox(width: 10),
                          GenderButton(text: "Women", isSelected: selected == 'women', onPressed: () => context.read<IntroCubit>().selectGender('women')),
                        ],
                      );
                    },
                  ),
                  TextButton(onPressed: () {}, child: const Text("Skip", style: TextStyle(color: Colors.grey))),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}