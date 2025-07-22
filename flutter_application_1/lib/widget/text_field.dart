import 'package:flutter/material.dart';

/// A reusable custom text field widget.
/// Supports both regular text input and password input with visibility toggle.
class TextFieldInput extends StatefulWidget {
  final TextEditingController
      textEditingController; // Controller to manage the input text
  final String hintText;
  final bool isPass; // Determines if the field is for password input

  const TextFieldInput({
    super.key,
    required this.textEditingController,
    this.isPass = false,
    required this.hintText,
  });

  @override
  State<TextFieldInput> createState() => _TextFieldInputState();
}

class _TextFieldInputState extends State<TextFieldInput> {
  bool _isObscured = true; // Controls the visibility of the password text

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      child: TextField(
        style: const TextStyle(fontSize: 20),
        controller: widget.textEditingController,
        obscureText: widget.isPass
            ? _isObscured
            : false, // Obscure text only for password fields
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: const TextStyle(color: Colors.black45, fontSize: 18),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(10),
          ),
          border: InputBorder.none,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.blue, width: 2),
            borderRadius: BorderRadius.circular(10),
          ),
          filled: true,
          fillColor: Colors.grey.shade200,
          contentPadding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 20,
          ),
          suffixIcon: widget.isPass // Show suffix icon only for password fields
              ? GestureDetector(
                  onTap: () {
                    setState(() {
                      _isObscured = !_isObscured; // Toggle password visibility
                    });
                  },
                  child: Icon(
                    _isObscured ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey,
                  ),
                )
              : null, // No icon for non-password fields
        ),
      ),
    );
  }
}
