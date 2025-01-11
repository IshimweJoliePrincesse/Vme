import 'package:flutter/material.dart';
import 'package:electa/utils/app_colors.dart';

class LabelInputField extends StatelessWidget {
  const LabelInputField(
      {super.key,
      required this.label,
      required this.controller,
      this.disable = false,
      this.placeholder,
      this.maxLines,
      this.floatingLabelBehavior = FloatingLabelBehavior.auto,
      this.keyboardtype = TextInputType.text,
      this.borderRadius = 5,
      this.icon,
      this.validator,
      this.onChange});

  final String? label;
  final bool disable;
  final TextEditingController controller;
  final String? placeholder;
  final int? maxLines;
  final FloatingLabelBehavior floatingLabelBehavior;
  final Icon? icon;
  final double borderRadius;
  final TextInputType? keyboardtype;
  final String? Function(String?)? validator;
  final Function(String)? onChange;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        child: TextFormField(
          controller: controller,
          readOnly: disable,
          maxLines: maxLines,
          keyboardType: keyboardtype,
          validator: validator,
          onChanged: onChange,
          decoration: InputDecoration(
            contentPadding: const EdgeInsets.all(16),
            prefixIcon: icon,
            hintText: placeholder,
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide(color: primaryColor)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide(color: primaryColor)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: BorderSide(color: primaryColor, width: 2)),
            errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(borderRadius),
                borderSide: const BorderSide(color: Colors.red, width: 2)),
            floatingLabelAlignment: FloatingLabelAlignment.start,
            floatingLabelBehavior: floatingLabelBehavior,
            label: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text(label.toString())),
            labelStyle: const TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
