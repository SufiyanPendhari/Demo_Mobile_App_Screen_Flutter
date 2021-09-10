import 'dart:ffi';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:http/http.dart' as http;


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
  int _state=0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      if(index!=3){
        _state=index;
      }
    });
    _selectedIndex==3?_key.currentState!.openEndDrawer():Void;
  }
  var url = Uri.parse('https://example.com/whatsit/create');
  @override
  initState(){
    super.initState();
    http.get(url)
    .then((value) => print(value));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _key,
        // appBar: AppBar(
        //   title: const Text('hello'),
        //   centerTitle: true,
        //   actions:const [
        //     SizedBox()
        //   ],
        // ),
        bottomNavigationBar: BottomNavigationBar(
          items: const[
             BottomNavigationBarItem(icon: Icon(Icons.home), label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.star), label: ""),
             BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: ""),
             BottomNavigationBarItem(icon: Icon(Icons.menu), label: "")
          ],
          showSelectedLabels: false,
          selectedItemColor: Colors.white,
          onTap: _onItemTapped,
          currentIndex: _selectedIndex,
        ),
        endDrawer: const Drawer(
          child: Center(
            child: Text("Drawer"),
          ),
        ),
        body: _state==1?const BlankPage(title: "Favorite",): _state==2?const BlankPage(title: "Bookmark",):SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Profile(),
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
                          number: isActive == 0 ? 1 : 0,title: "Movies",),
                      Btn(
                          onTap: () {
                            setState(() {
                              isActive = 1;
                            });
                          },
                          number: isActive == 1 ? 1 : 0,title: "Shows",),
                      Btn(
                          onTap: () {
                            setState(() {
                              isActive = 2;
                            });
                          },
                          number: isActive == 2 ? 1 : 0,title: "Music",)
                    ],
                  ),
                ),
                isActive==0?const BlankPage(title: "Movies",):isActive==2?const BlankPage(title: "Music",):Column(
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(
                        top: 10,
                        bottom: 10,
                        left: 20,
                      ),
                      child: SizedBox(
                          width: double.infinity,
                          child: Text(
                            'Movie',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 20),
                          )),
                    ),
                    SizedBox(
                      height: 350,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: const [
                          MovieTile(),
                          MovieTile(),
                          MovieTile(),
                          MovieTile(),
                          MovieTile(),
                        ],
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(
                        top: 10,
                        bottom: 10,
                        left: 20,
                      ),
                      child: SizedBox(
                          width: double.infinity,
                          child: Text(
                            'Movie',
                            textAlign: TextAlign.left,
                            style: TextStyle(fontSize: 20),
                          )),
                    ),
                    SizedBox(
                      height: 350,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: const [
                          MovieTile(),
                          MovieTile(),
                          MovieTile(),
                          MovieTile(),
                          MovieTile(),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ));
  }
}

class MovieTile extends StatelessWidget {
  const MovieTile({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
            padding: const EdgeInsets.only(top: 0, bottom: 20, left: 20),
            height: 350,
            width: 200,
            child: Image.network(
                'https://m.media-amazon.com/images/M/MV5BNWEwYTZhMGQtMDU0ZC00NmYyLTk0OWEtMjg1OTY5OTY5N2EyXkEyXkFqcGdeQXVyMTEzNjA2NzM@._V1_SX300.jpg')),
        Positioned(
          width: 60,
          left: 80,
          bottom: 35,
          child: Container(
            height: 30,
            alignment: Alignment.center,
            width: 100,
            color: Colors.green,
            child: const Text(
              'New',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white),
            ),
          ),
        )
      ],
    );
  }
}

class Btn extends StatelessWidget {
  const Btn({Key? key, this.onTap, this.number,this.title}) : super(key: key);
  final dynamic onTap;
  final dynamic number;
  final dynamic title;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 100,
        decoration: BoxDecoration(
          // border: Border.all(width: 1),
          color: number == 1 ? Colors.red : Colors.grey,
          borderRadius:const BorderRadius.all(Radius.circular(10))
        ),
        alignment: Alignment.center,
        padding: EdgeInsets.only(
            left: number == 1 ? 15 : 10,
            right: number == 1 ? 15 : 10,
            bottom: number == 1 ? 15 : 10,
            top: number == 1 ? 15 : 10),
        child: Text(
          title,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class Data {
  Data(this.title, this.year, this.type, this.poster);
  final String title;
  final String year;
  final String type;
  final String poster;
}

class BlankPage extends StatelessWidget {
  const BlankPage({ Key? key ,this.title}) : super(key: key);
  final dynamic title;
  @override
  Widget build(BuildContext context) {
    return Container(
      height:MediaQuery.of(context).size.height/2,
      alignment: Alignment.center,
      child: Text(title));
  }
}

class Profile extends StatelessWidget {
  const Profile({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top:20),
      child: SizedBox(
        height: 50,
        child: Row(children: [
          Container(
            margin:const EdgeInsets.only(left: 10),
            width: 50,
            height: 50,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(50))
            ),
          ),
          const Expanded(flex:3,child:  Padding(
            padding: EdgeInsets.only(left:10.0),
            child: Text('Sufiyan Pendhari'),
          )),
          const Expanded(flex:2,child: TextField(decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey,)
            ),
            prefixIcon: Icon(Icons.search)
          ),))
        ],),
      ),
    );
      
    
  }
}