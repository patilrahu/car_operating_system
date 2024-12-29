import 'package:carcheckinout/widgets/app_text.dart';
import 'package:flutter/material.dart';

import 'app_loader.dart';

class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color? color;
  final Color? textColor;
  final double? borderRadius;
  final EdgeInsets? padding;
  final bool isLoading;
  final bool isDisable;

  const AppButton(
      {Key? key,
      required this.text,
      required this.onPressed,
      this.color,
      this.textColor,
      this.borderRadius = 64,
      this.padding,
      this.isLoading = false,
      this.isDisable = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      width: MediaQuery.of(context).size.width,
      height: 54,
      child: ElevatedButton(
        onPressed: isDisable ? null : onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 0,
          backgroundColor: Colors.black,
          // disabledBackgroundColor: HexColor(ColorConstant.pinkColor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
          ),
          padding: padding ??
              const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        ),
        child: isLoading
            ? const AppLoader(
                size: 30.0,
                strokeWidth: 3,
                color: Colors.white,
              )
            : AppText(
                text: text,
                color: Colors.white,
                fontSize: 16.0,
                fontWeight: FontWeight.w600,
              ),
      ),
    );
  }
}
