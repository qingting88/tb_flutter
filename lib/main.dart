import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:tb_flutter/core/constants/app_constants.dart';
import 'package:tb_flutter/core/theme/app_theme.dart';
import 'package:tb_flutter/core/utils/router.dart';
import 'package:tb_flutter/features/auth/domain/entities/auth_state.dart';
import 'package:tb_flutter/modules/http/http_util.dart';

void main() {
  runApp(const MyApp());
  HttpUtil.instance.rebase('https://qa.treasurebox.com/v1');
  //设置Android头部的导航栏透明
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    );
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
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
