import 'package:flutter/material.dart';

class SecondaryLayout extends StatelessWidget {
  final Widget child;

  const SecondaryLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(title: const Text('二级页面')), body: child);
  }
}
