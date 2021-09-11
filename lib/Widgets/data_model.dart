import 'package:flutter/material.dart';

class Data {
  Data(this.title, this.year, this.type, this.poster, this.status);
  final String title;
  final String year;
  final String type;
  final String poster;
  final String status;
}


class BlankPage extends StatelessWidget {
  const BlankPage({Key? key, this.title}) : super(key: key);
  final dynamic title;
  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height / 2,
        alignment: Alignment.center,
        child: Text(title));
  }
}