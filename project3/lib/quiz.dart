/// ignore_for_file: unnecessary_brace_in_string_interps, sort_child_properties_last, sized_box_for_whitespace, prefer_const_constructors

// ignore_for_file: sort_child_properties_last, unnecessary_new, avoid_print, non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_string_interpolations, prefer_const_constructors, sized_box_for_whitespace, prefer_is_empty

import 'dart:ffi';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:project3/questionList.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io' as io;

class QuizPage3 extends StatefulWidget {
  const QuizPage3({super.key});

  @override
  State<QuizPage3> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<QuizPage3> {
  bool enabled = true;
  int currentTab = 0;
  late int numberOfQuestionsCorrect = 0;
  late int numberOfQuestionsCorrectLastGame = 0;
  //Using this as a way in the future to filter through my question map
  int questionToken = 0;
  String questionText = "";
  bool isQuizFinished = false;
  bool isAnswerChosen = false;
  List<QuestionList> questions = [];
  final correctAudioPlayer = AudioPlayer();
  final incorrectAudioPlayer = AudioPlayer();
  late SharedPreferences prefs;

  final String keyScore = "Score";

  @override
  void initState() {
    super.initState();
    init();
    print("INITIALIZING");
    readQuestions();
    print(questions);
    sleep(const Duration(milliseconds: 1000));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    // correctAudioPlayer.dispose();
    // incorrectAudioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        //Dimensions
        width: double.infinity,
        height: double.infinity,
        //Everything as usual is in one giant column
        child: questions.length > 0
            ? Column(children: [
                //Container for the question prompt
                Container(
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      "Score from Last Session: ${numberOfQuestionsCorrectLastGame}",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),
                  decoration:
                      BoxDecoration(color: Color.fromARGB(255, 60, 141, 207)),
                ),
                Container(
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      "Correct Answers so far: ${numberOfQuestionsCorrect}",
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                  ),
                  decoration: BoxDecoration(color: Colors.blue[400]),
                ),
                Container(
                  width: double.infinity,
                  height: 100,
                  //Decorations for container
                  decoration: BoxDecoration(color: Colors.blue[300]),
                  child: Center(
                    child: Text(
                      //Indexing through my map to load the first question
                      questions[questionToken].question,
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                GenerateAnswers(),

                //Next Question Button so that the player can choose when they're ready to go onto the next question
                ElevatedButton(
                    onPressed: NextQuestion,
                    child: Text(
                        isQuizFinished ? "Restart Quiz" : "Next Question")),
              ])
            : new Center(
                child: new CircularProgressIndicator(),
              ));
  }

  void readQuestions() async {
    List<QuestionList> qList = [];
    final path = await directoryPath();
    String filePath = path + "/questions.json";
    if (File(filePath).existsSync() == false) {
      // copy the file
      //await File("assets/json/questions.json").copy(filePath);
      //final fileSource = File('assets/json/questions.json');
      final String contents =
          await rootBundle.loadString('assets/json/questions.json');

      //String contents = await fileSource.readAsString();
      File copyFile = await File(filePath).writeAsString(contents);
      print("Finished Copying!");
    }

    print("This is my path: ${path.toString()}");
    final String quizQuestions = await File(filePath).readAsString();
    final String quizQuestions2 =
        await rootBundle.loadString('assets/json/questions.json');
    final data = await json.decode(quizQuestions2);

    print("This is data right here on line 136: $data");
    print("This is the first element of data: ${data[0]}");
    for (int i = 0; i < data.length; i++) {
      final String questionPrompt = data[i]['question'];
      print("Question prompt is: $questionPrompt");
      final answers = data[i]['answers'];
      qList.add(QuestionList(question: questionPrompt, answerChoices: answers));
      print("Loaded from readQuestions");
    }
    setState(() {
      questions = qList;
    });
  }

  Future<void> readJson() async {
    final String quizQuestions =
        await rootBundle.loadString('assets/json/questions.json');
    print(quizQuestions);
    final data = await json.decode(quizQuestions);
    for (int i = 0; i < data.length; i++) {
      final String questionPrompt = data[i]['question'];
      print("Question prompt is: $questionPrompt");
      final answers = data[i]['answers'];
      questions
          .add(QuestionList(question: questionPrompt, answerChoices: answers));
      print(questions);
    }
  }

  Widget GenerateAnswers() {
    return Column(
      key: ObjectKey(questionToken),
      children: [
        for (int i = 0; i < questions[questionToken].answerChoices.length; i++)
          GestureDetector(
            onTap: () {
              print(
                  "TAPPED : ${questions[questionToken].answerChoices.values.toList()[i]}");
              CheckAnswer(
                  questions[questionToken].answerChoices.values.toList()[i]);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                key: ObjectKey(
                    questions[questionToken].answerChoices.values.toList()[i]),
                width: double.infinity,
                // color: Colors.grey,
                color: getButtonColor(
                    questions[questionToken].answerChoices.values.toList()[i]),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Text(
                      "${questions[questionToken].answerChoices.keys.toList()[i]}",
                      style: const TextStyle(
                        fontSize: 18.0,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }

  void CheckAnswer(bool val) {
    print("Someone clicked a button, checking answer");
    setState(() {
      isAnswerChosen = true;
      if (val == true) {
        playCorrectSound();
        numberOfQuestionsCorrect++;
        prefs.setInt(keyScore, numberOfQuestionsCorrect);
        print("Is answer chosen is currently $isAnswerChosen");
        print(numberOfQuestionsCorrect);
      } else {
        playWrongSound();
        //Nothing happens, however the question is now disabled until they go to the next question.
      }
    });
  }

  getButtonColor(bool value) {
    print(
        "Currently isAnswerChosen is ${isAnswerChosen} and value is ${value}");
    if (isAnswerChosen == false) {
      return Colors.grey;
    } else {
      if (value == true) {
        return Colors.green;
      } else {
        return Colors.red;
      }
    }
  }

  void playCorrectSound() {
    correctAudioPlayer.play(AssetSource("correctanswer.mp3"));
  }

  void playWrongSound() {
    incorrectAudioPlayer.play(AssetSource("wronganswer.mp3"));
  }

  void NextQuestion() {
    if (questionToken == questions.length) {
      isQuizFinished = true;
      return;
    } else {
      if (isAnswerChosen) {
        setState(() {
          questionToken++;
          isAnswerChosen = false;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Please select an answer first."),
          behavior: SnackBarBehavior.floating,
        ));
      }
    }
    if (questionToken >= questions.length) {
      isQuizFinished = true;

      RestartQuiz();
    }
  }

  void RestartQuiz() {
    setState(() {
      isQuizFinished = false;
      numberOfQuestionsCorrect = 0;
      questionToken = 0;
    });
  }

  void init() async {
    // await readJson().then((value) => print("loaded"));
    prefs = await SharedPreferences.getInstance();
    // await prefs.clear();

    if (prefs.containsKey(keyScore) == false) {
      prefs.setInt(keyScore, 0);
    }
    numberOfQuestionsCorrectLastGame = prefs.getInt(keyScore)!;
  }

  Future<String> directoryPath() async {
    Directory directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> getJson() async {
    final path = await directoryPath();
    return File('$path/questionsCreated.json');
  }
}
