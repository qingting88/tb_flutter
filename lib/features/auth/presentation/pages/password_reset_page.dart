import 'package:flutter/material.dart';
import 'package:tb_flutter/core/widgets/gradient_background.dart';

class PasswordResetPage extends StatefulWidget {
  const PasswordResetPage({Key? key}) : super(key: key);

  @override
  _PasswordResetPageState createState() => _PasswordResetPageState();
}

class _PasswordResetPageState extends State<PasswordResetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      body: GradientBackground(
        child: Center(child: Text('Password Reset Page')),
      ),
    );
  }
}
