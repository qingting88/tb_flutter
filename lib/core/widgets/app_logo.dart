import 'package:flutter/material.dart';
import 'package:tb_flutter/core/widgets/svgo.dart';

class AppLogo extends StatelessWidget {
  final double size;

  const AppLogo({super.key, this.size = 40});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgIcons.logo
      ],
    );
  }
}
