import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tb_flutter/core/bloc/tan_stack_cubit.dart';
import 'package:tb_flutter/core/config/app_constants.dart';
import 'package:tb_flutter/core/repository/user_repository.dart';
import 'package:tb_flutter/core/widgets/app_button.dart';
import 'package:tb_flutter/core/widgets/app_logo.dart';
import 'package:tb_flutter/features/settings/widget/password_field.dart';

class SignUpPasswordPage extends StatefulWidget {
  const SignUpPasswordPage({super.key});

  @override
  State<SignUpPasswordPage> createState() => _PasswordSetupPageState();
}

class _PasswordSetupPageState extends State<SignUpPasswordPage> {
  final GlobalKey _formKey = GlobalKey<FormState>();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool _isPasswordValid = false;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  _onPressed(BuildContext context) {
    if ((_formKey.currentState as FormState).validate()) {
      func() => context.read<UserRepository>().usePasswordUpgradeMutation(
        password: _passwordController.text,
      );
      return context.read<TanStackCubit>().mutation(func);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TanStackCubit, TanStackState>(
      listener: (context, state) {
        // do stuff here based on BlocA's state
        if (state.isSuccess) {
          context.go(AppConstants.signUpCompleteRoute);
        }
      },
      child: Column(
        children: [
          const SizedBox(height: 40),
          const Center(child: AppLogo(size: 50)),
          const SizedBox(height: 60),
          Container(
            padding: const EdgeInsets.only(
              top: 36,
              left: 8,
              right: 8,
              bottom: 8,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(40),
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'Set Your Password',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: PasswordFields(
                      passwordController: _passwordController,
                      confirmPasswordController: _confirmPasswordController,
                      onValidationChanged: (isValid) {
                        setState(() {
                          _isPasswordValid = isValid;
                        });
                      },
                    ),
                  ),
                  const SizedBox(height: 30),
                  BlocBuilder<TanStackCubit, TanStackState>(
                    builder: (context, state) {
                      return ValueListenableBuilder<TextEditingValue>(
                        valueListenable: _confirmPasswordController,
                        builder: (context, passwordValue, _) {
                          return AppButton(
                            text: "NEXT",
                            disabled: !_isPasswordValid,
                            isLoading: state.isLoading,
                            onPressed: () => _onPressed(context),
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
