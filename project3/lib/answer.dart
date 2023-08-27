// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  String? answerText;
  final Color? answerBlockColor;

  final VoidCallback? answerOnTap;
  //final void Function ()? answerOnTap;

  Answer({super.key, this.answerText, this.answerBlockColor, this.answerOnTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.all(15.0),
        margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 30.0),
        width: double.infinity,
        decoration: BoxDecoration(
            color: answerBlockColor, border: Border.all(color: Colors.pink)),
        child: Center(
            child: Text(
          answerText.toString(),
          style: TextStyle(fontSize: 15),
        )),
      ),
    );
  }

  // void answerOnTap() {

  // }
}
