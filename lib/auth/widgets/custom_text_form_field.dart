import 'package:flutter/material.dart';
class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({super.key, required this.hintText,  this.onChanged, this.validator, this.obscureText = false, this.label, this.inputType, this.suffixIcon, required this.colorTheme, });
  final String hintText;
  final Function(String)? onChanged;
  final String? Function(String?)? validator;
  final bool? obscureText;
  final String? label;
  final TextInputType? inputType;
  final IconButton? suffixIcon;
  final Color colorTheme;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
            keyboardType: inputType,
            cursorColor: colorTheme,
            obscureText: obscureText!,
            validator: validator,
            onChanged: onChanged ,
            style:  TextStyle(color: colorTheme),
            decoration: InputDecoration(
              suffixIcon:suffixIcon ,
              hintText: hintText,
              hintStyle:  TextStyle(
                color: colorTheme,
              ),
              labelText: label,
              errorStyle:const TextStyle(color: Colors.red,),
              labelStyle: TextStyle(color: colorTheme),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color:  colorTheme),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color:  colorTheme),
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide:const BorderSide(color:  Colors.red),
              ),
            ),
          );
  }
}