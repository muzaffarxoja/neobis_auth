import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool obscureText;
  final String? Function(String?)? validator;

  CustomTextFormField({
    required this.controller,
    required this.labelText,
    this.obscureText = false, // Default to not obscure text if not specified
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller, // Controller for managing the text input
      decoration: InputDecoration(
        labelText: labelText, // Label for the text field
        filled: true,
        fillColor: Color(0xfff8f8f8), // Background color
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12), // Border radius
          borderSide: BorderSide.none, // No border
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12), // Border radius
          borderSide: BorderSide.none, // No border
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12), // Border radius
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor, // Border color when focused
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12), // Border radius
          borderSide: BorderSide(
            color:
                Colors.red, // Border color when error occurs
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12), // Border radius
          borderSide: BorderSide(
            color: Colors.red, // Border color when focused and error occurs
          ),
        ),
      ),
      obscureText: obscureText, // Whether to obscure the text (for passwords)
      validator: validator, // Validator function for validating input
    );
  }
}
