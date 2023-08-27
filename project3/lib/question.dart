import 'package:flutter/material.dart';

class Question extends StatelessWidget {
  const Question({super.key, required this.question});

  final String question;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      //Decorations for container
      decoration: BoxDecoration(color: Colors.blue[300]),
      child: Center(
        child: Text(
          //Indexing through my map to load the first question
          question,
          //listOfQuestions[0]['question'],
          style: TextStyle(fontSize: 15),
        ),
      ),
    );
  }
}
