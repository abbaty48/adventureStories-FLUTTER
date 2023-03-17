import 'package:flutter/material.dart';

class Skeleton extends StatelessWidget {
  final double? width, height;
  final BorderRadius? borderRadius;
  final Color? color;
  final EdgeInsets? margin;
  final BoxBorder? border;
  const Skeleton(
      {super.key,
      this.width,
      this.height,
      this.borderRadius,
      this.color,
      this.margin,
      this.border});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
          border: border,
          borderRadius:
              borderRadius ?? const BorderRadius.all(Radius.circular(8.0)),
          color: color ?? Colors.black.withOpacity(0.04)),
    );
  }
}
