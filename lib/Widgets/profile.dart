import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';

class Profile extends StatelessWidget {
  const Profile({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20),
      child: SizedBox(
        height: 50,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left:30.0),
              child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.network('https://static.wikia.nocookie.net/tomandjerry/images/1/16/Toms2_3_4.PNG/revision/latest?cb=20200111202627',height: 50,width: 50,),
              ),
            ),
            const Expanded(
                flex: 3,
                child: Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Text('Sufiyan Pendhari',style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600),),
                )),
            const Expanded(
                flex: 2,
                child: TextField(
                
                style: TextStyle(fontSize: 16),
                  decoration: InputDecoration(
                    // fillColor: Color(0xff212020),
                    contentPadding: EdgeInsets.all(0),
                    filled: true,
                    hintText: "Search",
                    hintStyle: TextStyle(fontSize: 16,color: Color(0xff888888)),
                    focusColor: Colors.transparent,
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                         color: Color(0xff212020),)
                      ),
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none),
                      disabledBorder:OutlineInputBorder(
                          borderSide: BorderSide(
                        color:Color(0xff212020),
                      )) ,
                      prefixIcon: Icon(Icons.search,color: Color(0xff333333),)),

                ))
          ],
        ),
      ),
    );
  }
}