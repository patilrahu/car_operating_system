import 'package:flutter/material.dart';

class AppLoader extends StatelessWidget {
  final double? size;
  final Color? color;
  final double strokeWidth;

  const AppLoader({
    super.key,
    this.size,
    this.color,
    this.strokeWidth = 2.0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        color: color ?? Theme.of(context).primaryColor,
        strokeWidth: strokeWidth,
      ),
    );
  }
}
