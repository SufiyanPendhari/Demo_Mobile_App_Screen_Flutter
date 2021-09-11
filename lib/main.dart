import 'dart:convert';
import 'dart:ffi';
import 'package:demo_application/Widgets/movie_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;
import './Widgets/movietile.dart';
import './Widgets/btn.dart';
import './Widgets/profile.dart';
import 'Widgets/data_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: const Color(0xff212121),
      theme: ThemeData.dark(),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey(); // Create a key
  var isActive = 1;
  int _selectedIndex = 0;
  int _state = 0;
  List newData = [];
  List popularData = [];
  List trendingData = [];
  List<Widget> newDataWidget = [];
  List<Widget> popularDataWidget = [];
  List<Widget> trendingDataWidget = [];
  void _onItemTapped(int index) {
    setState(() {
      if (index != 3) {
        _selectedIndex = index;
        _state = index;
      }
    });
    index == 3 ? _key.currentState!.openEndDrawer() : Void;
  }

  var url =
      Uri.parse('http://www.omdbapi.com/?i=tt3896198&apikey=c4033450&s=Movies');
  // calling api
  void callApi() {
    http
        .get(url)
        .then((value) => jsonDecode(value.body))
        .then((value) => value["Search"])
        .then((value) => {
              if (newData.isEmpty)
                {
                  for (var i = 0; i < value.length; i++)
                    {
                      // adding data to list
                      if (i < 5)
                        {
                          newData.add(Data(value[i]["Title"], value[i]["Year"],
                              value[i]["Type"], value[i]["Poster"], "New")),
                          popularData.add(Data(
                              value[i]["Title"],
                              value[i]["Year"],
                              value[i]["Type"],
                              value[i]["Poster"],
                              "")),
                          trendingData.add(Data(
                              value[i]["Title"],
                              value[i]["Year"],
                              value[i]["Type"],
                              value[i]["Poster"],
                              "Trending"))
                        }
                      else
                        {
                          newData.add(Data(value[i]["Title"], value[i]["Year"],
                              value[i]["Type"], value[i]["Poster"], "")),
                          popularData.add(Data(
                              value[i]["Title"],
                              value[i]["Year"],
                              value[i]["Type"],
                              value[i]["Poster"],
                              "Latest")),
                          trendingData.add(Data(
                              value[i]["Title"],
                              value[i]["Year"],
                              value[i]["Type"],
                              value[i]["Poster"],
                              ""))
                        }
                    },
                  // adding MovieTile widget according to data
                  for (var sampleData in newData)
                    {
                      setState(() {
                        newDataWidget.add(MovieTile(data: sampleData));
                      })
                    },
                  for (var item in popularData.reversed.toList())
                    {
                      setState(() {
                        popularDataWidget.add(MovieTile(data: item));
                      })
                    },
                  for (var item in trendingData)
                    {
                      setState(() {
                        trendingDataWidget.add(MovieTile(data: item));
                      })
                    }
                }
            });
  }

  @override
  void initState() {
    super.initState();
    callApi();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff040203),
        key: _key,
        // bottom navigation bar
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "",backgroundColor: Color(0xff171717)),
            BottomNavigationBarItem(icon: Icon(Icons.star), label: "",backgroundColor: Color(0xff171717)),
            BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: "",backgroundColor: Color(0xff171717)),
            BottomNavigationBarItem(icon: Icon(Icons.menu), label: "",backgroundColor: Color(0xff171717))
          ],
          showSelectedLabels: false,
          selectedItemColor: const Color(0xffCC004A),
          onTap: _onItemTapped,
          currentIndex: _selectedIndex,
        ),
        // end drawer
        endDrawer: const Drawer(
          child: Center(
            child: Text("Drawer"),
          ),
        ),
        // body
        body: _state == 1
            ? const BlankPage(
                title: "Favorite",
              )
            : _state == 2
                ? const BlankPage(
                    title: "Bookmark",
                  )
                : SafeArea(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          // profile of user
                          const Profile(),
                          // navigation Button
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 20.0, horizontal: 10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Btn(
                                  onTap: () {
                                    setState(() {
                                      isActive = 0;
                                    });
                                  },
                                  number: isActive == 0 ? 1 : 0,
                                  title: "Movies",
                                ),
                                Btn(
                                  onTap: () {
                                    setState(() {
                                      isActive = 1;
                                    });
                                  },
                                  number: isActive == 1 ? 1 : 0,
                                  title: "Shows",
                                ),
                                Btn(
                                  onTap: () {
                                    setState(() {
                                      isActive = 2;
                                    });
                                  },
                                  number: isActive == 2 ? 1 : 0,
                                  title: "Music",
                                )
                              ],
                            ),
                          ),
                          // chnage on press of navigation button
                          isActive == 0
                              ? const BlankPage(
                                  title: "Movies",
                                )
                              : isActive == 2
                                  ? const BlankPage(
                                      title: "Music",
                                    )
                                  : Column(
                                      children: [
                                        // horizontal movie slider
                                        MovieSlider(
                                          title: "Movie",
                                          list: newDataWidget.isEmpty
                                              ? []
                                              : newDataWidget,
                                        ),
                                        MovieSlider(
                                            title: "Popular",
                                            list: popularDataWidget.isEmpty
                                                ? []
                                                : popularDataWidget),
                                        MovieSlider(
                                            title: "Trending",
                                            list: trendingDataWidget.isEmpty
                                                ? []
                                                : trendingDataWidget),
                                      ],
                                    ),
                        ],
                      ),
                    ),
                  ));
  }
}
