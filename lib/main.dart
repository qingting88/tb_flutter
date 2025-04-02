import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tb_flutter/core/constants/app_constants.dart';
import 'package:tb_flutter/core/theme/app_theme.dart';
import 'package:tb_flutter/core/utils/router.dart';
import 'package:tb_flutter/features/auth/domain/entities/auth_state.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AuthState(),
      child: MaterialApp.router(
        title: AppConstants.appName,
        theme: AppTheme.lightTheme,
        routerConfig: appRouter,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
