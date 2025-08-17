import 'package:flutter/material.dart';

class AccountScreenIcons extends StatelessWidget {
  String iconpath;
  AccountScreenIcons({super.key, required this.iconpath});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: 80,
      height: 80,
      child: Image.asset(iconpath),
      decoration: BoxDecoration(
        color: Color.fromARGB(25, 255, 255, 255),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }
}
