import 'package:chatapp/constants/colors.dart';
import 'package:chatapp/constants/size.dart';
import 'package:chatapp/constants/spacing.dart';
import 'package:chatapp/ui/views/auth%20screens/registration.dart';
import 'package:chatapp/ui/widgets/authwidget/authform.dart';
import 'package:chatapp/ui/widgets/authwidget/topcontainer.dart';
import 'package:chatapp/ui/widgets/custombutton.dart';
import 'package:chatapp/ui/widgets/customtextformfield.dart';
import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool _isButtonEnabled = false;

  @override
  void initState() {
    super.initState();

    // Listen for changes in the text fields
    _controller.addListener(_updateButtonState);
  }

  void _updateButtonState() {
    setState(() {
      _isButtonEnabled = _controller.text.isNotEmpty;
    });
  }

  final _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              AuthScreenTop(
                height: SizeConfig.screenHeight(context) * 0.28,
                title: "Login",
                subtitle: "Enter your 10-digit mobile number to continue.",
              ),
              150.verticalSpace,
              Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: IntlPhoneField(
                    controller: _controller,
                    flagsButtonPadding: const EdgeInsets.all(8),
                    dropdownIconPosition: IconPosition.trailing,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        // Increase the vertical padding to increase the height
                        vertical: 20.0,
                        horizontal: SizeConfig.screenWidth(context) * 0.05,
                      ),
                      labelText: 'Phone Number',
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
                      print(phone.completeNumber);
                    },
                  ),
                ),
              ),
              40.verticalSpace,
              CustomElevatedButton(
                onPressed: (_isButtonEnabled ? () => _submitForm() : null),
                text: "Login",
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Dont have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegistrationScreen(),
                        ),
                      );
                    },
                    child: Text(
                      "Register!",
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
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Handle form submission here
      // You can use _textField1Controller.text and _textField2Controller.text
    }
  }
}
