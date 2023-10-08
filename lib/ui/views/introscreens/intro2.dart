import 'package:chatapp/constants/colors.dart';
import 'package:chatapp/constants/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';

class OnboardingTwo extends StatelessWidget {
  const OnboardingTwo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
              left: SizeConfig.screenWidth(context) * 0.1,
              right: SizeConfig.screenWidth(context) * 0.1,
              top: SizeConfig.screenWidth(context) * 0.3),
          child: Column(
            children: [
              Image.asset(
                "assets/images/introscreen.png",
              ),
              SizedBox(
                height: SizeConfig.screenHeight(context) * 0.05,
              ),
              Text(
                "Connect Beyond Words.",
                style: GoogleFonts.zillaSlab(
                    fontSize: SizeConfig.screenHeight(context) * 0.03,
                    fontWeight: FontWeight.normal),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
