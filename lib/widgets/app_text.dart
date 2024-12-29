import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class AppText extends StatefulWidget {
  String text;
  final double? fontSize;
  final String? fontFamily;
  final FontWeight? fontWeight;
  final Color? color;
  final TextAlign? textAlign;
  final int? maxLines;
  final TextOverflow? overflow;
  AppText({
    super.key,
    required this.text,
    this.fontSize,
    this.fontFamily,
    this.fontWeight,
    this.color,
    this.textAlign,
    this.maxLines,
    this.overflow,
  });

  @override
  State<AppText> createState() => _AppTextState();
}

class _AppTextState extends State<AppText> {
  @override
  Widget build(BuildContext context) {
    return Text(
      widget.text,
      style: TextStyle(
        fontSize: widget.fontSize,
        fontFamily: widget.fontFamily ?? GoogleFonts.poppins().fontFamily,
        fontWeight: widget.fontWeight,
        color: widget.color ?? Colors.black,
      ),
      textAlign: widget.textAlign,
      maxLines: widget.maxLines,
      overflow: widget.overflow,
    );
  }
}
