import 'package:flutter/material.dart';
import 'package:tb_flutter/core/config/app_theme.dart';

class HorizontalStepper extends StatelessWidget {
  final int currentStep; // 当前步骤（从1开始）
  final int totalSteps; // 总步骤数

  const HorizontalStepper({
    super.key,
    required this.currentStep,
    required this.totalSteps,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(
        totalSteps * 2 - 1, // 步骤数 + 连接线数
        (index) {
          if (index.isOdd) {
            // 奇数索引：连接线
            final step = index ~/ 2 + 1;
            return Expanded(
              child: Container(height: 1, color: Color(0x340b042b)),
            );
          } else {
            // 偶数索引：步骤数字
            final step = index ~/ 2 + 1;
            final isActive = step == currentStep;
            final isActived = step < currentStep;
            return Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(20)),
                color:
                    isActive
                        ? AppTheme.secondaryColor
                        : isActived
                        ? AppTheme.successColor
                        : Color(0x340b042b),
              ),
              child: Center(
                child: Text(
                  '$step',
                  style: TextStyle(
                    color: Colors.white,
                    height: 1,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
