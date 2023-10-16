
import 'package:chatapp/ui/views/auth%20screens/otp_screen.dart';
import 'package:chatapp/ui/views/proflescreens/mainscreen.dart';
import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthProvider with ChangeNotifier {
  final _firebaseAuth = FirebaseAuth.instance;
  String? verificationId;
  int? _resendToken;
  bool _isOTPSent = false;
  String? _phoneNumber; // Private variable to store the phone number
  String? get phoneNumber => _phoneNumber;
  bool get isOTPSent => _isOTPSent;
  bool _registerButtonClicked = false;
  bool get registerButtonClicked => _registerButtonClicked;
  void resetVerification() {
    verificationId = null;
    _isOTPSent = false;
    notifyListeners();
  }

  // Getter to access the phone number
  void setRegisterButtonClicked(bool value) {
    _registerButtonClicked = value;
    notifyListeners();
  }

  Future<void> verifyPhone(String mobile, BuildContext context) async {
    verificationId = null;
    _isOTPSent = true;
    notifyListeners();

    var mobileToSend = mobile;
    _phoneNumber = mobile;
    notifyListeners();
    final PhoneCodeSent smsOTPSent = (String verId, [int? forceCodeResend]) {
      this.verificationId = verId;
      _resendToken = forceCodeResend;
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => OTPScreen()),
          (route) => false);
      _isOTPSent = false; // Reset _isOTPSent here
      notifyListeners();
    };

    try {
      await _firebaseAuth.verifyPhoneNumber(
          phoneNumber: mobileToSend,
          codeAutoRetrievalTimeout: (String verId) {
            this.verificationId = verId;
          },
          forceResendingToken: _resendToken,
          codeSent: smsOTPSent,
          timeout: const Duration(seconds: 120),
          verificationCompleted: (AuthCredential phoneAuthCredential) {
            print(phoneAuthCredential);
          },
          verificationFailed: (FirebaseAuthException exception) {
            throw exception;
          });
    } catch (e) {
      _isOTPSent = false;
      notifyListeners();
      throw e;
    }
  }
  //ADDED THE BUILDCONTEXT AND NAVIGATION TO THE MAIN PAGE
  Future<void> verifyOTP(BuildContext context, String otp) async {
    try {
      final AuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId!,
        smsCode: otp,
      );
      final UserCredential user =
          await _firebaseAuth.signInWithCredential(credential);
      final User currentUser = _firebaseAuth.currentUser!;
      print(user);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MainPage()));
      if (currentUser.uid != null) {
        print(currentUser.uid);
      }
    } catch (e) {
      throw e;
    }
  }

  showError(error) {
    throw error.toString();
  }
}
