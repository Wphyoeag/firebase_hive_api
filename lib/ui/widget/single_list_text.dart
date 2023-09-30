import 'package:flutter/material.dart';

class SingleListText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;
  const SingleListText({super.key, required this.text,this.fontSize=20,this.fontWeight=FontWeight.bold});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,style: TextStyle(fontSize: fontSize,fontWeight: fontWeight),
    );
  }
}