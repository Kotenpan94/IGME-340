import 'package:flutter/material.dart';

class AnswerChoiceCard extends StatelessWidget {
  const AnswerChoiceCard({super.key, required this.answerChoice, required this.color});

  final String answerChoice;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      child: ListTile(
        title: Center(
          child: Text(
            answerChoice,
            style: TextStyle(fontSize: 18.0),
          ),
        ),
      ),
    );
  }
}