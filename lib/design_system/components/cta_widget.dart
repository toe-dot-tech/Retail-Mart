import 'package:flutter/material.dart';
import 'package:retail_mart/design_system/tokens/colors.dart';

class CtaWidget extends StatelessWidget {
  final double? height;
  final double? width;
  final BorderRadius? borderRadius;
  final GestureTapCallback? onTap;
  final Widget child;
  const CtaWidget({
    super.key,
    this.height,
    required this.child,
    this.width,
    this.onTap,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      enableFeedback: true,
      child: Container(
        height: height ?? 68,
        width: width ?? double.infinity,
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: borderRadius ?? BorderRadius.circular(24),
        ),
        child: child,
      ),
    );
  }
}
