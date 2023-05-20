import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
    this.isPassword = false,
    this.title = '',
    this.prefixIcon,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.initialValue,
    this.readOnly = false,
    this.validator,
    this.controller,
    this.onSaved,
    this.formKey,
  });

  final TextEditingController? controller;
  final bool isPassword;
  final String title;
  final IconData? prefixIcon;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? initialValue;
  final bool readOnly;
  final String? Function(String?)? validator;
  final void Function(String?)? onSaved;
  final GlobalKey<FormFieldState>? formKey;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool obscureText = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: TextFormField(
        key: widget.formKey,
        controller: widget.controller,
        validator: widget.validator,
        readOnly: widget.readOnly,
        onSaved: widget.onSaved,
        initialValue: widget.initialValue,
        inputFormatters: widget.inputFormatters,
        keyboardType: TextInputType.text,
        obscureText: widget.isPassword ? !obscureText : false,
        decoration: InputDecoration(
          isDense: true,
          prefixIcon: Icon(widget.prefixIcon),
          labelText: widget.title,
          suffixIcon: widget.isPassword
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      obscureText = !obscureText;
                    });
                  },
                  icon: obscureText ? const Icon(Icons.visibility) : const Icon(Icons.visibility_off_outlined))
              : null,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
    );
  }
}
