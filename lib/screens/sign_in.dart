import 'package:creditsea_assignment/widets/fonts.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<SignIn> {
  bool ischecked = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 15, 75, 146),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(
              0,
              MediaQuery.of(context).size.height * 0.1,
              0,
              0,
            ),
            child: Center(child: Image.asset("assets/images/logo2.png")),
          ),
          const SizedBox(height: 22),

          SizedBox(
            width: 184,
            height: 184,
            child: Image.asset("assets/images/signin.png"),
          ),
          const SizedBox(height: 22),

          fonts(
            content: "24x7 Customer Care",
            fontFamily: "Montserrat",
            fontSize: 16,
            wordSpacing: 2,
            fontweight: FontWeight.w600,
            color_alpha: 255,
          ),
          const SizedBox(height: 5),

          fonts(
            content: "Dedicated customer support team",
            fontFamily: "Montserrat",
            fontSize: 12,
            wordSpacing: 2,
            fontweight: FontWeight.w500,
            color_alpha: 153,
          ),
          const SizedBox(height: 16),
          Row(
            spacing: 6,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromARGB(128, 255, 255, 255),
                ),
                width: 8,
                height: 8,
              ),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color.fromARGB(128, 255, 255, 255),
                ),
                width: 8,
                height: 8,
              ),
              Container(
                width: 24,
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          /// This will take up all remaining space
          // Expanded(child: BottomSheetCreateAccountScreen()),
        ],
      ),
    );
  }
}
