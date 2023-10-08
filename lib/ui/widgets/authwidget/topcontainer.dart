import 'package:chatapp/constants/colors.dart';
import 'package:chatapp/constants/size.dart';
import 'package:chatapp/constants/spacing.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthScreenTop extends StatelessWidget {
  String title;
  String subtitle;
  double height;
  AuthScreenTop({
    required this.height,
    required this.title,
    required this.subtitle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.buttonColor, // Change the color as needed
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30.0), // Adjust the radius as needed
          bottomRight: Radius.circular(30.0), // Adjust the radius as needed
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 14.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            30.verticalSpace,
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white,
                size: 35,
              ),
            ),
            Text(
              title,
              textAlign: TextAlign.start,
              style: GoogleFonts.inter(
                  color: AppColors.textcolor,
                  fontSize: SizeConfig.screenHeight(context) * 0.04,
                  fontWeight: FontWeight.normal),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                subtitle,
                textAlign: TextAlign.start,
                style: GoogleFonts.inter(
                    color: AppColors.textcolor,
                    fontSize: SizeConfig.screenHeight(context) * 0.017,
                    fontWeight: FontWeight.normal),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
