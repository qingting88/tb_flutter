import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tb_flutter/core/constants/app_constants.dart';
import 'package:tb_flutter/core/layouts/main.dart';
import 'package:tb_flutter/features/auth/bloc/auth_cubit.dart';
import 'package:tb_flutter/features/auth/bloc/auth_state.dart';
import 'package:tb_flutter/features/auth/page/forgot_password_page.dart';
import 'package:tb_flutter/features/auth/page/forgot_password_verification_page.dart';
import 'package:tb_flutter/features/home/page/home_page.dart';
import 'package:tb_flutter/features/auth/page/login_page.dart';
import 'package:tb_flutter/features/auth/page/password_setup_page.dart';
import 'package:tb_flutter/features/auth/page/registration_complete_page.dart';
import 'package:tb_flutter/features/auth/page/sign_up_page.dart';
import 'package:tb_flutter/features/auth/page/splash_page.dart';
import 'package:tb_flutter/features/auth/page/verification_page.dart';

class AppRouter {
  final AuthCubit _authCubit;

  AppRouter({required AuthCubit authCubit}) : _authCubit = authCubit {
    _authCubit.clean();
  }

  GoRouter get config => GoRouter(
    refreshListenable: GoRouterRefreshStream(_authCubit.stream),
    initialLocation: AppConstants.splashRoute,
    routes: [
      GoRoute(
        path: AppConstants.splashRoute,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: AppConstants.loginRoute,
        builder: (context, state) => const LoginPage(),
      ),
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
        path: AppConstants.forgotPasswordRoute,
        builder: (context, state) => const ForgotPasswordPage(),
      ),
      GoRoute(
        path: AppConstants.forgotPasswordVerificationRoute,
        builder: (context, state) => const ForgotPasswordVerificationPage(),
      ),
      ShellRoute(
        builder: (context, state, child) => MainLayout(child: child),
        routes: [
          GoRoute(
            path: AppConstants.homeRoute,
            builder: (context, state) => const HomePage(),
          ),
        ],
      ),
    ],
    redirect: (BuildContext context, GoRouterState state) {
      final authState = _authCubit.state;
      final isLoggedIn = authState is AuthenticatedState;
      // final isLoggingIn = state.fullPath == '/login';
      final isSplash = state.fullPath == AppConstants.splashRoute;
      final currentLocation = state.fullPath!;

      // 定义不需要认证的路径
      const unauthenticatedPaths = [
        AppConstants.signUpRoute,
        AppConstants.verificationRoute,
        AppConstants.passwordSetupRoute,
        AppConstants.registrationCompleteRoute,
        AppConstants.forgotPasswordRoute,
        AppConstants.forgotPasswordVerificationRoute,
        AppConstants.loginRoute,
      ];
      final isUnauthenticatedPath = unauthenticatedPaths.any(
        currentLocation.startsWith,
      );

      print(
        "登陆状态 $isLoggedIn 当前路径 ${state.fullPath} authState: ${authState.toString()} isUnauthenticatedPath: $isUnauthenticatedPath",
      );

      // 如果正在加载中，不进行重定向
      if (authState is AuthLoading) return null;

      if (isSplash) {
        return isLoggedIn ? '/home' : '/login';
      }

      // 已登录用户访问登录/注册页 → 首页
      if (isLoggedIn && isUnauthenticatedPath) {
        return '/home';
      }

      // 未登录用户访问需要认证的页 → 登录页（携带原始目标）
      if (!isLoggedIn && !isUnauthenticatedPath) {
        return '/login?from=${Uri.encodeComponent(currentLocation)}';
      }

      return null;
    },
  );
}

// 使 Bloc 流兼容 GoRouter 的 refreshListenable
class GoRouterRefreshStream extends ChangeNotifier {
  GoRouterRefreshStream(Stream<dynamic> stream) {
    notifyListeners();
    _subscription = stream.asBroadcastStream().listen(
      (dynamic _) => notifyListeners(),
    );
  }

  late final StreamSubscription<dynamic> _subscription;

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
