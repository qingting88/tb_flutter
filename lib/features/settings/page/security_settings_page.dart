import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tb_flutter/core/bloc/tan_stack_cubit.dart';
import 'package:tb_flutter/core/widgets/svgo.dart';
import 'package:tb_flutter/core/bloc/auth_cubit.dart';
import 'package:tb_flutter/features/settings/model/secure.dart';
import 'package:tb_flutter/features/settings/model/user.dart';
import 'package:tb_flutter/core/repository/user_repository.dart';

enum SwitchType { ga, email, phone }

class SecuritySettingsPage extends StatefulWidget {
  const SecuritySettingsPage({super.key});

  @override
  SecuritySettingsPageState createState() => SecuritySettingsPageState();
}

class SecuritySettingsPageState extends State<SecuritySettingsPage> {
  SwitchType switchType = SwitchType.ga;

  _onGaChange(bool value, ISecureSetting setting) {
    setState(() {
      switchType = SwitchType.ga;
    });
    func() => context.read<UserRepository>().useSetting2FAMutation(
      secureSetting: setting.copyWith(two_factor: value),
    );
    return context.read<TanStackCubit>().mutation(func);
  }

  _onEmailChange(bool value, ISecureSetting setting) {
    setState(() {
      switchType = SwitchType.email;
    });
    func() => context.read<UserRepository>().useSetting2FAMutation(
      secureSetting: setting.copyWith(email_verify: value),
    );
    return context.read<TanStackCubit>().mutation(func);
  }

  _onPhoneChange(bool value, ISecureSetting setting) {
    setState(() {
      switchType = SwitchType.phone;
    });
    func() => context.read<UserRepository>().useSetting2FAMutation(
      secureSetting: setting.copyWith(phone_verify: value),
    );
    return context.read<TanStackCubit>().mutation(func);
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<AuthCubit, AuthState, IUserInfo>(
      selector: (state) {
        return (state as AuthenticatedState).user;
        // return selected state based on the provided state.
      },
      builder: (context, user) {
        return Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text(
                  'Security Settings',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 40.0),
                child: Text(
                  'Two-Factor Authentication (2FA)',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 8, bottom: 48, left: 8, right: 8),
                child: Text(
                  'To protect your account, it is recommended to tun on at least one 2FA',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  spacing: 8,
                  children: [
                    SvgIcons.google,
                    Text(
                      'Google Autentication',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    SvgIcons.arrowBlackRight,
                    Spacer(),
                    BlocBuilder<TanStackCubit, TanStackState>(
                      builder: (context, state) {
                        return Switch(
                          value: user.extend.secure_setting.two_factor,
                          onChanged: (bool value) {
                            if (state.isLoading &&
                                switchType == SwitchType.ga) {
                              return;
                            }
                            _onGaChange(value, user.extend.secure_setting);
                          },
                        );
                        // return widget here based on BlocA's state
                      },
                    ),
                  ],
                ),
              ),
              const Divider(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  spacing: 8,
                  children: [
                    SvgIcons.email,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          spacing: 8,
                          children: [
                            Text(
                              'Email',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            SvgIcons.arrowBlackRight,
                          ],
                        ),
                        Text(
                          user.email,
                          style: Theme.of(context).textTheme.labelMedium,
                        ),
                      ],
                    ),
                    Spacer(),
                    BlocBuilder<TanStackCubit, TanStackState>(
                      builder: (context, state) {
                        return Switch(
                          value: user.extend.secure_setting.email_verify,
                          onChanged: (bool value) {
                            if (state.isLoading &&
                                switchType == SwitchType.email) {
                              return;
                            }
                            _onEmailChange(value, user.extend.secure_setting);
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
              const Divider(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  spacing: 8,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgIcons.smartphone,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          spacing: 8,
                          children: [
                            Text(
                              'SMS',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            SvgIcons.arrowBlackRight,
                          ],
                        ),
                        if (user.phone_country_code.isNotEmpty)
                          Text(
                            '${user.phone_country_code} ${user.phone_number}',
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                      ],
                    ),
                    Spacer(),
                    BlocBuilder<TanStackCubit, TanStackState>(
                      builder: (context, state) {
                        return Switch(
                          value: user.extend.secure_setting.phone_verify,
                          onChanged: (bool value) {
                            if (state.isLoading &&
                                switchType == SwitchType.phone) {
                              return;
                            }
                            _onPhoneChange(value, user.extend.secure_setting);
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
