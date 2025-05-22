import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tb_flutter/core/bloc/tan_stack_cubit.dart';
import 'package:tb_flutter/core/config/app_constants.dart';
import 'package:tb_flutter/core/repository/user_repository.dart';
import '../../../../../core/utils/validators.dart';
import '../../../../../core/widgets/app_button.dart';
import '../../../../../core/widgets/app_logo.dart';
import '../../../../../core/widgets/app_text_field.dart';

class ForgotPage extends StatefulWidget {
  const ForgotPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ForgotPasswordPageState();
  }
}

class _ForgotPasswordPageState extends State<ForgotPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  void _handleNext(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text;
      func() => context.read<UserRepository>().useForgotMutation(email: email);
      return context.read<TanStackCubit>().mutation(func);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<TanStackCubit, TanStackState>(
      listener: (context, state) {
        if (state.isSuccess) {
          final email = _emailController.text;
          context.go(
            AppConstants.forgotEmailRoute.replaceAll(":email", email),
          );
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
              onChanged: () => context.read<TanStackCubit>().reset(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Text(
                      'Forgot Password',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  const SizedBox(height: 32),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12),
                    child: AppTextField(
                      hintText: 'Email',
                      controller: _emailController,
                      keyboardType: TextInputType.emailAddress,
                      validator: Validators.validateEmail,
                    ),
                  ),
                  const SizedBox(height: 48),
                  BlocBuilder<TanStackCubit, TanStackState>(
                    builder: (_, state) {
                      return AppButton(
                        text: 'NEXT',
                        isLoading: state.isLoading,
                        onPressed: () => _handleNext(context),
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
