import 'dart:convert';
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
  int _state = 0;
  List newData = [];
  List popularData = [];
  List trendingData = [];
  List<Widget> newDataWidget = [];
  List<Widget> popularDataWidget = [];
  List<Widget> trendingDataWidget = [];
 

  var url =
      Uri.parse('http://www.omdbapi.com/?i=tt3896198&apikey=c4033450&s=Movies');
  // calling api
  Future callApi() async {
    return await http
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
        bottomNavigationBar: BottomAppBar(child: 
          Row(
            children: [
              bottomButton(Icon(Icons.home,color:_state==0?const Color(0xffDA0050):const Color(0xff888888),),(){
                setState(() {
                  _state=0;
                });
              }),
              bottomButton( Icon(Icons.star,color:_state==1?const Color(0xffDA0050):const Color(0xff888888),),(){
                setState(() {
                  _state=1;
                });
              }),
              bottomButton( Icon(Icons.bookmark,color:_state==2?const Color(0xffDA0050):const Color(0xff888888),),
              (){
                setState(() {
                  _state=2;
                });
              }),
              bottomButton(const Icon(Icons.menu,color: Color(0xff888888),),(){
                _key.currentState!.openEndDrawer();
              }),
            ],
          ),
    ),
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
                                      callApi();
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

  Expanded bottomButton(icon,onTap) {

    return Expanded(
              child: InkWell(
                onTap: onTap,
                child: Container(
                  color: const Color(0xff171717),
                  child: icon,
                  height: 60,
                  width: double.infinity,
                ),
              ),
            );
  }
}
