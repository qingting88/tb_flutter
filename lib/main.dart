import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tb_flutter/core/bloc/tan_stack_cubit.dart';
import 'package:tb_flutter/core/config/app_constants.dart';
import 'package:tb_flutter/core/http/index.dart';
import 'package:tb_flutter/core/http/token_storage.dart';
import 'package:tb_flutter/core/config/app_theme.dart';
import 'package:tb_flutter/core/bloc/auth_cubit.dart';
import 'package:tb_flutter/core/repository/user_repository.dart';
import 'package:tb_flutter/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final tokenStorage = SecureTokenStorage();
  final httpService = HttpService(tokenStorage: tokenStorage);
  final UserRepository userRepository = UserRepository(httpService.dio);

  tokenStorage.clearTokens();

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: userRepository),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create:
                (context) => AuthCubit(
                  userRepository: context.read<UserRepository>(),
                  tokenStorage: tokenStorage,
                ),
          ),
          BlocProvider(create: (context) => TanStackCubit()),
        ],
        child: MyApp(),
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
