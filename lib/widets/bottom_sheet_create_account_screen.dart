import 'package:flutter/material.dart';

class BottomSheetCreateAccountScreen extends StatefulWidget {
  @override
  _BottomSheetCreateAccountScreen createState() =>
      _BottomSheetCreateAccountScreen();
}

class _BottomSheetCreateAccountScreen
    extends State<BottomSheetCreateAccountScreen> {
  final TextEditingController _mobileController = TextEditingController();
  bool _isChecked = false;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _mobileController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 1,
      minChildSize: 1,
      maxChildSize: 1,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              // Drag Handle
              Container(
                margin: const EdgeInsets.only(top: 12),
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              Expanded(
                child: SingleChildScrollView(
                  controller: scrollController,
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

                          const SizedBox(height: 30),

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
                                      right: BorderSide(
                                        color: Colors.grey[300]!,
                                      ),
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
                                          borderRadius: BorderRadius.circular(
                                            2,
                                          ),
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            2,
                                          ),
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
                                      contentPadding:
                                          const EdgeInsets.symmetric(
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
                                        text:
                                            'By continuing, you agree to our ',
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
                              onPressed: () {
                                // Handle OTP request
                                if (_mobileController.text.isNotEmpty &&
                                    _isChecked) {
                                  print(
                                    'Requesting OTP for: ${_mobileController.text}',
                                  );
                                  // Add your OTP request logic here
                                  Navigator.pop(
                                    context,
                                  ); // Close bottom sheet after OTP request
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
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
                                print('Navigate to sign in');
                                Navigator.pop(context); // Close bottom sheet
                              },
                              child: Text(
                                'Existing User? Sign in',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.blue[700],
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
        );
      },
    );
  }
}
