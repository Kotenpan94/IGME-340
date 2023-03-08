// ignore_for_file: prefer_const_constructors, duplicate_ignore, non_constant_identifier_names, sort_child_properties_last, avoid_print

import 'dart:ui';

import 'package:flutter/material.dart';

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
  var options = [
    const DropdownMenuItem(
      child: Text("Email"),
      value: "Email",
    ),
    const DropdownMenuItem(
      child: Text("In Person"),
      value: "In Person",
    ),
    const DropdownMenuItem(
      child: Text("Phone"),
      value: "Phone",
    ),
  ];

  String selectedOption = "Email";

  var controllerCurrentEmail = TextEditingController();
  var controllerCurrentPhone = TextEditingController();
  var controllerCurrentDate = TextEditingController();
  var controllerCurrentName = TextEditingController();
  var controllderDisabledTextbox = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Form for Gathering Form Data, Yayy",
          selectionColor: Color(0xffFFFFFF),
          style: TextStyle(fontSize: 20),
        ),
        backgroundColor: Colors.purple,
      ),
      body: Container(
        width: double.infinity,
        //Scrolling in case content does not fit page
        child: SingleChildScrollView(
          child: Column(
            children: [
              DisabledTextbox(),
              SizedBox(
                height: 15,
              ),
              Text("Please enter in your information down below!", style: TextStyle(color: Colors.blue),),
              NameTextField(),
              EmailTextfield(),
              DateOfBirthTextfield(),
              PhoneTextfield(),
              DropdownQuery(),
              SizedBox(
                height: 50,
              ),
              Row(
                children: [
                  ElevatedButton(
                      onPressed: () {
                        ClearAll();
                      },
                      child: Text("Clear")),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton(
                        onPressed: () {
                          Submit();
                        },
                        child: Text("Submit")),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Row EmailTextfield() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              width: 50,
              height: 50,
              // ignore: sort_child_properties_last
              child: Icon(
                Icons.mail,
                size: 30,
                color: Colors.black87,
              ),
              decoration: BoxDecoration(
                  border: Border.all(width: 8, color: Colors.black //
                      ),
                  color: Colors.green)),
        ),
        Expanded(
          child: Container(
            height: 50,
            // ignore: sort_child_properties_last
            decoration: BoxDecoration(
              color: Colors.grey,
            ),
            child: TextField(
              //Using the contoller of the Textfield to later use the built in clear method
              controller: controllerCurrentEmail,
              keyboardType: TextInputType.emailAddress,

              decoration: InputDecoration(
                  label: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      "Enter your email please",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.green,
                      width: 3.5,
                    ),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 10,
                    ),
                  ),
                  //Suffix Icon Button to clear out what's in the textfield that was typed
                  suffixIcon: IconButton(
                      onPressed: () {
                        controllerCurrentEmail.clear();
                      },
                      icon: Icon(Icons.clear))),
            ),
          ),
        )
      ],
    );
  }

