import 'package:chatapp/constants/colors.dart';
import 'package:chatapp/constants/size.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomTextForm extends StatelessWidget {
  TextEditingController? controller;
  String? label;
  TextInputType? keyboard;
  String? content;
  String? Function(String?)? customValidator;
  CustomTextForm({
    required this.controller,
    this.keyboard,
    this.customValidator,
    required this.label,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboard,
      controller: controller,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
          // Increase the vertical padding to increase the height
          vertical: 20.0,
          horizontal: SizeConfig.screenWidth(context) * 0.05,
        ),
        labelText: label,
        hintText: content,
        hintStyle: GoogleFonts.inter(fontSize: 15, color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0),
          borderSide: BorderSide(color: AppColors.buttonColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40.0),
          borderSide: BorderSide(color: AppColors.buttonColor),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40.0),
          borderSide: BorderSide(color: Colors.red),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40.0),
          borderSide: BorderSide(color: AppColors.buttonColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(40.0),
          borderSide: BorderSide(color: AppColors.buttonColor),
        ),
      ),
      validator: customValidator ??
          (value) {
            if (value!.isEmpty) {
              return 'Field cannot be empty';
            }
            return null;
          },
    );
  }
}
