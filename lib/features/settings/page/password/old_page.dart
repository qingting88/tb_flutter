import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tb_flutter/core/bloc/tan_stack_cubit.dart';
import 'package:tb_flutter/core/config/app_constants.dart';
import 'package:tb_flutter/core/widgets/app_button.dart';
import 'package:tb_flutter/core/widgets/app_text_field.dart';
import 'package:tb_flutter/core/repository/user_repository.dart';

class PasswordPage extends StatefulWidget {
  const PasswordPage({super.key});
  @override
  State<StatefulWidget> createState() {
    return _PasswordPageState();
  }
}

class _PasswordPageState extends State<PasswordPage> {
  final _passportController = TextEditingController();
  final GlobalKey _formKey = GlobalKey<FormState>();

  _onPressed(BuildContext context) {
    if ((_formKey.currentState as FormState).validate()) {
      func() => context.read<UserRepository>().useOldPasswordVerifyMutation(
        password: _passportController.text,
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
          context.go(AppConstants.settingsPasswordNewRoute);
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
                        'Verify your old password',
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium?.copyWith(height: 1.56),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8),
                    child: AppTextField(
                      autofocus: true,
                      hintText: 'Enter old password',
                      controller: _passportController,
                      keyboardType: TextInputType.emailAddress,
                      obscureText: true,
                      validator: (v) {
                        return v!.trim().isNotEmpty ? null : "密码不能为空";
                      },
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      context.go(AppConstants.forgotPasswordRoute);
                    },
                    child: Padding(
                      padding: EdgeInsets.only(top: 40.0),
                      child: Center(
                        child: Text(
                          'Forgot your password?',
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              BlocBuilder<TanStackCubit, TanStackState>(
                builder: (context, state) {
                  return ValueListenableBuilder<TextEditingValue>(
                    valueListenable: _passportController,
                    builder: (context, passwordValue, _) {
                      return AppButton(
                        text: "NEXT",
                        disabled: passwordValue.text.isEmpty,
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
