import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:untitled2/cubit/home/home_cubit.dart';
import 'package:untitled2/cubit/product/product_detail_cubit.dart';
import 'package:untitled2/cubit/review/review_cubit.dart';
import 'package:untitled2/screens/add_review_screen.dart';
import 'package:untitled2/screens/auth/forgot_password_screen.dart';
import 'package:untitled2/screens/auth/lets_get_started.dart';
import 'package:untitled2/screens/auth/login_screen.dart';
import 'package:untitled2/screens/auth/sign_up_screen.dart';
import 'package:untitled2/screens/auth/splash_screen.dart';
import 'package:untitled2/screens/home_screen.dart';
import 'package:untitled2/screens/intro_screen.dart';
import 'package:untitled2/screens/product_detail_screen.dart';
import 'package:untitled2/screens/review_screen.dart';
import 'package:untitled2/service/auth_service.dart';
import 'package:untitled2/service/review_service.dart';
import 'package:untitled2/test/cubit/test_cubit.dart';
import 'package:untitled2/test/service/test_service.dart';
import 'package:untitled2/test/test_screen.dart';

import 'cubit/auth/auth_cubit.dart';
import 'cubit/intro/intro_cubit.dart';
import 'cubit/splash/splash_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://bfvzyzzviecsdhmxzwkc.supabase.co',
    anonKey:
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImJmdnp5enp2aWVjc2RobXh6d2tjIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzYyNDQwODAsImV4cCI6MjA5MTgyMDA4MH0.5aoQkA8CulA5g1tbKl8IXAuojUhQmlx1AEDZUwCZU9s',
  );

  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AuthCubit(),
        ),
        // Внутри MultiBlocProvider в файле main.dart:
        BlocProvider(
          // Добавляем ..loadProducts() для автоматического вызова функции загрузки
          create: (context) => HomeCubit()..loadProducts(),
        ),
        BlocProvider(
            create: (context) => IntroCubit()
        ),
        BlocProvider(
            create: (context) => SplashCubit()
        ),
        BlocProvider(create: (context) => TestCubit(TestService()
        ),),
        BlocProvider(create: (context) => ReviewCubit(ReviewService())),

      ],
      child: MaterialApp(
        routes: {
          '/': (context) => const SignUpScreen(),
          '/login': (context) => const LoginScreen(),
          '/forgot_password': (context) => const ForgotPasswordScreen(),
          '/home': (context) => const HomeScreen(),
          '/product_detail': (context) => const ProductDetailScreen(),
          '/test': (context) => const TestScreen(),
          '/add_review': (context) {
            // 1. Безопасно достаем ID товара из аргументов перехода
            final args = ModalRoute.of(context)?.settings.arguments;
            final productId = (args is String) ? args : '';

            // 2. Передаем этот ID в конструктор экрана создания отзыва
            return AddReviewScreen(productId: productId);
          },
          '/review': (context) {
            // Безопасно получаем аргументы роута
            final args = ModalRoute.of(context)?.settings.arguments;

            // Если аргументов нет или они не String, подставляем пустую строку ''
            final productId = (args is String) ? args : '';

            print("==== ТЕСТ РОУТА: В main.dart прилетел ID: '$productId' ====");

            return ReviewsScreen(productId: productId);
          },
        },
      ),
    );
  }
}