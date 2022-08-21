import 'package:flutter/material.dart';

class AppTextField extends StatefulWidget {
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final String? helperText;
  final String? hintText;
  final String? Function(String?)? validator;
  final Function(String?)? onChanged;

  const AppTextField({
    Key? key,
    this.controller,
    this.focusNode,
    this.hintText,
    this.helperText,
    this.validator,
    this.onChanged,
  }) : super(key: key);

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      style: _style,
      decoration: _decoration,
      validator: widget.validator,
      onChanged: widget.onChanged,
    );
  }

  TextStyle get _style => Theme.of(context).textTheme.bodyMedium!;

  InputDecoration get _decoration => InputDecoration(
        hintText: widget.hintText,
        helperText: widget.helperText,
        border: InputBorder.none,
        filled: true,
        fillColor: Colors.white70,
        helperStyle: Theme.of(context).textTheme.bodySmall,
      );
}
