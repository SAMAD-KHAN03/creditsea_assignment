import 'package:creditsea_assignment/screens/create_account.dart';
import 'package:flutter/material.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      // ScaffoldMessenger.of(context).
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => CreateAccount()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 15, 75, 146),

      body: Center(child: Image.asset("assets/images/logo.png")),
    );
  }
}
