import 'package:flutter/material.dart';

class CustomTextfield extends StatelessWidget {
  //pass controller for textfields such as email and password
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final Icon icon;
  final FormFieldValidator<String>? validator;

  const CustomTextfield({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.icon,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          suffixIcon: icon,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white10),
          ),
          fillColor: Colors.grey[100],
          filled: true,
          hintText: hintText,
          hintStyle: const TextStyle(color: Colors.black),
        ),
        validator: validator,
      ),
    );
  }
}
