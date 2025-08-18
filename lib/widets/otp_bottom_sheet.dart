import 'dart:async';
import 'package:creditsea_assignment/providers/text_editing_controllers_providers.dart';
import 'package:creditsea_assignment/screens/sign_in.dart';
import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OtpBottomSheet extends ConsumerStatefulWidget {
  // final String phoneNumber;
  const OtpBottomSheet({super.key});

  @override
  _OtpBottomSheet createState() => _OtpBottomSheet();
}

class _OtpBottomSheet extends ConsumerState<OtpBottomSheet> {
  late Timer _timer;
  int _start = 30;

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start == 0) {
        _timer.cancel();
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final _controllers = ref.watch(otpDigitsProvider);
    print("the length of controller array is ${_controllers.length}");
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          _controllers.clear();
        }
      },
      child: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 10),
                Text(
                  "Verify OTP, Sent on given number}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 30),

                // OTP Boxes
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(6, (index) {
                    return SizedBox(
                      width: 50,
                      child: TextField(
                        controller: _controllers[index],
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        decoration: InputDecoration(
                          counterText: "",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        onChanged: (value) {
                          if (value.isNotEmpty && index < 6) {
                            FocusScope.of(context).nextFocus();
                          }
                        },
                      ),
                    );
                  }),
                ),

                const SizedBox(height: 20),

                // Countdown
                Text(
                  "00:${_start.toString().padLeft(2, '0')}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                // const Spacer(),
                const SizedBox(height: 30),
                // Verify Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      // String otp = getOtp();
                      // TODO: Handle OTP verification
                      // print("Entered OTP: ${_controllers[0].text} ${}");
                      print("Entered OTP:");
                      for (final controller in _controllers) {
                        print(controller.text);
                      }
                      final varid = ref.watch(verificationId);
                      // final varid = "123456";
                      final smscode = _controllers.fold<String>(
                        "",
                        (previous, controller) => previous + controller.text,
                      );
                      print("sms code is $smscode");
                      try {
                        // Use the verificationId you added in Firebase console as test phone number
                        // For testing, this can be any string, e.g. "123456"
                        PhoneAuthCredential
                        credential = PhoneAuthProvider.credential(
                          verificationId:
                             varid, // any dummy string
                          smsCode:
                              smscode, // must match what you set in console
                        );

                        await FirebaseAuth.instance
                            .signInWithCredential(credential)
                            .then((value) {
                              print("done");
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => SignIn(isSignin: false),
                                ),
                              );
                            });
                      } catch (e) {
                        print("Error signing in: $e");
                      } finally {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => SignIn(isSignin: false),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: const Color(0xFF007BFF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      "Verify",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
