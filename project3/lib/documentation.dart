/// ignore_for_file: unnecessary_brace_in_string_interps, sort_child_properties_last, sized_box_for_whitespace, prefer_const_constructors

// ignore_for_file: sort_child_properties_last, unnecessary_new, avoid_print, non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_string_interpolations, prefer_const_constructors, sized_box_for_whitespace, prefer_is_empty, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

class DocumentationPage extends StatefulWidget {
  const DocumentationPage({super.key});

  @override
  State<DocumentationPage> createState() => _DocumentationPageState();
}

class _DocumentationPageState extends State<DocumentationPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: Colors.purple,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Center(
                  child: Text(
                'Documentation Page',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              )),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 9, 80, 138),
              ),
              child: Center(
                  child: Text(
                'Documentation - Disclaimer',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              )),
            ),
            Container(
              width: double.infinity,
              height: 300,
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                  "Putting this in as a disclaimer, but as I worked on this project, I encountered many difficulties, although with the help from Professor Chin, I was able to overcome them. Except for one thing however, because of the way Dart parses JSON files, I ran into difficulties getting my Create Page to work fully. I was able to parse the data that was entered into the page, and was able to read from the file, but the act of saving it to the file after that grew too difficult. I am turning in the project without the create page working, as Professor Chin allowed me to do so. However, after this class I plan on still working on it, as a passion project, in order to develop this application into a worthy app that I can use in the future for studying.",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black)),
            ),
            Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 9, 80, 138),
              ),
              child: Center(
                  child: Text(
                'Documentation - Original Proposal',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              )),
            ),
            Container(
              width: double.infinity,
              height: 450,
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                children: [
                  Text(
                    "About the Developer: Gabe Goldsteen,Third year Game Design and Development student. Skilled at UI/UX Design.",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  Text(
                    "Name of App/Game: Quiz Time",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  Text(
                    "High Concept: Choose the quiz game that you think you can clear as fast as possible!",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  Text(
                    "Genre: Puzzle Trivia",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  Text(
                    "Aesthetics: Serious style but also somewhat lighthearted.",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                  Text(
                    "\nGame Project: To start off, the player will enter the game with the option to choose from two quizzes, whichever one they feel the most comfortable in. Clicking on the corresponding button will bring you to the quiz of their choice. Answer questions via a trivia game or solve simple math problems, the choice is yours.For the trivia game, there will be a certain amount of questions. Each question will be multiple choice, tackling a variety of different types of questions. The goal is to have the most correct answers by the end of the quiz.For the math quiz, the screen will display a math problem on top, and using the buttons on the screen, which will look like a numerical pad/calculator, the player will have to solve the math problems, ranging from simplistic to ones that require a bit more thinking. In both quizzes, there will be a time limit as well for each question, in order to give the player a sense of urgency.",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.black),
                  ),
                ],
              ),
            ),
            Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 9, 80, 138),
              ),
              child: Center(
                  child: Text(
                'Documentation - Proposal Photo',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              )),
            ),
            Container(
              width: double.infinity,
              height: 400,
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Image.asset('assets/prototypeP3.jpg', scale: 5,),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 9, 80, 138),
              ),
              child: Center(
                  child: Text(
                'Documentation - Process',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              )),
            ),
            Container(
              width: double.infinity,
              height: 450,
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                  "My process for this project involved a lot of research by scouring the web and looking at a ton of different video tutorials. I'll have them all linked at the end in my sources section. I had to adapt and change my project several times, as I kept running into errors in which the project would work fine, but as soon as I tried implementing a new feature, it would break down. This halted my progress quite a bit, and made me go back to the drawing board several times. Eventually I was able to break each step down, bit by bit, along with some help from Professor Chin.\n\nProbably most importantly, my project's goal shifted after I had gotten back my prototype's feedback. Orignally it was just a stretch goal, but with the feedback recieved, I decided to rework the function of my app/game entirely. It would still be a quiz, but instead of both a trivia and math quiz packaged as one, it would become more like a study tool. With one tab being the quiz itself and the other being a Create Tab that allows users to create their own questions sets.",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black)),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 9, 80, 138),
              ),
              child: Center(
                  child: Text(
                'Documentation - Requirements',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              )),
            ),
            Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                  "I met the requirements for the project by keeping a checklist and going over each part that I needed to have done. I often checked back at my prototype's feedback as well to see what I was missing from there and if I still needed to add that as well.",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black)),
            ),
            Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 9, 80, 138),
              ),
              child: Center(
                  child: Text(
                'Documentation - Special Notes',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              )),
            ),
            Container(
              width: double.infinity,
              height: 100,
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                  "As a special note, I did learn a lot from this project. I learned how to read information from json files that I created, using both the Path Provider Package, and Dart's built in innate methods.",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black)),
            ),
            Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 9, 80, 138),
              ),
              child: Center(
                  child: Text(
                'Documentation - Sources',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              )),
            ),
            Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                  "Below are the sources that I used ranging from video tutorials, to different information that I found online",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black)),
            ),
            Container(
              width: double.infinity,
              height: 200,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 30, 124, 201),
              ),
              child: Column(
                children: [
                  InkWell(
                    child: Text(
                      "Shared Preferences Tutorial",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      launchUrl(Uri.parse(
                          "https://medium.flutterdevs.com/using-sharedpreferences-in-flutter-251755f07127"));
                    },
                  ),
                  InkWell(
                    child: Text(
                      "Shared Preferences Tutorial",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      launchUrl(Uri.parse(
                          "https://medium.flutterdevs.com/using-sharedpreferences-in-flutter-251755f07127"));
                    },
                  ),
                  InkWell(
                    child: Text(
                      "How to Read/Write Text, JSON, and Image Files in Flutter Video",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      launchUrl(Uri.parse(
                          "https://www.youtube.com/watch?v=oZNvRd96iIs"));
                    },
                  ),
                  InkWell(
                    child: Text(
                      "IGME 340 Week 9B Lecture",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      launchUrl(Uri.parse(
                          "https://www.youtube.com/watch?v=j457fm7pYLQ"));
                    },
                  ),
                  InkWell(
                    child: Text(
                      "IGME 340 Week 11B Lecture",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      launchUrl(Uri.parse(
                          "https://www.youtube.com/watch?v=BpndPTnhiDQ"));
                    },
                  ),
                  InkWell(
                    child: Text(
                      "Flutter Quiz Game Tutorial - Playlist",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      launchUrl(Uri.parse(
                          "https://www.youtube.com/watch?v=PIN32X8gPQU&list=PLowRfKz1qoIII96X_sz7KyXoD9tgnDIyv"));
                    },
                  ),
                  InkWell(
                    child: Text(
                      "Flutter Complete Quiz Tutorial",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      launchUrl(Uri.parse(
                          "https://www.youtube.com/watch?v=tlFTC5Vznb8&t=1436s"));
                    },
                  ),
                  InkWell(
                    child: Text(
                      "Stackoverflow - Writing to a JSON File",
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    onTap: () {
                      launchUrl(Uri.parse(
                          "https://stackoverflow.com/questions/51807228/writing-to-a-local-json-file-dart-flutter"));
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