// ignore: non_constant_identifier_names
  Row PhoneTextfield() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              width: 50,
              height: 50,
              // ignore: sort_child_properties_last
              child: Icon(
                Icons.phone,
                size: 30,
                color: Colors.black87,
              ),
              decoration: BoxDecoration(
                  border: Border.all(width: 8, color: Colors.black //
                      ),
                  color: Colors.green)),
        ),
        Expanded(
          child: Container(
            height: 50,
            // ignore: sort_child_properties_last
            decoration: BoxDecoration(
              color: Colors.grey,
            ),
            child: TextField(
              //Using the contoller of the Textfield to later use the built in clear method
              controller: controllerCurrentPhone,
              keyboardType: TextInputType.phone,

              decoration: InputDecoration(
                  label: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      "Enter your phone number",
                      style: TextStyle(color: Colors.black, fontSize: 15),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.green,
                      width: 3.5,
                    ),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 10,
                    ),
                  ),
                  //Suffix Icon Button to clear out what's in the textfield that was typed
                  suffixIcon: IconButton(
                      onPressed: () {
                        controllerCurrentPhone.clear();
                      },
                      icon: Icon(Icons.clear))),
            ),
          ),
        )
      ],
    );
  }

  // ignore: non_constant_identifier_names
  Row DateOfBirthTextfield() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              width: 50,
              height: 50,
              // ignore: sort_child_properties_last
              child: Icon(
                Icons.calendar_month,
                size: 30,
                color: Colors.black87,
              ),
              decoration: BoxDecoration(
                  border: Border.all(width: 8, color: Colors.black //
                      ),
                  color: Colors.green)),
        ),
        Expanded(
          child: Container(
            height: 50,
            // ignore: sort_child_properties_last
            decoration: BoxDecoration(
              color: Colors.grey,
            ),
            child: TextField(
              //Using the contoller of the Textfield to later use the built in clear method
              controller: controllerCurrentDate,
              keyboardType: TextInputType.datetime,

              decoration: InputDecoration(
                  label: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      "Enter your date of birth please",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.green,
                      width: 3.5,
                    ),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 10,
                    ),
                  ),
                  //Suffix Icon Button to clear out what's in the textfield that was typed
                  suffixIcon: IconButton(
                      onPressed: () {
                        controllerCurrentDate.clear();
                      },
                      icon: Icon(Icons.clear))),
            ),
          ),
        )
      ],
    );
  }

  Row NameTextField() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              width: 50,
              height: 50,
              // ignore: sort_child_properties_last
              child: Icon(
                Icons.person,
                size: 30,
                color: Colors.black87,
              ),
              decoration: BoxDecoration(
                  border: Border.all(width: 8, color: Colors.black //
                      ),
                  color: Colors.green)),
        ),
        Expanded(
          child: Container(
            height: 50,
            // ignore: sort_child_properties_last
            decoration: BoxDecoration(
              color: Colors.grey,
            ),
            child: TextField(
              //Using the contoller of the Textfield to later use the built in clear method
              controller: controllerCurrentName,
              decoration: InputDecoration(
                  label: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      "Enter your name please",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.green,
                      width: 3.5,
                    ),
                  ),
                  disabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 10,
                    ),
                  ),
                  //Suffix Icon Button to clear out what's in the textfield that was typed
                  suffixIcon: IconButton(
                      onPressed: () {
                        controllerCurrentName.clear();
                      },
                      icon: Icon(Icons.clear))),
            ),
          ),
        )
      ],
    );
  }

  Row DropdownQuery() {
    var controllerCurrent = TextEditingController();

    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
              width: 50,
              height: 50,
              // ignore: sort_child_properties_last
              child: Icon(
                Icons.info,
                size: 30,
                color: Colors.black87,
              ),
              decoration: BoxDecoration(
                  border: Border.all(width: 8, color: Colors.black //
                      ),
                  color: Colors.green)),
        ),
        Expanded(
          child: Container(
            height: 50,
            // ignore: sort_child_properties_last
            decoration: BoxDecoration(
              color: Colors.grey,
            ),
            child: DropdownButton(
                value: selectedOption,
                items: options,
                onChanged: (newValue) {
                  print(newValue);
                  setState(() {
                    selectedOption = newValue!;
                  });
                }),
          ),
        )
      ],
    );
  }

  Container DisabledTextbox() {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            //Text to inform the user
            child: Text(
              "Please await for text to be entered into the system!",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          //Text field that will store and print out the submitted values
          TextField(
            controller: controllderDisabledTextbox,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              //Using label text to inform the user
              labelText: "Please wait, thank you!",
              contentPadding: EdgeInsets.all(15),
              //Added enabled border just in case(although it will always be disabled)
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.green,
                  width: 3.5,
                ),
              ),
              //Decoration for the textbox when it is disabled(though it always will be in this app)
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.red,
                  width: 3.5,
                ),
              ),
            ),
            //Enabled = false, do not let anyone edit the values of the textbox
            enabled: false,
          )
        ],
      ),
    );
  }

  void ClearAll() {
    controllerCurrentDate.clear();
    controllerCurrentEmail.clear();
    controllerCurrentName.clear();
    controllerCurrentPhone.clear();
    controllderDisabledTextbox.clear();
    setState(() {
      selectedOption = "Email";
    });
  }

  void Submit() {
    setState(() {
      controllderDisabledTextbox.text = "Name: ${controllerCurrentName.text}\nEmail Address: ${controllerCurrentEmail.text}\nDate of Birth: ${controllerCurrentDate.text}\nPhone Number: ${controllerCurrentPhone.text}\nForm of Contact: $selectedOption";

      print(controllderDisabledTextbox.value);
    });
  }
}
