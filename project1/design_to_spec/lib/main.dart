// ignore_for_file: prefer_const_constructors, duplicate_ignore

import 'package:google_fonts/google_fonts.dart';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          fontFamily: 'VT323',

          // ignore: prefer_const_constructors
          outlinedButtonTheme: OutlinedButtonThemeData(
              style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.blue,
                  backgroundColor: Colors.lightGreen,
                  shape: RoundedRectangleBorder(
                    // Confused as to why this button border is not working, followed along with the video demonstration
                    side: const BorderSide(color: Colors.black, width: 5),
                  ),
                  textStyle: const TextStyle(fontFamily: "Courier"))),
          colorScheme:
              ColorScheme.dark(primary: Colors.blue, secondary: Colors.purple),
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Trees and Wood",
          selectionColor: Color(0xffFFFFFF),
          style: TextStyle(fontSize: 20, fontFamily: 'retro'),
        ),
        leading: SvgPicture.asset(
          "assets/pickaxe.svg",
          color: Color(0xffFFFFFF),
        ),
        backgroundColor: Color(0xff9E9E9E),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text(
                          "About",
                          style: TextStyle(fontSize: 25, fontFamily: 'retro'),
                        ),
                        content: Container(
                          width: 300,
                          height: 200,
                          decoration: BoxDecoration(
                            color: Colors.white,
                          ),
                          child: Text(
                            "Created by Gabe Goldsteen \n\n Based on the work done in IGME 235's Design to Spec Homework \n\n February 22nd, 2022",
                            style: TextStyle(fontSize: 20, fontFamily: 'VT323'),
                          ),
                        ),
                      );
                    });
              },
              icon: Icon(Icons.person))
        ],
      ),
      // BODY HERE IS BACKGROUND IMAGE
      body: //oldversion(),
          Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/valley.jpg"), fit: BoxFit.cover),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              OakTree(),
              OakTreeText(),
              SizedBox(
                width: double.infinity,
                height: 300,
              ),
              Container(
                decoration: BoxDecoration(
                  color: Color(0xFF35363D),
                ),
                height: 800,
                child: Column(
                  children: [
                    Planks(),
                    Stick(),
                    Chest(),
                    Stairs(),
                  ],
                ),
              ),
              Stack(
                children: [
                  Image.asset('assets/trees.jpg'),
                  Center(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "TREES ARE PRETTY COOL, RIGHT?",
                        style: TextStyle(fontFamily: "retro", fontSize: 15),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 200,
                    child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        "COPYRIGHT 2022 \nRIT SCHOOL OF GAMES \nAND MEDIA ",
                        style: TextStyle(fontFamily: "retro", fontSize: 15),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Container OakTreeText() {
    return Container(
        decoration: BoxDecoration(
          color: Color(0xFF9E9E9E),
        ),
        //Not assigning a width or height here so that the container won't have any extra empty space
        // width: double.infinity,
        // height: 500,
        child: Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "The Oak Tree",
                  style: TextStyle(fontSize: 29),
                )),
            Text(
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras non volutpat arcu, at luctus mi. Pellentesque pellentesque vulputate dolor ac dignissim. Pellentesque aliquam nisl id nisl varius, ut iaculis libero efficitur. Praesent quis eros dolor. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed eleifend eleifend enim quis ultricies. \n\nProin sit amet semper justo, sit amet ultrices sapien. Vestibulum vitae sapien id diam finibus facilisis. Etiam velit tellus, molestie at ex eu, condimentum tincidunt sem. Nunc vel aliquet felis, sed consectetur nisl. Integer mauris est, congue ut vehicula non, finibus non ex.",
              style: TextStyle(fontSize: 17),
            ),
          ],
        ));
  }

  Expanded Stairs() {
    return Expanded(
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                Container(
                    width: 200,
                    child: Image.asset("assets/stairs.png", scale: 2,),
                    decoration: BoxDecoration(
                        border: Border.all(width: 5, color: Colors.white //
                            ),
                        color: Color(0xFF324E44))),
                        Container(
                    width: 200,
                    alignment: Alignment.topCenter,
                    child: Text('Stairs',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20)),
                  )
              ],
            ),
          ),
          Expanded(
            child: Container(
              height: 150,
              child: Expanded(
                child: SingleChildScrollView(
                    child: Text(
                  "Lorem ipsum dolor sit amet",
                  style: TextStyle(fontSize: 20),
                )),
              ),
              decoration: BoxDecoration(
                color: Color(0xFF9E9E9E),
              ),
            ),
          )
        ],
      ),
    );
  }

  Expanded Stick() {
    return Expanded(
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                Container(
                  width: 200,
                  child: Image.asset("assets/stick.png", scale: 1.75,),
                  decoration: BoxDecoration(
                      border: Border.all(width: 5, color: Colors.white //
                          ),
                      color: Color(0xFF324E44)),
                ),
                Container(
                  width: 200,
                  alignment: Alignment.topCenter,
                  child: Text('Stick',
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              height: 150,
              child: Expanded(
                child: SingleChildScrollView(
                    child: Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt.",
                  style: TextStyle(fontSize: 20),
                )),
              ),
              decoration: BoxDecoration(
                color: Color(0xFF9E9E9E),
              ),
            ),
          )
        ],
      ),
    );
  }

  Expanded Chest() {
    return Expanded(
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Stack(
              children: [
                Container(
                  width: 200,
                  child: Image.asset("assets/chest.png", scale: 2,),
                  decoration: BoxDecoration(
                      border: Border.all(width: 5, color: Colors.white //
                          ),
                      color: Color(0xFF324E44)),
                ),
                Container(
                  width: 200,
                  alignment: Alignment.topCenter,
                  child: Text('Chest',
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                )
              ],
            ),
          ),
          Expanded(
            child: Container(
              height: 150,
              child: Expanded(
                child: SingleChildScrollView(
                    child: Text(
                  "Lorem ipsum dolor sit amet.",
                  style: TextStyle(fontSize: 20),
                )),
              ),
              decoration: BoxDecoration(
                color: Color(0xFF9E9E9E),
              ),
            ),
          )
        ],
      ),
    );
  }

  Expanded Planks() {
    return Expanded(
      child: InkWell(
        onTap: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                    title: Text(
                      "Plank",
                      selectionColor: Colors.white,
                    ),
                    content: SingleChildScrollView(
                      child: Column(
                        children: [
                          Container(
                            width: 200,
                            child: Image.asset("assets/planks.png", scale: 2,),
                            decoration: BoxDecoration(
                              border: Border.all(width: 5, color: Colors.white),
                              color: Color(0xFF324E44),
                            ),
                          ),
                          Container(
                            width: 200,
                            decoration: BoxDecoration(color: Colors.white),
                            child: Text(
                              "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.",
                              style: TextStyle(fontSize: 17),
                            ),
                          ),
                        ],
                      ),
                    ));
              });
        },
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  Container(
                    width: 200,
                    child: Image.asset("assets/planks.png", scale: 2.25,),
                    decoration: BoxDecoration(
                        border: Border.all(width: 5, color: Colors.white //
                            ),
                        color: Color(0xFF324E44)),
                  ),
                  Container(
                    width: 200,
                    alignment: Alignment.topCenter,
                    child: Text('Planks',
                        style: TextStyle(color: Colors.white, fontSize: 20)),
                  )
                ],
              ),
            ),
            Expanded(
              child: Container(
                child: Expanded(
                  child: SingleChildScrollView(
                      child: Text(
                    "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.",
                    style: TextStyle(fontSize: 20),
                  )),
                ),
                decoration: BoxDecoration(
                  color: Color(0xFF9E9E9E),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Container OakTree() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(width: 5, color: Colors.white //
            ),
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          // ignore: prefer_const_literals_to_create_immutables
          colors: [
            Color(0xFF849090),
            Color(0xFF2F4340),
          ],
        ),
        image: DecorationImage(
          image: AssetImage("assets/oaktree.png"),
          fit: BoxFit.fill,
        ),
      ),
      width: double.infinity,
      height: 500,
    );
  }

  Container oldversion() {
    return Container(
      // ignore: prefer_const_literals_to_create_immutables
      constraints: BoxConstraints.expand(),
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/valley.jpg"), fit: BoxFit.cover),
      ),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // Container(
            //   decoration: BoxDecoration(
            //     border: Border.all(
            //       color: Color(0xFF000000),
            //       style: BorderStyle.solid,
            //       width: 2.0,
            //     ),
            //     image: DecorationImage(
            //       image: AssetImage('assets/oaktree.png'),
            //       fit: BoxFit.fill,
            //     ),
            //   ),
            // ),
            //FIRST CARD CONTAINER
            Container(
              decoration: BoxDecoration(
                border: Border.all(width: 5, color: Colors.white //
                    ),
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  // ignore: prefer_const_literals_to_create_immutables
                  colors: [
                    Color(0xFF849090),
                    Color(0xFF2F4340),
                  ],
                ),
                image: DecorationImage(
                  image: AssetImage("assets/oaktree.png"),
                  fit: BoxFit.fill,
                ),
              ),
              width: double.infinity,
              height: 500,
            ),
            Container(
                decoration: BoxDecoration(
                  color: Color(0xFF9E9E9E),
                ),
                //Not assigning a width or height here so that the container won't have any extra empty space
                // width: double.infinity,
                // height: 500,
                child: Column(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Text("The Oak Tree"),
                    Text(
                        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Cras non volutpat arcu, at luctus mi. Pellentesque pellentesque vulputate dolor ac dignissim. Pellentesque aliquam nisl id nisl varius, ut iaculis libero efficitur. Praesent quis eros dolor. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed eleifend eleifend enim quis ultricies. Proin sit amet semper justo, sit amet ultrices sapien. Vestibulum vitae sapien id diam finibus facilisis. Etiam velit tellus, molestie at ex eu, condimentum tincidunt sem. Nunc vel aliquet felis, sed consectetur nisl. Integer mauris est, congue ut vehicula non, finibus non ex."),
                  ],
                )),

            Container(
              decoration: BoxDecoration(
                color: Color(0xFF35363D),
              ),
              height: 100,
              child: SizedBox(
                height: 20,
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(width: 5, color: Colors.white //
                            ),
                        image: DecorationImage(
                          image: AssetImage("assets/planks.png"),
                          fit: BoxFit.fill,
                        ),
                      ),
                      width: double.infinity / 2,
                      height: 500,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
