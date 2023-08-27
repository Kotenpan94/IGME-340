// ignore_for_file: non_constant_identifier_names, prefer_const_constructors, unnecessary_string_interpolations, prefer_const_literals_to_create_immutables

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:project3/questionList.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io' as io;

class CreatePage2 extends StatefulWidget {
  const CreatePage2({super.key});

  @override
  State<CreatePage2> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage2> {
  final controllerCurrentQuestion = TextEditingController();
  final controllerCorrectAnswer = TextEditingController();
  final controllerWrongAnswer1 = TextEditingController();
  final controllerWrongAnswer2 = TextEditingController();
  final controllerWrongAnswer3 = TextEditingController();

  final _mFormID = GlobalKey<FormState>();

  Future<Directory?>? tempDirectory;
  Directory? tempDirectory2;

// final path = "";
//   final syncPath = path;

  List<QuestionList> questions = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
    readQuestions();
    sleep(const Duration(milliseconds: 1000));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: BoxDecoration(color: Color.fromARGB(255, 51, 159, 213)),
            child: Center(
              child: Text(
                "Please enter in a question to create!",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black),
              ),
            ),
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              DecorationContainerBlue(),
              // SizedBox(height: 20,),
              Center(child: SearchTextbox()),
            ],
          ),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(color: Color.fromARGB(255, 51, 159, 213)),
            child: Center(
              child: Text(
                "Please enter in the correct answer! \nThis will be shuffled around later",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black),
              ),
            ),
          ),
          AnswerTextbox(controllerCorrectAnswer),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(color: Color.fromARGB(255, 51, 159, 213)),
            child: Center(
              child: Text(
                "Please enter in the incorrect answers! \nThese will be shuffled around later",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black),
              ),
            ),
          ),
          AnswerTextbox(controllerWrongAnswer1),
          AnswerTextbox(controllerWrongAnswer2),
          AnswerTextbox(controllerWrongAnswer3),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                  child: ElevatedButton(
                      onPressed: saveButton, child: Text("Save"))),
              SizedBox(
                width: 20,
                height: 20,
              ),
              Center(
                  child: ElevatedButton(
                      onPressed: clearFields, child: Text("Clear"))),
            ],
          ),
        ],
      ),
    );
  }

  Container DecorationContainerBlue() {
    return Container(
      width: double.infinity,
      height: 100,

      //Decorations for container
      decoration: BoxDecoration(color: Colors.blue[300]),
    );
  }

  Widget SearchTextbox() {
    return Container(
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(
        color: Colors.grey,
      ),
      child: TextFormField(
        controller: controllerCurrentQuestion,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please enter something!";
          }
          return null;
        },
        decoration: const InputDecoration(
          fillColor: Colors.black,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.green,
              width: 2,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
              width: 3.5,
            ),
          ),
          label: Text("Please enter a question"),
        ),
      ),
    );
  }

  Widget AnswerTextbox(TextEditingController controller) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey,
      ),
      child: TextFormField(
        controller: controller,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please enter something!";
          }
          return null;
        },
        decoration: const InputDecoration(
          fillColor: Colors.black,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.green,
              width: 2,
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
              width: 3.5,
            ),
          ),
          label: Text("Please enter an answer"),
        ),
      ),
    );
  }

  void saveButton() async {
    readQuestions();
    String currentQuestion = controllerCurrentQuestion.text;
    String correctAnswer = controllerCorrectAnswer.text;
    String wrongAnswer1 = controllerWrongAnswer1.text;
    String wrongAnswer2 = controllerWrongAnswer2.text;
    String wrongAnswer3 = controllerWrongAnswer3.text;
    final qMap = {
      correctAnswer: true,
      wrongAnswer1: false,
      wrongAnswer2: false,
      wrongAnswer3: false
    };
    List<String> keys = qMap.keys.toList();
    keys.shuffle();
    final Map<String, dynamic> newMap = {};
    keys.forEach((element) {
      newMap[element] = qMap[element];
    });
    print("Printing questions to a string right here: ${questions.toString()}");
    final q = QuestionList(question: currentQuestion, answerChoices: newMap);
    setState(() {
      questions.add(q);
    });
    print('Questions List: ${questions.toString()}');

    //Write to JSON here
    String writeJson = jsonEncode(questions.toString());
    
    print('Writing this to JSON: ${writeJson.toString()}');

    final path = await directoryPath();
    String filePath = path + "/questions.json";

    File(filePath).writeAsString(writeJson);
  }

  void clearFields() {
    controllerCurrentQuestion.clear();
    controllerCorrectAnswer.clear();
    controllerWrongAnswer1.clear();
    controllerWrongAnswer2.clear();
    controllerWrongAnswer3.clear();
  }

  void readQuestions() async {
    List<QuestionList> qList = [];
    final path = await directoryPath();
    String filePath = path + "/questions.json";
    await File(filePath).delete();
    if (File(filePath).existsSync() == false) {
      // copy the file
      //await File("assets/json/questions.json").copy(filePath);
      //final fileSource = File('assets/json/questions.json');
      final String contents =
          await rootBundle.loadString('assets/json/questions.json');

      //String contents = await fileSource.readAsString();
      File copyFile = await File(filePath).writeAsString(contents);
      print("Finished Copying!");
      print("Contents: $contents");
    }

    print("This is my path: ${path.toString()}");
    final String quizQuestions = await File(filePath).readAsString();
    print("Quiz questions are: $quizQuestions");
    print("Done now");
    final data = jsonDecode(quizQuestions);
    print("Printing Data from line 271: $data");
    for (int i = 0; i < data.length; i++) {
      final  questionPrompt = data[i]['question'];
      print("Question prompt is: $questionPrompt");
      final answers = data[i]['answers'];
      qList.add(QuestionList(question: questionPrompt, answerChoices: answers));
      print("Loaded from readQuestions");
    }
    setState(() {
      questions = qList;
    });
  }

  void init() {
    setState(() {
      tempDirectory = getTemporaryDirectory();
    });
  }

  Future<String> directoryPath() async {
    Directory directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> getJson() async {
    final path = await directoryPath();
    return File('$path/questionsCreated.json');
  }

  readJsonFile() {}
}
