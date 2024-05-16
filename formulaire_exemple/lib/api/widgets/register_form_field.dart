import 'package:flutter/material.dart';

class RegisterFormField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String? Function(String?)? validator;

  const RegisterFormField({super.key, required this.controller, required this.label, required this.validator});


  @override
  State<StatefulWidget> createState() => RegisterFormFieldState();
}

class RegisterFormFieldState extends State<RegisterFormField>{

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      decoration: InputDecoration(
        labelText: widget.label,
        border: const OutlineInputBorder(),
        errorStyle: const TextStyle(color: Color.fromARGB(255, 196, 43, 160)),
        errorBorder: const OutlineInputBorder(
          borderSide:
          BorderSide(color: Color.fromARGB(255, 196, 43, 160)),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide:
          BorderSide(color: Color.fromARGB(255, 196, 43, 160)),
        ),
      ),
      validator: widget.validator
    );
  }

}