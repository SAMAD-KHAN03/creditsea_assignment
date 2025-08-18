// ignore_for_file: no_leading_underscores_for_local_identifiers
import 'package:creditsea_assignment/providers/profile_components_provider.dart';
import 'package:creditsea_assignment/providers/screen_provider.dart';
import 'package:creditsea_assignment/providers/text_editing_controllers_providers.dart';
import 'package:creditsea_assignment/screens/detail.dart';
import 'package:creditsea_assignment/screens/pan_verification.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class Emailverification extends ConsumerStatefulWidget {
  const Emailverification({Key? key}) : super(key: key);

  @override
  ConsumerState<Emailverification> createState() => _EmailVerification();
}

class _EmailVerification extends ConsumerState<Emailverification> {
  final List<FocusNode> _otpFocusNodes = List.generate(
    6,
    (index) => FocusNode(),
  );

  Timer? _timer;
  int _seconds = 28;
  bool _isResendEnabled = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_seconds > 0) {
        setState(() {
          _seconds--;
        });
      } else {
        setState(() {
          _isResendEnabled = true;
        });
        timer.cancel();
      }
    });
  }

  void _resendCode() {
    setState(() {
      _seconds = 28;
      _isResendEnabled = false;
    });
    _startTimer();
    // Add your resend OTP logic here
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('OTP resent successfully!')));
  }

  @override
  Widget build(BuildContext context) {
    final _emailController = ref.watch(emailController);
    final _otpControllers = ref.watch(emailOtpController);
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            ref.watch(screenProvider.notifier).state = Detail();
          },
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
        ),
        title: const Text(
          'Personal Email ID',
          style: TextStyle(
            color: Colors.black87,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            // Email Illustration
            Center(
              child: Container(
                width: 200,
                height: 150,
                child: SizedBox(
                  width: 170,
                  height: 170,
                  child: Image.asset("assets/images/emailverfication.png"),
                ),
              ),
            ),

            const SizedBox(height: 40),

            // Email ID Label
            Text(
              'Email ID*',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.grey[800],
              ),
            ),

            const SizedBox(height: 8),

            // Email Input Field
            TextField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                hintText: 'Enter your email ID',
                hintStyle: TextStyle(color: Colors.grey[400], fontSize: 16),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Color.fromARGB(255, 0, 117, 255),
                    width: 2,
                  ),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 16,
                ),
              ),
            ),

            const SizedBox(height: 32),

            // OTP Verification Label
            Text(
              'OTP Verification',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.grey[800],
              ),
            ),

            const SizedBox(height: 16),

            // OTP Input Fields
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(6, (index) {
                return Container(
                  width: 45,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey[300]!),
                  ),
                  child: TextField(
                    controller: _otpControllers[index],
                    focusNode: _otpFocusNodes[index],
                    textAlign: TextAlign.center,
                    keyboardType: TextInputType.number,
                    maxLength: 1,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                    decoration: const InputDecoration(
                      border: InputBorder.none,
                      counterText: '',
                    ),
                    onChanged: (value) {
                      if (value.isNotEmpty && index < 5) {
                        _otpFocusNodes[index + 1].requestFocus();
                      } else if (value.isEmpty && index > 0) {
                        _otpFocusNodes[index - 1].requestFocus();
                      }
                    },
                  ),
                );
              }),
            ),

            const SizedBox(height: 24),

            // Resend Code and Timer
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      "Didn't receive it? ",
                      style: TextStyle(color: Colors.grey[600], fontSize: 14),
                    ),
                    GestureDetector(
                      onTap: _isResendEnabled ? _resendCode : null,
                      child: Text(
                        'Resend Code',
                        style: TextStyle(
                          color: _isResendEnabled
                              ? Color.fromARGB(255, 0, 117, 255)
                              : Colors.grey[400],
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  '00:${_seconds.toString().padLeft(2, '0')}',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),

            const Spacer(),

            // Verify Button
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () {
                  // Handle verification
                  String otp = _otpControllers
                      .map((controller) => controller.text)
                      .join();
                  if (_emailController.text.isNotEmpty && otp.length == 6) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Email verified successfully!'),
                      ),
                    );
                    // Navigator.pop(context);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Please enter email and complete OTP'),
                      ),
                    );
                  }
                  ref.watch(screenProvider.notifier).state = PanVerification();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 0, 117, 255),
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Verify',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
