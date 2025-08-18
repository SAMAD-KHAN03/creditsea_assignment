import 'package:creditsea_assignment/providers/text_editing_controllers_providers.dart';
import 'package:creditsea_assignment/screens/create_account.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomSheetSignIn extends ConsumerStatefulWidget {
  @override
  _BottomSheetSignIn createState() => _BottomSheetSignIn();
}

class _BottomSheetSignIn extends ConsumerState<BottomSheetSignIn> {
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    final _mobileController = ref.watch(mobScreeController);
    final _passwordController = ref.watch(passwordController);
    return PopScope(
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          _mobileController.clear();
          _passwordController.clear();
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
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  "Please enter your credentials",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 30),

                // Mobile Number
                Text(
                  "Mobile Number",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 8),

                Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 14,
                        ),
                        decoration: BoxDecoration(
                          border: Border(
                            right: BorderSide(color: Colors.grey.shade400),
                          ),
                        ),
                        child: Row(
                          children: [
                            // India Flag
                            SizedBox(
                              width: 24,
                              height: 16,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(2),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Container(color: Colors.orange),
                                    ),
                                    Expanded(
                                      child: Container(color: Colors.white),
                                    ),
                                    Expanded(
                                      child: Container(color: Colors.green),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(width: 6),
                            Text(
                              "+91",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          controller: _mobileController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Please enter your mobile no.",
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 12,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 20),

                // Password
                Text(
                  "Enter password",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 8),

                TextField(
                  controller: _passwordController,
                  obscureText: !_isPasswordVisible,
                  decoration: InputDecoration(
                    hintText: "Enter password",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isPasswordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _isPasswordVisible = !_isPasswordVisible;
                        });
                      },
                    ),
                  ),
                ),

                SizedBox(height: 30),

                // Sign In Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Color(0xFF007BFF), // Blue
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      "Sign In",

                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20),

                // Bottom text
                Center(
                  child: GestureDetector(
                    onTap: () => Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => CreateAccount()),
                    ),
                    child: RichText(
                      text: TextSpan(
                        text: "New to CreditSea? ",
                        style: TextStyle(color: Colors.black, fontSize: 14),
                        children: [
                          TextSpan(
                            text: "Create an account",
                            style: TextStyle(
                              color: Color(0xFF007BFF),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
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
