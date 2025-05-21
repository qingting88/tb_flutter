import 'dart:async';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tb_flutter/core/config/app_constants.dart';
import 'package:tb_flutter/core/layouts/main.dart';
import 'package:tb_flutter/core/layouts/secondary.dart';
import 'package:tb_flutter/core/layouts/unauth.dart';
import 'package:tb_flutter/core/bloc/auth_cubit.dart';
import 'package:tb_flutter/features/auth/page/forgot_password_page.dart';
import 'package:tb_flutter/features/auth/page/forgot_password_verification_page.dart';
import 'package:tb_flutter/features/home/page/home_page.dart';
import 'package:tb_flutter/features/auth/page/login_page.dart';
import 'package:tb_flutter/features/auth/page/signup/password_page.dart';
import 'package:tb_flutter/features/auth/page/signup/complete_page.dart';
import 'package:tb_flutter/features/auth/page/signup/index_page.dart';
import 'package:tb_flutter/features/auth/page/splash_page.dart';
import 'package:tb_flutter/features/auth/page/signup/verification_page.dart';
import 'package:tb_flutter/features/settings/page/google/step1_page.dart';
import 'package:tb_flutter/features/settings/page/google/step2_page.dart';
import 'package:tb_flutter/features/settings/page/google/step3_page.dart';
import 'package:tb_flutter/features/settings/page/google/step4_page.dart';
import 'package:tb_flutter/features/settings/page/password/new_page.dart';
import 'package:tb_flutter/features/settings/page/password/old_page.dart';
import 'package:tb_flutter/features/settings/page/profile_page.dart';
import 'package:tb_flutter/features/settings/page/security_settings_page.dart';
import 'package:tb_flutter/features/settings/page/two_fa_page.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class AppRouter {
  final AuthCubit _authCubit;

  AppRouter({required AuthCubit authCubit}) : _authCubit = authCubit {
    _authCubit.clean();
  }

  GoRouter get config => GoRouter(
    navigatorKey: navigatorKey,
    refreshListenable: GoRouterRefreshStream(_authCubit.stream),
    initialLocation: AppConstants.splashRoute,
    routes: [
      GoRoute(
        path: AppConstants.splashRoute,
        builder: (context, state) => const SplashPage(),
      ),

      GoRoute(
        path: AppConstants.signUpCompleteRoute,
        builder: (context, state) => const SignUpCompletePage(),
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
        builder: (context, state, child) => UnAuthLayout(child: child),
        routes: [
          GoRoute(
            path: AppConstants.loginRoute,
            builder: (context, state) => const LoginPage(),
          ),
          GoRoute(
            path: AppConstants.signUpRoute,
            builder: (context, state) => const SignUpPage(),
          ),
          GoRoute(
            path: AppConstants.signUpVerificationRoute,
            builder: (context, state) {
              final email = state.pathParameters['email'];
              return SignUpVerificationPage(email: email!);
            },
          ),
          GoRoute(
            path: AppConstants.signUpPasswordRoute,
            builder: (context, state) => const SignUpPasswordPage(),
          ),
        ],
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
      ShellRoute(
        builder: (context, state, child) => SecondaryLayout(child: child),
        routes: [
          GoRoute(
            path: AppConstants.settingsProfileRoute,
            builder: (context, state) => const ProfilePage(),
          ),
          GoRoute(
            path: AppConstants.settingsSecurityRoute,
            builder: (context, state) => const SecuritySettingsPage(),
          ),
          GoRoute(
            path: AppConstants.settingsGoogleStep1Route,
            builder: (context, state) => const GoogleStep1Page(),
          ),
          GoRoute(
            path: AppConstants.settingsGoogleStep2Route,
            builder: (context, state) => const GoogleStep2Page(),
          ),
          GoRoute(
            path: AppConstants.settingsGoogleStep3Route,
            builder: (context, state) => const GoogleStep3Page(),
          ),
          GoRoute(
            path: AppConstants.settingsGoogleStep4Route,
            builder: (context, state) => const GoogleStep4Page(),
          ),
          GoRoute(
            path: AppConstants.settings2faRoute,
            builder: (context, state) => const TwoFaPage(),
          ),
          GoRoute(
            path: AppConstants.settingsPasswordRoute,
            builder: (context, state) => const PasswordPage(),
          ),
          GoRoute(
            path: AppConstants.settingsPasswordNewRoute,
            builder: (context, state) => const PasswordNewPage(),
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
        AppConstants.signUpVerificationRoute,
        AppConstants.signUpPasswordRoute,
        AppConstants.signUpCompleteRoute,
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

      final home = AppConstants.homeRoute;

      // 如果正在加载中，不进行重定向
      if (authState is AuthLoading) return null;

      if (isSplash) {
        return isLoggedIn ? home : '/login';
      }

      // 已登录用户访问登录/注册页 → 首页
      if (isLoggedIn && isUnauthenticatedPath) {
        return home;
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
