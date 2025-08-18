import 'package:creditsea_assignment/providers/text_editing_controllers_providers.dart';
import 'package:creditsea_assignment/screens/otp_screen.dart';
import 'package:creditsea_assignment/screens/sign_in.dart';
import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart';

class BottomSheetCreateAccountScreen extends ConsumerStatefulWidget {
  @override
  _BottomSheetCreateAccountScreen createState() =>
      _BottomSheetCreateAccountScreen();
}

class _BottomSheetCreateAccountScreen
    extends ConsumerState<BottomSheetCreateAccountScreen> {
  bool _isChecked = false;
  @override
  Widget build(BuildContext context) {
    final _mobileController = ref.watch(mobScreeController);
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          _mobileController.clear();
        }
      },
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 30),

                        // Title
                        Center(
                          child: Text(
                            'Welcome to Credit Seal',
                            style: TextStyle(
                              fontSize: 20,
                              letterSpacing: 2,
                              fontWeight: FontWeight.w600,
                              color: Colors.grey[800],
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        // Mobile Number Label
                        Text(
                          'Mobile Number',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[700],
                          ),
                        ),

                        const SizedBox(height: 12),

                        // Mobile Number Input Field
                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey[300]!),
                          ),
                          child: Row(
                            children: [
                              // Country Code Section
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 16,
                                  vertical: 18,
                                ),
                                decoration: BoxDecoration(
                                  border: Border(
                                    right: BorderSide(color: Colors.grey[300]!),
                                  ),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // Indian Flag
                                    Container(
                                      width: 24,
                                      height: 18,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(2),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(2),
                                        child: Column(
                                          children: [
                                            Expanded(
                                              child: Container(
                                                color: Colors.orange,
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                color: Colors.white,
                                              ),
                                            ),
                                            Expanded(
                                              child: Container(
                                                color: Colors.green,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      '+91',
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey[800],
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Phone Number Input
                              Expanded(
                                child: TextField(
                                  controller: _mobileController,
                                  keyboardType: TextInputType.phone,
                                  decoration: InputDecoration(
                                    hintText: 'Please enter your mobile no.',
                                    hintStyle: TextStyle(
                                      color: Colors.grey[400],
                                      fontSize: 16,
                                    ),
                                    border: InputBorder.none,
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: 16,
                                      vertical: 18,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Terms and Privacy Policy Checkbox
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _isChecked = !_isChecked;
                                });
                              },
                              child: Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  color: _isChecked
                                      ? Colors.green
                                      : Colors.white,
                                  border: Border.all(
                                    color: _isChecked
                                        ? Colors.green
                                        : Colors.grey[400]!,
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: _isChecked
                                    ? const Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: 16,
                                      )
                                    : null,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: RichText(
                                text: TextSpan(
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                    height: 1.4,
                                  ),
                                  children: [
                                    const TextSpan(
                                      text: 'By continuing, you agree to our ',
                                    ),
                                    TextSpan(
                                      text: 'privacy policies',
                                      style: TextStyle(
                                        color: Colors.grey[800],
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                    const TextSpan(text: ' and '),
                                    TextSpan(
                                      text: 'Terms & Conditions',
                                      style: TextStyle(
                                        color: Colors.grey[800],
                                        decoration: TextDecoration.underline,
                                      ),
                                    ),
                                    const TextSpan(text: '.'),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 40),

                        // Request OTP Button
                        SizedBox(
                          width: double.infinity,
                          height: 56,
                          child: ElevatedButton(
                            onPressed: () async {
                              if (_mobileController.text.length == 10 &&
                                  RegExp(
                                    r'^[0-9]+$',
                                  ).hasMatch(_mobileController.text)) {
                                try {
                                  await FirebaseAuth.instance.verifyPhoneNumber(
                                    verificationCompleted:
                                        (PhoneAuthCredential credential) {
                                          print(credential.smsCode);
                                        },
                                    verificationFailed:
                                        (FirebaseAuthException exception) {
                                          print(exception);
                                        },
                                    codeSent:
                                        (String verfication, int? resendtoken) {
                                          print(_mobileController.text);
                                          ref
                                                  .watch(
                                                    verificationId.notifier,
                                                  )
                                                  .state =
                                              verfication;
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (context) => OtpScreen(),
                                            ),
                                          );
                                        },
                                    codeAutoRetrievalTimeout:
                                        (verificationId) {},
                                    phoneNumber: "+91${_mobileController.text}",
                                  );
                                } catch (e) {
                                  print(e);
                                } finally {}
                              }
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => OtpScreen(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromARGB(255, 0, 117, 255),
                              foregroundColor: Colors.white,
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: const Text(
                              'Request OTP',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 24),

                        // Existing User Sign In
                        Center(
                          child: TextButton(
                            onPressed: () {
                              // Handle sign in for existing users
                              // _mobileController.clear();
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => SignIn(isSignin: true),
                                ),
                              );
                            },
                            child: Text(
                              'Existing User? Sign in',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color.fromARGB(255, 0, 117, 255),
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
