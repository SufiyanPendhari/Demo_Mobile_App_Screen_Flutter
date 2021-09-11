import 'package:flutter/material.dart';

class MoviePage extends StatelessWidget {
  const MoviePage({Key? key,this.title}) : super(key: key);
  final dynamic title;
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: const Color(0xff040203),
      body: Center(
        child: Text(title,
        style:const TextStyle(fontSize: 20,fontWeight: FontWeight.w600)
      ),),
    );
  }
}
