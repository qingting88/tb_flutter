import 'package:flutter/material.dart';
import 'package:tb_flutter/core/widgets/app_button.dart';
import 'package:tb_flutter/router.dart';

class DialogButton {
  final String text;
  final ButtonType? buttonType;
  final Function? onClick;

  DialogButton({required this.text, this.buttonType, this.onClick});
}

class AppDialog extends Dialog {
  final Widget? title;
  final Widget content;
  final bool? hasClosed;
  final List<Widget>? actions;

  const AppDialog({
    super.key,
    this.title,
    required this.content,
    this.actions,
    this.hasClosed,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Center(
        child: Container(
          constraints: BoxConstraints(maxWidth: 400),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(40),
          ),
          margin: EdgeInsets.only(left: 16, right: 16),
          padding: EdgeInsets.all(24),
          // color: Colors.white,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 24,
            children: [
              Stack(
                children: [
                  Align(child: title),
                  if (hasClosed != null)
                    Align(
                      alignment: Alignment.centerRight,
                      child: InkWell(
                        child: Icon(Icons.close),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                ],
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.all(0),
                alignment: Alignment.center,
                child: content,
              ),
              Row(spacing: 16, mainAxisAlignment: MainAxisAlignment.center, children: actions ?? []),
            ],
          ),
        ),
      ),
    );
  }

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
          (ctx) => AppDialog(
            title: title != null ? Text(title) : null,
            // insetPadding: EdgeInsets.all(50),
            // titlePadding: EdgeInsets.only(top: 24),
            // contentPadding: EdgeInsets.only(top: 24, left: 24, right: 24),
            // actionsPadding: EdgeInsets.all(24),
            content: Text(content),

            // shape: RoundedRectangleBorder(
            //   borderRadius: BorderRadius.circular(40),
            // ),
            actions: [
              if (btns != null)
                for (var btn in btns)
                  Expanded(
                    child: AppButton(
                      buttonType: btn.buttonType ?? ButtonType.primary,
                      onPressed: () {
                        if (btn.onClick != null) {
                          btn.onClick?.call();
                          Navigator.of(ctx).pop();
                        } else {
                          Navigator.of(ctx).pop();
                        }
                      },
                      text: btn.text,
                      buttonSize: ButtonSize.small,
                    ),
                  ),
              if (btns == null)
                AppButton(
                    onPressed: () => Navigator.of(ctx).pop(),
                    text: 'Got it',
                    buttonSize: ButtonSize.small,
                  )
            ],
          ),
    );
  }
}
