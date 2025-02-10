
import 'package:flutter/material.dart';

class Customtextfiled extends StatefulWidget {
  const Customtextfiled({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.validator,
    this.focusNode
  });

  final String? Function(String?)? validator;
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final FocusNode? focusNode;

  @override
  State<Customtextfiled> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<Customtextfiled> {
  late bool showobscure;

  @override
  void initState() {
    super.initState();
    showobscure = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: widget.focusNode,
      obscureText: showobscure,
      controller: widget.controller,
      decoration: InputDecoration(
        fillColor: Colors.grey[200],
        labelText: widget.hintText,
        filled: true,
        suffixIcon: widget.obscureText
            ? IconButton(
                onPressed: () {
                  setState(() {
                    showobscure = !showobscure;
                  });
                },
                icon: Icon(
                  showobscure ? Icons.remove_red_eye : Icons.visibility_off,
                ),
              )
            : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
      validator: widget.validator,
    );
  }
}
