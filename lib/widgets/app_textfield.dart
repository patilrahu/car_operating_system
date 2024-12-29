import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AppTextfield extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType? keyboardType;
  Widget? suffixIcon;
  bool? isObsecure;
  final List<TextInputFormatter>? inputFormatters;
  String? errorText;
  int? maxLength;
  int? maxLines;
  Color? fillColor;
  bool? isEnable = true;
  double? borderRadius;
  TextInputAction? textInputAction;
  final ValueChanged<String>? onSubmitted;
  AppTextfield(
      {super.key,
      required this.controller,
      required this.hintText,
      this.keyboardType,
      this.suffixIcon,
      this.inputFormatters,
      this.fillColor,
      this.isEnable,
      this.errorText = "",
      this.isObsecure = false,
      this.borderRadius = 50,
      this.maxLines = 1,
      this.maxLength,
      this.onSubmitted,
      this.textInputAction});

  @override
  State<AppTextfield> createState() => _AppTextfieldState();
}

class _AppTextfieldState extends State<AppTextfield> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            enabled: widget.isEnable,
            textInputAction: widget.textInputAction,
            onSubmitted: (value) {
              if (widget.onSubmitted != null) {
                widget.onSubmitted!(value);
              }
            },
            maxLines: widget.maxLines,
            maxLength: widget.maxLength,
            inputFormatters: widget.inputFormatters,
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            cursorColor: Colors.black,
            obscureText: widget.isObsecure ?? false,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            decoration: InputDecoration(
              counterText: "",
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 15, horizontal: 28),
              filled: true,
              fillColor: widget.fillColor ?? Colors.white,
              suffixIcon: widget.suffixIcon,
              hintText: widget.hintText,
              hintStyle:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(widget.borderRadius ?? 50),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(widget.borderRadius ?? 50),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(widget.borderRadius ?? 50),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(widget.borderRadius ?? 50),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(widget.borderRadius ?? 50),
              ),
              disabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.black),
                borderRadius: BorderRadius.circular(widget.borderRadius ?? 50),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
