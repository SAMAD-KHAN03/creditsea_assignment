import 'package:creditsea_assignment/widets/account_screen_icons.dart';
import 'package:creditsea_assignment/widets/bottom_sheet_create_account_screen.dart';
import 'package:flutter/material.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration(milliseconds: 500), () {
      showModalBottomSheet(
        context: context,
        // isScrollControlled: true,
        // isDismissible: true,
        builder: (context) {
          return BottomSheetCreateAccountScreen();
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 15, 75, 146),
      body: SafeArea(
        child: Column(
          // spacing: 24,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(child: Image.asset("assets/images/logo2.png")),
            const SizedBox(height: 24),
            Row(
              spacing: 24,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AccountScreenIcons(iconpath: "assets/images/caricon.png"),
                AccountScreenIcons(iconpath: "assets/images/bikeicon.png"),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              spacing: 24,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                AccountScreenIcons(iconpath: "assets/images/laptopicon.png"),
                AccountScreenIcons(iconpath: "assets/images/phoneicon.png"),
              ],
            ),
            const SizedBox(height: 24),
            fonts(
              content: "Flexible Loan Options",
              fontFamily: "Montserrat",
              fontSize: 16,
              wordSpacing: 2,
              fontweight: FontWeight.w600,
              color_alpha: 255,
            ),
            const SizedBox(height: 5),
            fonts(
              content: "Loan types to cater to different financial needs",
              fontFamily: "Montserrat",
              fontSize: 12,
              wordSpacing: 2,
              fontweight: FontWeight.w500,
              color_alpha: 153,
            ),
          ],
        ),
      ),
    );
  }
}

class fonts extends StatelessWidget {
  int color_alpha;
  String content;
  String fontFamily;
  double fontSize;
  double wordSpacing;
  // Color color;
  FontWeight fontweight;
  fonts({
    super.key,

    required this.content,
    required this.fontFamily,
    required this.fontSize,
    required this.wordSpacing,
    required this.fontweight,
    required this.color_alpha,
  });
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Text(
      content,
      style: TextStyle(
        fontFamily: fontFamily,
        fontSize: fontSize,
        wordSpacing: wordSpacing,
        color: Colors.white.withAlpha(color_alpha),
        fontWeight: fontweight,
      ),
    );
  }
}
