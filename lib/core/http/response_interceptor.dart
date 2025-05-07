import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:tb_flutter/core/constants/app_constants.dart';
import 'package:tb_flutter/core/http/token_storage.dart';
import 'package:tb_flutter/router.dart';

import 'http_model.dart';

class DialogButton {
  final String text;
  final Function? onClick;

  DialogButton({required this.text, this.onClick});
}

// 拦截返回数据，进行统一处理
class ResponseInterceptors<T> extends Interceptor {
  final TokenStorage _tokenStorage;

  ResponseInterceptors(this._tokenStorage);

  @override
  onResponse(Response response, ResponseInterceptorHandler handler) async {
    final context = navigatorKey.currentContext;
    final Map<String, dynamic> json =
        response.data is Map
            ? response.data as Map<String, dynamic>
            : throw DioException(
              requestOptions: response.requestOptions,
              error: 'Invalid response format',
            );
    print('==========请求结果:==========');
    print(json);

    if (json['status'] == 'error') {
      final error = ErrorT.fromJson(json);

      switch (error.code) {
        case CLIENT_ERROR_CODE.UNAUTHENTICATED:
          _showDialog(
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
          _showDialog(
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
          _showDialog(
            content: error.message,
            btns: [
              DialogButton(text: 'Cancel'),
              DialogButton(
                text: 'Forget Password',
                onClick: () {
                  if (context != null) {
                    context.go(AppConstants.forgotPasswordRoute);
                  }
                },
              ),
            ],
          );
          break;
        case CLIENT_ERROR_CODE.USER_EMAIL_NOT_EXIST:
          _showDialog(
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
          _showDialog(content: error.message);
          break;
        default:
          _showDialog(content: error.message);
          break;
      }

      throw DioException(
        requestOptions: response.requestOptions,
        response: Response(
          requestOptions: response.requestOptions,
          data: error,
        ),
        error: error.message,
      );
    } else if (json['status'] == "success") {
      final data = DataT.fromJson(json);
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
          _showDialog(
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
      print("zhixing");
      handler.next(response);
    }
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
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

  void _showDialog({
    String? title,
    required String content,
    List<DialogButton>? btns,
  }) {
    final overlayState = navigatorKey.currentState?.overlay;
    if (overlayState == null) return;
    showDialog(
      context: navigatorKey.currentContext!,
      builder:
          (ctx) => AlertDialog(
            title: title != null ? Text(title) : null,
            content: Text(content),
            actions: [
              if (btns != null)
                for (var btn in btns)
                  TextButton(
                    child: Text(btn.text),
                    onPressed: () {
                      if (btn.onClick != null) {
                        btn.onClick?.call();
                        Navigator.of(ctx).pop();
                      } else {
                        Navigator.of(ctx).pop();
                      }
                    },
                  ),
              if (btns == null)
                TextButton(
                  child: const Text('Got it'),
                  onPressed: () => Navigator.of(ctx).pop(),
                ),
            ],
          ),
    );
  }
}
