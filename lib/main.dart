import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tb_flutter/core/constants/app_constants.dart';
import 'package:tb_flutter/core/http/index.dart';
import 'package:tb_flutter/core/http/token_storage.dart';
import 'package:tb_flutter/core/theme/app_theme.dart';
import 'package:tb_flutter/features/auth/bloc/auth_cubit.dart';
import 'package:tb_flutter/features/auth/bloc/signin/bloc.dart';
import 'package:tb_flutter/features/auth/bloc/signup/bloc.dart';
import 'package:tb_flutter/features/auth/repository/auth_repository.dart';
import 'package:tb_flutter/features/settings/repository/user_repository.dart';
import 'package:tb_flutter/router.dart';

// void main() {
//   runApp(MyApp());
//   HttpUtil.instance.rebase('https://qa.treasurebox.com/v1');
//   //设置Android头部的导航栏透明
//   if (Platform.isAndroid) {
//     SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(
//       statusBarColor: Colors.transparent,
//     );
//     SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
//   }
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (_) => AuthState(),
//       child: MaterialApp.router(
//         title: AppConstants.appName,
//         theme: AppTheme.lightTheme,
//         routerConfig: appRouter,
//         debugShowCheckedModeBanner: false,
//       ),
//     );
//   }
// }

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final tokenStorage = SecureTokenStorage();
  final httpService = HttpService(tokenStorage: tokenStorage);
  final AuthRepository authRepository = AuthRepository(httpService.dio);
  final UserRepository userRepository = UserRepository(httpService.dio);

  tokenStorage.clearTokens();

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: authRepository),
        RepositoryProvider.value(value: userRepository),
      ],
      child: BlocProvider(
        create:
            (context) => AuthCubit(
              authRepository: context.read<AuthRepository>(),
              tokenStorage: tokenStorage,
            ),
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create:
                  (context) => SignInBloc(
                    authRepository: context.read<AuthRepository>(),
                    authCubit: context.read<AuthCubit>(),
                  ),
            ),
            BlocProvider(
              create:
                  (context) => SignUpBloc(
                    authRepository: context.read<AuthRepository>(),
                    authCubit: context.read<AuthCubit>(),
                  ),
            ),
          ],
          child: MyApp(),
        ),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouter = AppRouter(authCubit: context.read<AuthCubit>());
    return MaterialApp.router(
      routerConfig: appRouter.config,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      title: AppConstants.appName,
    );
  }
}
