import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String label;
  final String hintText;
  final Widget prefixIcon;
  final String? errorText;
  final int? maxLines;

  const CustomTextField({
    super.key,
    required this.textEditingController,
    required this.label,
    required this.hintText,
    required this.prefixIcon,
    this.errorText,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: textEditingController,
      decoration: InputDecoration(
        label: Text(label),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
        prefixIcon: prefixIcon,
        hintText: hintText,
        errorText: errorText,
      ),
      maxLines: maxLines,
    );
  }
}
