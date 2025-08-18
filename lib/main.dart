import 'package:creditsea_assignment/firebase_options.dart';
import 'package:creditsea_assignment/screens/first_screen.dart';
import 'package:creditsea_assignment/screens/loan_calculator.dart';
import 'package:creditsea_assignment/screens/otp_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_phone_auth_handler/firebase_phone_auth_handler.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    FirebasePhoneAuthProvider(
      child: ProviderScope(
        child: KeyboardDismissOnTap(child: MaterialApp(home: FirstScreen())),
      ),
    ),
  );
}

class KeyboardDismissOnTap extends StatelessWidget {
  final Widget child;
  const KeyboardDismissOnTap({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent, // <- important for iOS
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          currentFocus.unfocus();
        }
      },
      child: child,
    );
  }
}
