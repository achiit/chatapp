import 'dart:developer';
import 'dart:ui';

import 'package:chatapp/constants/colors.dart';
import 'package:chatapp/constants/size.dart';
import 'package:chatapp/constants/spacing.dart';
import 'package:chatapp/data/providers/auth_provider.dart';
import 'package:chatapp/ui/views/auth%20screens/login.dart';
import 'package:chatapp/ui/widgets/authwidget/authform.dart';
import 'package:chatapp/ui/widgets/authwidget/topcontainer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends StatelessWidget {

  verifyPhone(BuildContext context, String number) {
    try {
      Provider.of<AuthProvider>(context, listen: false)
          .verifyPhone(number, context)
          .then((value) {
        //Navigator.of(context).pushNamed(VerifyScreen.routeArgs);
        log("done");
      }).catchError((e) {
        String errorMsg = 'Cant Authenticate you, Try Again Later';
        if (e.toString().contains(
            'We have blocked all requests from this device due to unusual activity. Try again later.')) {
          errorMsg = 'Please wait as you have used limited number request';
        }
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("done")));
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("$e")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                AuthScreenTop(
                  height: SizeConfig.screenHeight(context) * 0.25,
                  title: "Register",
                  subtitle: "Fill up your details to register.",
                ),
                50.verticalSpace,
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Column(
                        children: [
                          RegistrationForm(
                            verifyPhoneCallback: verifyPhone,
                            title: "Name",
                            content: "Enter your name",
                            title2: "Mobile",
                            content2: "Enter your mobile number",
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Already have an account?"),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LoginPage(),
                                    ),
                                  );
                                },
                                child: Text(
                                  "Login!",
                                  style: TextStyle(
                                    color: AppColors.buttonColor,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            if (Provider.of<AuthProvider>(context)
                .isOTPSent) // Check if OTP has been sent
              Container(
                color: Colors.transparent,
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Center(
                    child: Lottie.asset("assets/lottie/animation_lluo4f22.json",
                        height: 240),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
