import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tb_flutter/core/bloc/tan_stack_cubit.dart';
import 'package:tb_flutter/core/config/app_constants.dart';
import 'package:tb_flutter/core/widgets/app_button.dart';
import 'package:tb_flutter/core/repository/user_repository.dart';
import 'package:tb_flutter/features/settings/widget/password_field.dart';

final hasLenChart = RegExp(r'^.{8,20}$');
final hasUppercase = RegExp(r'(?=.*?[A-Z])');
final hasLowercase = RegExp(r'(?=.*?[a-z])');
final hasDigit = RegExp(r'(?=.*?[0-9])');
final hasSpecial = RegExp(r'(?=.*?[^0-9a-zA-Z\n])');

class PasswordNewPage extends StatefulWidget {
  const PasswordNewPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _PasswordNewPageState();
  }
}

class _PasswordNewPageState extends State<PasswordNewPage> {
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
          context.go(AppConstants.loginRoute);
        }
      },
      child: Form(
        key: _formKey, //设置globalKey，用于后面获取FormState
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'Change Password',
                      style: Theme.of(
                        context,
                      ).textTheme.titleLarge?.copyWith(height: 1),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 16.0, bottom: 32.0),
                    child: Center(
                      child: Text(
                        'Setting up your new password',
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(height: 1.56),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  PasswordFields(
                    passwordController: _passwordController,
                    confirmPasswordController: _confirmPasswordController,
                    onValidationChanged: (isValid) {
                      setState(() {
                        _isPasswordValid = isValid;
                      });
                    },
                  ),
                ],
              ),
              BlocBuilder<TanStackCubit, TanStackState>(
                builder: (context, state) {
                  return ValueListenableBuilder<TextEditingValue>(
                    valueListenable: _confirmPasswordController,
                    builder: (context, passwordValue, _) {
                      return AppButton(
                        text: "SUBMIT",
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
    );
  }
}
