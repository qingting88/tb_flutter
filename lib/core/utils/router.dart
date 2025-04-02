import 'package:go_router/go_router.dart';
import 'package:tb_flutter/core/constants/app_constants.dart';
import 'package:tb_flutter/features/auth/presentation/pages/home_page.dart';
import 'package:tb_flutter/features/auth/presentation/pages/password_setup_page.dart';
import 'package:tb_flutter/features/auth/presentation/pages/registration_complete_page.dart';
import 'package:tb_flutter/features/auth/presentation/pages/sign_up_page.dart';
import 'package:tb_flutter/features/auth/presentation/pages/verification_page.dart';

final appRouter = GoRouter(
  initialLocation: AppConstants.signUpRoute,
  routes: [
    GoRoute(
      path: AppConstants.signUpRoute,
      builder: (context, state) => const SignUpPage(),
    ),
    GoRoute(
      path: AppConstants.verificationRoute,
      builder: (context, state) => const VerificationPage(),
    ),
    GoRoute(
      path: AppConstants.passwordSetupRoute,
      builder: (context, state) => const PasswordSetupPage(),
    ),
    GoRoute(
      path: AppConstants.registrationCompleteRoute,
      builder: (context, state) => const RegistrationCompletePage(),
    ),
    GoRoute(
      path: AppConstants.homeRoute,
      builder: (context, state) => const HomePage(),
    ),
  ],
);
