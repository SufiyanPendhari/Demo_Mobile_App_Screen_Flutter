import 'package:flutter/material.dart';

class Btn extends StatelessWidget {
  const Btn({Key? key, this.onTap, this.number, this.title}) : super(key: key);
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
           boxShadow: [
                    BoxShadow(
                      color:number == 1 ?const Color(0xffDA0050).withOpacity(0.5): const Color(0xff212020).withOpacity(0.5),
                      offset:  const Offset(
                        0,
                        3.0,
                      ),
                      blurRadius: 7.0,
                      spreadRadius: 2,
                    ), 
                    // BoxShadow(
                    //   color: number == 1 ?const Color(0xffDA0050): const Color(0xff212020),
                    //   offset: const Offset(0.0, 0.0),
                    //   blurRadius: 0.0,
                    //   spreadRadius: 0.0,
                    // ), 
                  ],
            color: number == 1 ?const Color(0xffDA0050): const Color(0xff212020),
            borderRadius: const BorderRadius.all(Radius.circular(10))),
        alignment: Alignment.center,
        padding: EdgeInsets.only(
            left: number == 1 ? 15 : 10,
            right: number == 1 ? 15 : 10,
            bottom: number == 1 ? 15 : 10,
            top: number == 1 ? 15 : 10),
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: number==1? const TextStyle(fontSize: 16,fontWeight: FontWeight.w700,color: Colors.white,):const  TextStyle(fontSize: 16,color: Color(0xff888888))
        ),
      ),
    );
  }
}