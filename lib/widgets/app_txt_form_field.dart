import 'package:flutter/material.dart';

class AppTxtFormField extends StatelessWidget {
  const AppTxtFormField(
      {super.key,
      this.controller,
      this.labelText,
      this.prefixIcon,
      required this.vertical,
      required this.horizontal,
      this.validator,
      required this.radiusValue});

  final TextEditingController? controller;
  final String? labelText;
  final Widget? prefixIcon;
  final double vertical;
  final double horizontal;
  final String? Function(String?)? validator;
  final double radiusValue;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: labelText,
          prefixIcon: prefixIcon,
          contentPadding:
              EdgeInsets.symmetric(vertical: vertical, horizontal: horizontal),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red.shade300),
            borderRadius: BorderRadius.all(
              Radius.circular(radiusValue),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.green),
            borderRadius: BorderRadius.all(
              Radius.circular(radiusValue),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.green.shade200),
            borderRadius: BorderRadius.all(
              Radius.circular(radiusValue),
            ),
          ),
          errorStyle: const TextStyle(color: Colors.redAccent),
        ),
        validator: validator,
      ),
    );
  }
}
