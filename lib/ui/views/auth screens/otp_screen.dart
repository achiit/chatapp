import 'dart:async';
import 'dart:developer';

import 'package:chatapp/constants/colors.dart';
import 'package:chatapp/constants/size.dart';
import 'package:chatapp/constants/spacing.dart';
import 'package:chatapp/data/providers/auth_provider.dart';
import 'package:chatapp/ui/views/auth%20screens/registration.dart';
import 'package:chatapp/ui/widgets/authwidget/topcontainer.dart';
import 'package:chatapp/ui/widgets/custombutton.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:pinput/pinput.dart';
import 'package:provider/provider.dart';

class OTPScreen extends StatefulWidget {
// Add this line

  const OTPScreen({super.key});

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  bool _isResendButtonEnabled = false;
  int _resendCooldown = 30; // Initial cooldown duration in seconds
  Timer? _resendTimer;
  final TextEditingController _pinController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _startResendCooldown();
  }

  @override
  void dispose() {
    _resendTimer?.cancel();
    super.dispose();
  }

  void _startResendCooldown() {
    _resendTimer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _resendCooldown -= 1;
        if (_resendCooldown <= 0) {
          _resendTimer?.cancel();
          _isResendButtonEnabled = true;
        }
      });
    });
  }

  final defaultPinTheme = PinTheme(
    width: 70,
    height: 70,
    textStyle: TextStyle(
        fontSize: 20,
        color: Color.fromRGBO(30, 60, 87, 1),
        fontWeight: FontWeight.w600),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.black),
      borderRadius: BorderRadius.circular(20),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Colors.black),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        color: Color.fromRGBO(234, 239, 243, 1),
      ),
    );
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              AuthScreenTop(
                height: SizeConfig.screenHeight(context) * 0.29,
                title: "OTP Verification",
                subtitle:
                    "Please enter your correct OTP for number verification process.",
              ),
              150.verticalSpace,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Pinput(
                  controller: _pinController,
                  length: 6,
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: focusedPinTheme,
                  submittedPinTheme: submittedPinTheme,
                  pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                  showCursor: true,
                  onCompleted: (pin) => print(pin),
                ),
              ),
              20.verticalSpace,
              CustomElevatedButton(
                  text: "Verify",
                  onPressed: _pinController.text.length == 6
                      ? () {
                          Provider.of<AuthProvider>(context, listen: false)
                          //ADDED THE CONTEXT
                              .verifyOTP(context,_pinController.text);
                        }
                      : null),
              _buildResendButton(),
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegistrationScreen()),
                            (route) => false);
                      },
                      child: Text(
                        "Enter different number",
                        style: TextStyle(
                          color: AppColors.buttonColor,
                          decoration: TextDecoration.underline,
                          decorationColor: AppColors.buttonColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildResendButton() {
    final phoneNumber = context.watch<AuthProvider>().phoneNumber;
    if (_isResendButtonEnabled) {
      return Padding(
        padding: const EdgeInsets.only(right: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              onPressed: () {
                log("${phoneNumber}");
                final authProvider =
                    Provider.of<AuthProvider>(context, listen: false);
                authProvider.verifyPhone(phoneNumber.toString(), context);
                setState(() {
                  _isResendButtonEnabled = false;
                  _resendCooldown = 30;
                  _startResendCooldown();
                });

                // TODO: Implement your resend code logic
              },
              child: Text(
                "Resend Code",
                style: TextStyle(
                  color: AppColors.buttonColor,
                  decoration: TextDecoration.underline,
                  decorationColor: AppColors.buttonColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return Text(
        "Resend in $_resendCooldown seconds",
        style: TextStyle(
          color: Colors.grey,
        ),
      );
    }
  }
}
