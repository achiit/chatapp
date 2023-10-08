import 'package:chatapp/constants/colors.dart';
import 'package:chatapp/constants/size.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;

  CustomElevatedButton({
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        fixedSize: Size(SizeConfig.screenWidth(context) * 0.85,
            SizeConfig.screenHeight(context) * 0.065),
        backgroundColor: AppColors.buttonColor, // Set your button color
        shape: RoundedRectangleBorder(
          borderRadius:
              BorderRadius.circular(SizeConfig.screenWidth(context) * 2),
        ),
      ),
      child: Text(
        text,
        style: GoogleFonts.podkova(
            color: AppColors.textcolor,
            fontSize: SizeConfig.screenHeight(context) * 0.02,
            fontWeight: FontWeight.normal),
      ),
    );
  }
}
