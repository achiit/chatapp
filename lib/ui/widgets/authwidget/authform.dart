import 'dart:async';
import 'dart:developer';
import 'dart:ui';

import 'package:chatapp/constants/colors.dart';
import 'package:chatapp/constants/size.dart';
import 'package:chatapp/constants/spacing.dart';
import 'package:chatapp/data/providers/auth_provider.dart';
import 'package:chatapp/ui/views/auth%20screens/otp_screen.dart';
import 'package:chatapp/ui/views/auth%20screens/registration.dart';
import 'package:chatapp/ui/widgets/custombutton.dart';
import 'package:chatapp/ui/widgets/customtextformfield.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';

typedef void VerifyPhoneCallback(BuildContext context, String phoneNumber);

class RegistrationForm extends StatefulWidget  {
  String? title;
  String? title2;
  String? content;
  String? content2;

  final VerifyPhoneCallback verifyPhoneCallback;

  RegistrationForm({
    required this.title2,
    required this.verifyPhoneCallback,
    required this.title,
    required this.content,
    required this.content2,

  });
  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> with ChangeNotifier{
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _textField1Controller = TextEditingController();
  final TextEditingController _textField2Controller = TextEditingController();
  bool _isButtonEnabled = false;
  String? number;
  String get phoneNumber => number.toString();
  @override
  void initState() {
    super.initState();

    // Listen for changes in the text fields
    _textField1Controller.addListener(_updateButtonState);
    _textField2Controller.addListener(_updateButtonState);
  }

  void _updateButtonState() {
    setState(() {
      _isButtonEnabled = _textField1Controller.text.isNotEmpty &&
          _textField2Controller.text.isNotEmpty;
    });
  }

  @override
  void dispose() {
    _textField1Controller.dispose();
    _textField2Controller.dispose();
    // Cancel the timer to avoid memory leaks
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Stack(
          children: [
            Column(
              children: [
                CustomTextForm(
                    controller: _textField1Controller,
                    label: widget.title,
                    content: widget.content),
                50.verticalSpace,
                IntlPhoneField(
                  controller: _textField2Controller,
                  flagsButtonPadding: const EdgeInsets.all(8),
                  dropdownIconPosition: IconPosition.trailing,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.symmetric(
                      // Increase the vertical padding to increase the height
                      vertical: 20.0,
                      horizontal: SizeConfig.screenWidth(context) * 0.05,
                    ),
                    labelText: widget.title2,
                    hintText: widget.content2,
                    hintStyle:
                        GoogleFonts.inter(fontSize: 15, color: Colors.grey),
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
                  initialCountryCode: 'IN',
                  onChanged: (phone) {
                    number = phone.completeNumber;
                    notifyListeners();
                    print(phone.completeNumber);
                  },
                ),
                250.verticalSpace,
                CustomElevatedButton(
                  onPressed: () {
                    _isButtonEnabled ? _submitForm() : null;
                  },
                  text: "Register",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      log("Phone Number: ${number}");
      widget.verifyPhoneCallback(context, number.toString());

      // Start the resend cooldown
    }
  }
}
