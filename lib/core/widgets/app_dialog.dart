import 'package:flutter/material.dart';
import 'package:tb_flutter/core/widgets/app_button.dart';
import 'package:tb_flutter/router.dart';

class DialogButton {
  final String text;
  final Function? onClick;

  DialogButton({required this.text, this.onClick});
}

class AppDialog {
  static void show({
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
            insetPadding: EdgeInsets.all(50),
            titlePadding: EdgeInsets.only(top: 24),
            contentPadding: EdgeInsets.only(top: 24, left: 24, right: 24),
            actionsPadding: EdgeInsets.all(24),
            content: Text(content),

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
            actions: [
              Row(
                children: [
                  Expanded(
                    // 让两个按钮均分宽度
                    child: AppButton(onPressed: () {}, text: 'Close'),
                  ),
                  const SizedBox(width: 10), // 添加间距
                  Expanded(child: AppButton(onPressed: () {}, text: ('OK'))),
                ],
              ),
            ],
          ),
    );
  }
}
