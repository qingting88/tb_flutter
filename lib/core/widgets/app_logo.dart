import 'package:flutter/material.dart';
import 'package:tb_flutter/core/constants/app_constants.dart';

class AppLogo extends StatelessWidget {
  final double size;

  const AppLogo({super.key, this.size = 40});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.star_border_rounded, size: size, color: Colors.white),
        const SizedBox(width: 8),
        Text(
          AppConstants.appName,
          style: TextStyle(
            color: Colors.white,
            fontSize: size * 0.5,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
