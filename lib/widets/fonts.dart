import 'package:flutter/material.dart';

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
