// ignore_for_file: prefer_const_constructors, non_constant_identifier_names, unnecessary_brace_in_string_interps, sort_child_properties_last, prefer_const_declarations, dead_code, avoid_print, body_might_complete_normally_nullable, sized_box_for_whitespace, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:project3/question.dart';
import 'package:project3/questionList.dart';
import 'package:project3/quiz.dart';
import 'package:project3/create.dart';
import 'package:project3/documentation.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:shared_preferences/shared_preferences.dart';




void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          fontFamily: 'Comme',
          
          // ignore: prefer_const_constructors
          outlinedButtonTheme: OutlinedButtonThemeData(
              style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.blue,
                  backgroundColor: Colors.lightGreen,
                  shape: const RoundedRectangleBorder(
                    // Confused as to why this button border is not working, followed along with the video demonstration
                    side: BorderSide(color: Colors.black, width: 5),
                  ),
                  textStyle: const TextStyle(fontFamily: "Courier"))),
          colorScheme: const ColorScheme.dark(
              primary: Colors.blue, secondary: Colors.purple),
          textTheme: const TextTheme(
            displayLarge: TextStyle(
                color: Colors.amber, fontSize: 20, fontWeight: FontWeight.bold),
            displayMedium: TextStyle(
                color: Colors.orange,
                fontSize: 15,
                fontWeight: FontWeight.normal),
            displaySmall: TextStyle(
                color: Colors.black,
                fontSize: 10,
                fontWeight: FontWeight.normal),
            titleLarge: TextStyle(
                color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            titleMedium: TextStyle(
                color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
            titleSmall: TextStyle(
                color: Colors.yellow, fontSize: 5, fontWeight: FontWeight.bold),
          )),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool enabled = true;
  int currentTab = 0;
  late int numberOfQuestionsCorrect = 0;
  //Using this as a way in the future to filter through my question map
  int questionToken = 0;
  String questionText = "";
  bool isQuizFinished = false;
  bool isAnswerChosen = false;

   final screens = [];

  void returnToFirstQuestion() {
    setState(() {
      isQuizFinished = false;
      questionToken = 0;
      questionText = questions[questionToken].question;
      isAnswerChosen = false;
    });
  }

  void advanceToNextQuestion() {
    print("Question token now: ${questionToken}");
    setState(() {
      if (questionToken == questions.length - 1) {
        isQuizFinished = true;
        questionText = "No more questions";
        return;
      } else {
        questionToken++;
        questionText = questions[questionToken].question;
        print("Next question: ${questionText}");
        isAnswerChosen = false;
      }
    });
  }

  final listOfQuestions = const [
    //Each bracket pair represents a different question
    {
      //First question
      'question': 'What is my name?',
      //Possible answers
      'answers': [
        //Correct one is Gabe, score is a bool that keeps track of which is the correct response.
        {'answer-response': 'Gabe', 'score': true},
        {'answer-response': 'Jake', 'score': false},
        {'answer-response': 'Spencer', 'score': false},
        {'answer-response': 'Nick', 'score': false}
      ],
    },
    {
      //Second question
      'question': 'What is the name of my cat?',
      //Possible answers
      'answers': [
        //Correct one is Hunter
        {'answer-response': 'George', 'score': false},
        {'answer-response': 'Cosmo', 'score': false},
        {'answer-response': 'Hunter', 'score': true},
        {'answer-response': 'Demon', 'score': false},
      ],
    }
  ];

  List<QuestionList> questions = [
    QuestionList(question: 'What is my name?', answerChoices: {
      'Gabe': true,
      'Jake': false,
      'Spencer': false,
      'Nick': false
    }),
    QuestionList(question: 'What is the name of my cat?', answerChoices: {
      'George': false,
      'Cosmo': false,
      'Hunter': true,
      'Demon': false
    }),
  ];

  //Keeps track of the number of questions correct so far
  //Note: Will have to use setState later on to correctly update the number changing as more answers are correct

  @override
  void initState() {
    super.initState();
    init();

    questionToken = 0;
    questionText = questions[questionToken].question;
    numberOfQuestionsCorrect = 0;
    print("Question text should be ${questionText}");
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //creating a map of questions and answers
    //For now this will remain as a final, but maybe as a stretch goal I might add something
    //Like the ability to create your own question sets (tentative)

    return Scaffold(
        appBar: AppBar(
          title: const Text(
            "Quiz Time!",
            selectionColor: Color(0xffFFFFFF),
            style: TextStyle(fontSize: 20),
          ),
          backgroundColor: Colors.purple,
          //About - For Documentation
        ),
        body: screens[currentTab],
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentTab,
          backgroundColor: Colors.black26,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.videogame_asset),
              label: "Game",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.brush),
              label: "Create",
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.edit_document),
              label: "Documentation",
            ),
          ],
          onTap: (index) {
            setState(() {
              currentTab = index;
              print(currentTab);
            });
          },
        ));
  }

  Container TestContainer() {
    return Container(
      //Dimensions
      width: double.infinity,
      height: double.infinity,
      //Everything as usual is in one giant column
      child: Column(
        children: [
          //Container for the question prompt
          Container(
            width: double.infinity,
            child: Center(
              child: Text(
                "Correct Answers so far: ${numberOfQuestionsCorrect}",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
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
                questionText,
                style: TextStyle(fontSize: 15),
              ),
            ),
          ),

          //Question(question: questionText),
          SizedBox(height: 20),
          GenerateAnswers(questionToken),

          //Next Question Button so that the player can choose when they're ready to go onto the next question
          ElevatedButton(
              onPressed: NextQuestion,
              child: Text(isQuizFinished ? "Restart Quiz" : "Next Question")),
        ],
      ),
    );
  }

  Container CreatePage() {
    return Container(
      color: Colors.green,
    );
  }

  Container DocPage() {
    return Container(
      color: Colors.purple,
    );
  }

  Container QuizPage2() {
    return Container(
      //Dimensions
      width: double.infinity,
      height: double.infinity,
      //Everything as usual is in one giant column
      child: Column(
        children: [
          //Container for the question prompt
          Container(
            width: double.infinity,
            child: Center(
              child: Text(
                "Correct Answers so far: ${numberOfQuestionsCorrect}",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
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
                questionText,
                style: TextStyle(fontSize: 15),
              ),
            ),
          ),

          //Question(question: questionText),
          SizedBox(height: 20),
          GenerateAnswers(questionToken),

          //Next Question Button so that the player can choose when they're ready to go onto the next question
          ElevatedButton(
              onPressed: NextQuestion,
              child: Text(isQuizFinished ? "Restart Quiz" : "Next Question")),
        ],
      ),
    );
  }

  void NextQuestion() {
    print("There are ${questions.length} questions");
    if (questionToken == questions.length - 1) {
      isQuizFinished = true;
      return;
    } else {
      if (isAnswerChosen == true) {
        advanceToNextQuestion();
        print("Moving on to question ${questionToken}");
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text("Please select an answer first."),
          behavior: SnackBarBehavior.floating,
        ));
      }
    }
    if (questionToken >= questions.length - 1) {
      RestartQuiz();
    }
  }

  void CheckAnswer(bool val) {
    print("Someone clicked a button, checking answer");
    setState(() {
      isAnswerChosen = true;
      if (val == true) {
        numberOfQuestionsCorrect++;
        print("Is answer chosen is currently $isAnswerChosen");
        print(numberOfQuestionsCorrect);
      } else {
        //Nothing happens, however the question is now disabled until they go to the next question.
      }
    });
  }

  void RestartQuiz() {
    print("Running Restart Quiz");
    returnToFirstQuestion();
  }

  void init() {
    screens.add(QuizPage3());
    screens.add(CreatePage2());
    screens.add(DocumentationPage());

    print("Question text should be ${questionText}");
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

  Widget GenerateAnswers(int qt) {
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
}
