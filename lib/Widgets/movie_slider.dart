import 'package:flutter/material.dart';

class MovieSlider extends StatelessWidget {
  const MovieSlider({Key? key,this.title,this.list}) : super(key: key);
  final dynamic title;
  final dynamic list;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left:10.0,top: 10),
      child: Column(
        children: [
          Padding(
            padding:const EdgeInsets.only(
              top: 10,
              bottom: 10,
              left: 20,
            ),
            // title of the section 
            child: SizedBox(
                width: double.infinity,
                child: Text(
                  title,
                  textAlign: TextAlign.left,
                  style:const TextStyle(fontSize: 20,fontWeight: FontWeight.w700)
                )),
          ),
          // section with movietile 
          SizedBox(
            height: 350,
            child:   
            ListView(
                scrollDirection: Axis.horizontal,
                children: list.isEmpty?[]:list,)
          ),
        ],
      ),
    );
  }
}
