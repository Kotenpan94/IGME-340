// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
// import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
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
      theme: ThemeData(
          fontFamily: 'Josefin',

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
  var options = [
    const DropdownMenuItem<int>(
      child: Text("10"),
      value: 10,
    ),
    const DropdownMenuItem<int>(
      child: Text("20"),
      value: 20,
    ),
    const DropdownMenuItem<int>(
      child: Text("25"),
      value: 25,
    ),
  ];

  bool isFavorited = false;
  String val = "Super Mario";
  String amiiboVal = "Super Smash Bros.";
  String sharedPrefKey = "lastSearched";
  List<String> urls = [];
  List<String> previews = [];

  String gameSeriesUrl = "https://www.amiiboapi.com/api/gameseries/";
  String amiiboSeriesUrl = "https://www.amiiboapi.com/api/amiiboseries/";
  List<String> favorites = [];
  var gameSeriesUrls = [];
  var amiibosSeriesUrls = [];
  //Key for accessing the text form globally
  final _mFormID = GlobalKey<FormState>();

  int selectedOption = 10;
  String selectedOptionGameSeries = "Super Smash Bros.";
  int previewLength = 0;
  int urlsLength = 0;
  String savingText = "";
  Image sketch1 = Image.asset("assets/sketch1");
  Image sketch2 = Image.asset("assets/sketch2");

  //Var to access the textform text field outside of the function
  var controllerCurrentSearch = TextEditingController();

  String randomGIFKey = "iMDAqWBrA8oEO3UWov6u6yhB20sxLcWt";
  String amiiboURL = "https://www.amiiboapi.com/api/amiibo/?";

  String RandomGIFUrl =
      "https://api.giphy.com/v1/gifs/random?api_key=iMDAqWBrA8oEO3UWov6u6yhB20sxLcWt&tag=&rating=g";

  // String searchGIFUrl =
  //     "https://api.giphy.com/v1/gifs/search?api_key=4ZuLBkCF6PYvczHtO8eA0iCOuqkh17Kw&q=dog&limit=25&offset=0&rating=g&lang=en";
  var searchGifUrl = "https://api.giphy.com/v1/gifs/search?";

  String textboxResult = "";
  String foundText = "";
  late SharedPreferences prefs;

  String flutterGifKey = "TPercNOHLl1h63nUULc4U6XLHcCV2Fs7";

  //Writing down ideas here. I want to have it so that I make a save button, changing my heart button to that.
  //The save button will basically take whatever image url it is related to, and save it into sharedPreferences with a key and its value
  //Then in init, I'll retrieve the value using getString(), and do some code so that when the user reloads the application,
  //Whichever amiibo they saved before will display at the launch of the application.
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //Gets the dropdown information from the API in the beginning

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Amiibo Finder",
          selectionColor: Color(0xffFFFFFF),
          style: TextStyle(fontSize: 20),
        ),
        backgroundColor: Colors.purple,
        //About - For Documentation
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        scrollable: true,
                        backgroundColor: Colors.purpleAccent,
                        title: Text(
                          "Documentation",
                          style: TextStyle(fontSize: 25),
                        ),
                        content: SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                decoration:
                                    BoxDecoration(color: Colors.purple[100]),
                                child: Text(
                                  "Created by Gabe Goldsteen\n This is my Amiibo Finder. You can use this app to search for Amiibos by name, and using the dropdown fields to search for game series and amiibo series of the amiibos(you can also keep this field blank). This app will save the last thing you searched in the textbox, so that when you open it again, it'll be there waiting for you. For the process I used to create this application, I relied a lot on using past assignments to help guide me, as an easy way to give myself a refresher. I also made sure to time manage and plan a certain amount of work each day in order to not overwork myself",
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                              Divider(),
                              Container(
                                decoration:
                                    BoxDecoration(color: Colors.purple[200]),
                                child: Text(
                                  "I worked on the project each day and made some tweaks here and there. However, I came into a massive roadblock though on one of the final nights, in which honestly I'm not too sure how it happened, but I think downloaded the sharedPreferences from pub.dev somehow corrupted my Flutter entirely. I had to do an emergency zoom call with the Professor Chin in order to solve this, and eventually after an hour or so, we were able to solve it. Professor Chin cited this as something that he's never seen before, in which I'm not sure whether to feel honored or another emotion instead.",
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                              Container(
                                decoration:
                                    BoxDecoration(color: Colors.purple[200]),
                                child: Text(
                                  "I worked on the project each day and made some tweaks here and there. However, I came into a massive roadblock though on one of the final nights, in which honestly I'm not too sure how it happened, but I think downloaded the sharedPreferences from pub.dev somehow corrupted my Flutter entirely. I had to do an emergency zoom call with the Professor Chin in order to solve this, and eventually after an hour or so, we were able to solve it. Professor Chin cited this as something that he's never seen before, in which I'm not sure whether to feel honored or another emotion instead. Thankfully after getting that resolved, I managed to complete the rest of my work.",
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                              Container(
                                decoration:
                                    BoxDecoration(color: Colors.purple[300]),
                                child: Text(
                                  "Sources:\nListed underneath are the sources I used for this project. I lot of them are helpful video tutorials that guided me when I was pretty confused on where to go next. I also used the Flutter Documentation as well, and read up on some articles. Not all of these listed were used in the final build of my project, but they helped guide me.",
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                              Container(
                                // decoration:
                                //     BoxDecoration(color: Colors.purple[400]),
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
                                        "Dropdown Menu from API Video",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      onTap: () {
                                        launchUrl(Uri.parse(
                                            "https://www.youtube.com/watch?v=zh8QhqUnJeA"));
                                      },
                                    ),
                                    InkWell(
                                      child: Text(
                                        "IGME 340 Week 8A Lecture",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      onTap: () {
                                        launchUrl(Uri.parse(
                                            "https://www.youtube.com/watch?v=-iB_dpPaF2k"));
                                      },
                                    ),
                                    InkWell(
                                      child: Text(
                                        "IGME 340 Week 7B Lecture",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      onTap: () {
                                        launchUrl(Uri.parse(
                                            "https://www.youtube.com/watch?v=OHDZXhV1-YQ"));
                                      },
                                    ),
                                    InkWell(
                                      child: Text(
                                        "Link to background art used",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      onTap: () {
                                        launchUrl(Uri.parse(
                                            "https://tcrf.net/File:AmiiboTap_TitleBG.png#filelinks"));
                                      },
                                    ),
                                    //https://tcrf.net/File:AmiiboTap_TitleBG.png#filelinks
                                  ],
                                ),
                              ),
                              Container(
                                decoration:
                                    BoxDecoration(color: Colors.purple[300]),
                                child: Text(
                                  "Beneath this are my sketches from my proposal, although they have changed significantly. Mainly there's less inforamtion on the actual cards as I decided having the release information when each amiibo came out added too much clutter and did not look aesthetically pleasing. Additionally I got rid of the favorite button as I realized that my initial idea with them could be more easily accomplished using sharedPreferences, so I opted to not use them.",
                                  style: TextStyle(fontSize: 15),
                                ),
                              ),
                              Column(
                                children: [
                                  Container(
                                    height: 300,
                                    child: Image.asset("assets/Sketch1.jpg"),
                                  ),
                                  Divider(),
                                  Container(
                                    height: 300,
                                    child: Image.asset("assets/Sketch2.jpg"),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    });
              },
              icon: Icon(Icons.person))
        ],
      ),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          //Background image
          image: DecorationImage(
              image: AssetImage("assets/amii.jpg"), fit: BoxFit.cover),
        ),
        //Scrolling in case content does not fit page
        child: Form(
          key: _mFormID,
          // ignore: prefer_const_literals_to_create_immutables
          child: Column(
            children: [
              //All of my function calls
              SearchTextbox(),
              gameSeriesContainer(),
              amiiboSeriesContainer(),
              searchButtons(),
              resultsText(),
              gridViewBuilderContainer()
            ],
          ),
        ),
      ),
    );
  }

  //Result text - How many images were found
  Text resultsText() {
    return Text(
      foundText = "Found $urlsLength Results",
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        color: Colors.black,
        fontSize: 20,
      ),
    );
  }

  //Search Buttons (this includes a clear button too)
  Wrap searchButtons() {
    //Using Wrap to get rid of the error messages
    return Wrap(
      children: [
        //Centering button
        Center(
          child: ElevatedButton(
            onPressed: () {
              validateText();
              setState(() {
                getSearchedAmiibo();
              });
            },
            // ignore: prefer_const_constructors
            child: Text(
              "Search for some Amiibos!",
              // ignore: prefer_const_constructors
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(3.0),
          child: Center(
            child: ElevatedButton(
              onPressed: () {
                clearFields();
              },
              child: const Text(
                "Clear!",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  //Gridview function - For displaying the searched results
  Container gridViewBuilderContainer() {
    return Container(
      width: double.infinity,
      height: 300,
      // child: Image.network(urls[0]),

      child: GridView.builder(
          itemCount: urlsLength,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              // crossAxisSpacing: 0,
              // mainAxisSpacing: 0,
              crossAxisCount: 2),
          itemBuilder: (context, index) {
            return GridTile(
                child: InkWell(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return StatefulBuilder(
                        builder: (context, setState) {
                          return AlertDialog(
                            title: Center(
                              child: Text(
                                "$textboxResult Image",
                                selectionColor: Colors.white,
                              ),
                            ),
                            content: SingleChildScrollView(
                              //Column for displaying the information regarding the amiibo and the image itself
                              child: Column(
                                children: [
                                  //Testing favorite button here for the time being

                                  //Game Series
                                  Text(
                                    "Game Series: $val",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  //Amiibo Series
                                  Text(
                                    "Amiibo Series: $amiiboVal",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),

                                  Container(
                                    //This image is the image for the alert dialog
                                    child: Image.network(urls[index]),
                                  ),
                                  // InkWell(
                                  //   child: const Text(
                                  //     "Link to Amiibo",
                                  //     style: TextStyle(
                                  //       color: Colors.white,
                                  //     ),
                                  //   ),
                                  //   onTap: () {
                                  //     launchUrl(Uri.parse(urls[index]));
                                  //   },
                                  // )
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    });
              },
              //This image is for just the display at first, before tapping on it.
              child: Image.network(urls[index]),
            ));
          }),
    );
  }

  //Dropdown menu for the amiibo series
  Container amiiboSeriesContainer() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey,
      ),
      child: DropdownButtonFormField(
          decoration: InputDecoration(
            label: Text("Choose an amiibo series"),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.green,
                width: 2,
              ),
            ),
          ),
          items: amiibosSeriesUrls.map((e) {
            // print("E is ${e}");
            return DropdownMenuItem(
              child: Text(e),
              value: e,
            );
          }).toList(),
          value: amiiboVal,
          onChanged: (v) {
            setState(() {
              amiiboVal = v.toString();
            });
          }),
    );
  }

  //Dropdown menu for the game series
  Container gameSeriesContainer() {
    return Container(
      decoration: BoxDecoration(color: Colors.grey),
      child: DropdownButtonFormField(
          decoration: InputDecoration(
            label: Text("Choose a game series"),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Colors.green,
                width: 2,
              ),
            ),
          ),
          items: gameSeriesUrls.map((e) {
            // print("E is ${e}");
            return DropdownMenuItem(
              child: Text(e),
              value: e,
            );
          }).toList(),
          value: val,
          onChanged: (v) {
            val = v.toString();
          }),
    );
  }

  //Dropdown Limit Query - Not being used - Kept it in just case, tho prolly will delete later on

  Container SearchTextbox() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey,
      ),
      child: TextFormField(
        controller: controllerCurrentSearch,
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
          label: Text("Please enter something to search"),
        ),
      ),
    );
  }

  void getDropdownGameSeriesList(String request) async {
    var response = await http.get(Uri.parse(request));
    print("Response: ${response.statusCode}");
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      for (int i = 0; i < jsonResponse.length; i++) {
        jsonResponse["amiibo"].forEach((a) {
          gameSeriesUrls.add(a["name"]);
        });
        gameSeriesUrls = gameSeriesUrls.toSet().toList();
        gameSeriesUrls.insert(0, "");
      }
      setState(() {});
    }
  }

  Future getSearchedAmiibo() async {
    //In function string for the URL
    String functionSearch = amiiboURL;
    //Getting the textbox's result and trimming it of white space
    textboxResult = controllerCurrentSearch.text;
    textboxResult.trim();
    // if (textboxResult.length > 1) {
    //   functionSearch += "name=" + textboxResult;
    // }
    functionSearch += "name=" + textboxResult;

    prefs.setString(sharedPrefKey, textboxResult);

    print("Searched GIF URL with the textbox results is now: $functionSearch");
    //Dropdown menus
    if (val.length > 1) {
      functionSearch += "&gameSeries=" + val.toString();
    }
    print(
        "Searched GIF URL with the textbox results and game series is now: $functionSearch");
    if (amiiboVal.length > 1) {
      functionSearch += "&amiiboSeries=" + amiiboVal.toString();
    } else {
      functionSearch += "";
    }
    print(
        "Searched GIF URL with the textbox results and game series and amiibo series is now: $functionSearch");
    //Call process function after building the url fully, process will search the api and pull back the necessary information
    processAmiboRequest(functionSearch);
  }

  void processAmiboRequest(var request) async {
    var response = await http.get(Uri.parse(request));
    //Printing out response code for testing
    print("Response: ${response.statusCode}");

    //If we get a good response, we continue!
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      urls.clear();
      previews.clear();
      favorites.clear();
      print("Json Response is here: $jsonResponse");
      for (var i = 0; i < jsonResponse.length; i++) {
        jsonResponse["amiibo"].forEach((a) {
          print("${a["image"]}");
          previews.add(a["image"]);
          urls.add(a["image"]);
          // print("Preview: " + a["images"]["preview_gif"]["url"]);
        });
      }
      // urls = urls.sublist();
      // previews = previews.sublist(selectedOption);
      previewLength = previews.length;
      // previewLength = previewLength;
      urlsLength = urls.length;
      // urlsLength = urlsLength;
      print("Urls contains: $urls");
      print("URLS LENGTH IS: ${urlsLength}");
      print("Preview Length is: $previewLength");
    } else if (response.statusCode == 404) {
      print("Failed to return result");
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
            "Your query failed to return any results. Please try a different search."),
        backgroundColor: Colors.red,
      ));
    }
    //If not found then
  }

  void getDropdownAmiiboSeriesList(String request) async {
    var response = await http.get(Uri.parse(request));
    print("Response: ${response.statusCode}");
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      for (int i = 0; i < jsonResponse.length; i++) {
        jsonResponse["amiibo"].forEach((a) {
          amiibosSeriesUrls.add(a["name"]);
        });
        amiibosSeriesUrls = amiibosSeriesUrls.toSet().toList();
        amiibosSeriesUrls.insert(0, "");
      }
      setState(() {});
    }
  }

  void validateText() {
    if (_mFormID.currentState!.validate()) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Processing")));
    }
  }

  //Function to toggle the state of the favorites button, whether or not to add or remove from list
  void toggleFavorites() {
    setState(() {
      if (isFavorited) {
        isFavorited = false;
        print("Unfavorited :( ");
      } else {
        isFavorited = true;
        print("Favorited!");
      }
    });
  }

  void clearFields() {
    controllerCurrentSearch.clear();
    setState(() {
      // selectedOption = 10;
      prefs.setString(sharedPrefKey, "");
    });
    previewLength = 0;
  }

  Future init() async {
    prefs = await SharedPreferences.getInstance();
    getDropdownGameSeriesList(gameSeriesUrl);
    getDropdownAmiiboSeriesList(amiiboSeriesUrl);
    if (prefs.containsKey(sharedPrefKey) == false) {
      prefs.setString(sharedPrefKey, "");
    }
    setState(() {
      savingText = prefs.getString(sharedPrefKey) ?? "";
      controllerCurrentSearch.text = savingText;
    });
  }

  // ignore: non_constant_identifier_names
}
