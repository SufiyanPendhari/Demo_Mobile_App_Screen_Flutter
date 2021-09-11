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
            // border: Border.all(width: 1),
            color: number == 1 ?const Color(0xffCC004A): const Color(0xff212020),
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
          style: number==1?const TextStyle(fontSize: 16,fontWeight: FontWeight.w700):const TextStyle(fontSize: 16)
        ),
      ),
    );
  }
}