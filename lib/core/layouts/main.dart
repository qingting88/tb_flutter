import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tb_flutter/core/config/app_constants.dart';
import 'package:tb_flutter/core/bloc/auth_cubit.dart';

class MainLayout extends StatefulWidget {
  final Widget child;
  
  const MainLayout({super.key, required this.child});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthUnauthenticatedState) {
          // 自动跳转由路由处理，这里可以添加额外逻辑
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: BlocBuilder<AuthCubit, AuthState>(
            builder: (context, state) {
              if (state is AuthenticatedState) {
                return Text('欢迎, ${state.user.name}');
              }
              return const Text('My App');
            },
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                context.go(AppConstants.settingsProfileRoute);
              },
            ),
          ],
        ),
        body: SafeArea(child: widget.child),
        bottomNavigationBar: _buildBottomNavigation(),
      ),
    );
  }

  Widget _buildBottomNavigation() {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is! AuthenticatedState) {
          return const SizedBox.shrink();
        }
        
        return BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() => _currentIndex = index);
            switch (index) {
              case 0:
                context.go('/home');
                break;
              case 1:
                context.go('/trade');
                break;
              case 2:
                context.go('/wallet');
                break;
            }
          },
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
              icon: Icon(Icons.person), label: 'Trade'),
            BottomNavigationBarItem(
              icon: Icon(Icons.message), label: 'Wallet'),
          ],
        );
      },
    );
  }
}