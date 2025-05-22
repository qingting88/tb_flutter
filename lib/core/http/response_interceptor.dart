import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tb_flutter/core/config/app_constants.dart';
import 'package:tb_flutter/core/http/token_storage.dart';
import 'package:tb_flutter/core/widgets/app_dialog.dart';
import 'package:tb_flutter/router.dart';

import 'http_model.dart';

// 拦截返回数据，进行统一处理
class ResponseInterceptors<T> extends Interceptor {
  final TokenStorage _tokenStorage;

  ResponseInterceptors(this._tokenStorage);

  @override
  onResponse(Response response, ResponseInterceptorHandler handler) async {
    final context = navigatorKey.currentContext;
    final json = DataT<Map<String, dynamic>>.fromJson(response.data);

    if (json is ErrorT) {
      final error = json;

      switch (error.code) {
        case CLIENT_ERROR_CODE.UNAUTHENTICATED:
          AppDialog.show(
            title: 'Login Status Invalid',
            content:
                'The current login status has expired, please log in again',
            btns: [
              DialogButton(
                text: 'Go to login',
                onClick: () {
                  _tokenStorage.clearTokens();
                  if (context != null) context.go(AppConstants.loginRoute);
                },
              ),
            ],
          );
          break;
        case CLIENT_ERROR_CODE.UNAUTHENTICATED_BY_DEVICE_CHANGE:
          AppDialog.show(
            title: 'Login Status Invalid',
            content: error.message,
            btns: [
              DialogButton(
                text: 'Go to login',
                onClick: () {
                  _tokenStorage.clearTokens();
                  if (context != null) context.go(AppConstants.loginRoute);
                },
              ),
            ],
          );
          break;
        case CLIENT_ERROR_CODE.USER_LOGIN_CREDENTIALS_INCORRECT:
          AppDialog.show(
            content: error.message,
            btns: [
              DialogButton(text: 'Cancel'),
              DialogButton(
                text: 'Forget Password',
                onClick: () {
                  if (context != null) {
                    context.go(AppConstants.forgotRoute);
                  }
                },
              ),
            ],
          );
          break;
        case CLIENT_ERROR_CODE.USER_EMAIL_NOT_EXIST:
          AppDialog.show(
            content: error.message,
            btns: [
              DialogButton(text: 'Cancel'),
              DialogButton(
                text: 'Sign Up',
                onClick: () {
                  if (context != null) {
                    context.go(AppConstants.signUpRoute);
                  }
                },
              ),
            ],
          );
          break;
        case CLIENT_ERROR_CODE.GOOGLE_2FA_UNSET:
          if (context != null) {
            context.go("/me/google");
          }
          break;
        case CLIENT_ERROR_CODE.PHONE_2FA_UNSET:
          if (context != null) {
            context.go("/me/phone");
          }
          break;
        case CLIENT_ERROR_CODE.AT_LEAST_OPEN_ONE_SECURE_SETTING ||
            CLIENT_ERROR_CODE.USER_NOT_SUPPORT_INSTITUTION ||
            CLIENT_ERROR_CODE.VERIFICATION_EVENT_INVALID ||
            CLIENT_ERROR_CODE.SYSTEM_FORBIDDEN_REGION ||
            CLIENT_ERROR_CODE.USER_EMAIL_NOT_EXIST:
          AppDialog.show(content: error.message);
          break;
        default:
          if (response.data is Map<String, dynamic>) {
            final data = response.data as Map<String, dynamic>;
            final modifiedData = {...data, 'intercepted': true};
            response.data = modifiedData;
          }
          break;
      }
      handler.resolve(response);
    } else {
      final data = json as SuccessT;
      switch (data.code) {
        case SUCCESS_CODE.UPGRADE_TOKEN:
          print("==========升级token========== ${data.data[0]['token']}");
          await _tokenStorage.saveTokens(data.data[0]['token']);
          break;
        case SUCCESS_CODE.USER_EMAIL_VERIFICATION_CODE_EXIST:
          if (context != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(data.message),
                duration: const Duration(milliseconds: 600),
                backgroundColor: Theme.of(context).primaryColor,
              ),
            );
          }

          break;
        case SUCCESS_CODE.LOGOUT:
          AppDialog.show(
            title: "Login Status Invalid",
            content:
                "The current login status has expired, please log in again",
            btns: [
              DialogButton(
                text: 'Go to login',
                onClick: () {
                  _tokenStorage.clearTokens();
                  if (context != null) context.go(AppConstants.loginRoute);
                },
              ),
            ],
          );
          break;
      }
      handler.next(response);
    }
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print('==========请求异常: ' + err.toString() + "==========");
    if (err.response != null) {
      print('==========请求异常信息: ' + err.response.toString() + "==========");
    }
    final context = navigatorKey.currentContext;
    if (context != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(err.response.toString()),
          duration: const Duration(milliseconds: 600),
          backgroundColor: Colors.red,
        ),
      );
    }
    return handler.next(err);
  }
}
