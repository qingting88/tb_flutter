import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'http_model.dart';

// export type ErrorT = {
//   code: CLIENT_ERROR_CODE | SERVER_ERROR_CODE;
//   message: string;
//   success: "success" | "error";
//   errors: Record<string, any>[];
// };

// export interface DataT<T> {
//   data: T;
//   code: SUCCESS_CODE;
//   message: string;
//   success: "success" | "error";
// }

// 拦截返回数据，进行统一处理
class ResponseInterceptors<T> extends Interceptor {
  final BuildContext context;
  ResponseInterceptors(this.context);
  @override
  onResponse(Response response, ResponseInterceptorHandler handler) async {
    final Map<String, dynamic> json =
        response.data is Map
            ? response.data as Map<String, dynamic>
            : throw DioException(
              requestOptions: response.requestOptions,
              error: 'Invalid response format',
            );
    
    if (json['status'] == 'error') {
      final error = ErrorT.fromJson(json);
      // throw DioException(
      //   requestOptions: response.requestOptions,
      //   response: Response(requestOptions: response.requestOptions, data: error),
      //   error: error.message,
      // );
      // switch (error.code) {
      //     case CLIENT_ERROR_CODE.UNAUTHENTICATED:
      //       modal.show({
      //         title: "Login Status Invalid",
      //         content:
      //           "The current login status has expired, please log in again",
      //         btns: [
      //           {
      //             text: "Go to login",
      //             onClick: () => {
      //               userIdentity.clear();
      //               router.push("/login");
      //             },
      //           },
      //         ],
      //       });
      //       break;
      //     case CLIENT_ERROR_CODE.UNAUTHENTICATED_BY_DEVICE_CHANGE:
      //       modal.show({
      //         title: "Login Status Invalid",
      //         content: response.data.message,
      //         btns: [
      //           {
      //             text: "Got it",
      //             onClick: () => {
      //               userIdentity.clear();
      //               router.push("/");
      //             },
      //           },
      //         ],
      //       });
      //       break;
      //     case CLIENT_ERROR_CODE.USER_LOGIN_CREDENTIALS_INCORRECT:
      //       modal.show({
      //         content: response.data.message,
      //         btns: [
      //           {
      //             text: "Cancel",
      //           },
      //           {
      //             text: "Forget Password",
      //             onClick: () => {
      //               router.push("/forgot");
      //             },
      //           },
      //         ],
      //       });
      //       _data.message = "";
      //       break;
      //     case CLIENT_ERROR_CODE.USER_EMAIL_NOT_EXIST:
      //       modal.show({
      //         content: response.data.message,
      //         btns: [
      //           {
      //             text: "Cancel",
      //           },
      //           {
      //             text: "Sign Up",
      //             onClick: () => {
      //               router.push("/signup");
      //             },
      //           },
      //         ],
      //       });
      //       _data.message = "";
      //       break;
      //     case CLIENT_ERROR_CODE.GOOGLE_2FA_UNSET:
      //       router.push("/me/google");
      //       break;
      //     case CLIENT_ERROR_CODE.PHONE_2FA_UNSET:
      //       router.push("/me/phone");
      //       break;
      //     case CLIENT_ERROR_CODE.AT_LEAST_OPEN_ONE_SECURE_SETTING:
      //     case CLIENT_ERROR_CODE.USER_NOT_SUPPORT_INSTITUTION:
      //     case CLIENT_ERROR_CODE.VERIFICATION_EVENT_INVALID:
      //     case CLIENT_ERROR_CODE.SYSTEM_FORBIDDEN_REGION:
      //       // case CLIENT_ERROR_CODE.USER_EMAIL_NOT_EXIST:
      //       modal.show({
      //         content: response.data.message,
      //       });
      //       _data.message = "";
      //       break;
      //     default:
      //       console.log("capture", capture);
      //       if (!capture) {
      //         modal.show({
      //           content: response.data.message,
      //         });
      //         _data.message = "";
      //       }
      //       break;
      //   }
        // console.log("Promise.reject(_data)", _data);
    }

     // 3. 成功数据处理
      final data = DataT<dynamic>.fromJson(json, (data) => data);
      // handler.next(response.copyWith(data: data));
      handler.next(response);

    // RequestOptions option = response.request;

    // if (option.contentType != null && option.contentType.contains("text")) {
    //   // return TaskResult<T>(data: response.data, success: true);
    //   super.onResponse(response, handler);
    // }

    // ///一般只需要处理200的情况，300、400、500保留错误信息，外层为http协议定义的响应码
    // if (response.statusCode == 200 || response.statusCode == 201) {
    //   ///内层需要根据公司实际返回结构解析，一般会有code，data，msg字段
    //   bool status = response.data["status"];
    //   String msg = response.data["msg"];
    //   var result = response.data;
    //   // return TaskResult<T>(
    //   //   data: result,
    //   //   status: status,
    //   //   msg: msg,
    //   // );
    // }
    // print("==========>");
    // print(response.data.toString());
    // print("==========>");
    // super.onResponse(response, handler);
  }

  @override
  Future onError(DioException err, ErrorInterceptorHandler handler) async {
    // print(
    //   'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}',
    // );
    super.onError(err, handler);
  }
}
