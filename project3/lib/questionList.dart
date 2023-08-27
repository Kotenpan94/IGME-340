// ignore_for_file: prefer_interpolation_to_compose_strings

class QuestionList {
  final String question;

  final Map<String, dynamic> answerChoices;

  int state;

  QuestionList({
    required this.question,
    required this.answerChoices,
    this.state = 0,
  });

  @override
  String toString() {
    // TODO: implement toString
    print("Answer Choices: ${answerChoices.toString()}");
    // question = question.replaceAll("'", "\\'");
    return "{'question': '$question', 'answers': ${answersToString()}}}";
  }

  Map<String, dynamic> toJSON() {
    return {
      'question': question.toString(),
      'answers': answerChoices.toString()
    };
  }

  String answersToString() {
    String answerText = "{";
    for (int i = 0; i < answerChoices.length; i++) {
      answerText = answerText +
          "'" +
          answerChoices.keys.toList()[i] +
          "':" +
          answerChoices[answerChoices.keys.toList()[i]].toString() +
          "";
      if (i < answerChoices.length - 1) {
        answerText = answerText + ",";
      }
    }
    answerText + "}";
    return answerText;
  }
}
