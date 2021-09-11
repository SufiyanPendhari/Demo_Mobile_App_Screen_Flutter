import 'package:flutter/material.dart';
import '../moviepage.dart';

class MovieTile extends StatelessWidget {
  const MovieTile({Key? key, this.data}) : super(key: key);
  final dynamic data;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>MoviePage(title: data.title,)));
      },
      child: Stack(
        children: [
          Container(
              padding: const EdgeInsets.only(top: 0, bottom: 20, left: 20),
              height: 350,
              width: 240,
              child: Image.network(
                data.poster,
                height: 350,
                width: 200,
                fit: BoxFit.cover,
              )),
          Positioned(
            width: 80,
            left: 90,
            bottom: 5,
            child: Container(
              height: 30,
              alignment: Alignment.center,
              color: data.status == "New"
                  ? const Color(0xff00BC04)
                  : data.status == "Latest"
                      ? const Color(0xff00BC04)
                      : data.status == "Trending"
                          ? const Color(0xff00BC04)
                          : Colors.transparent,
              child: Text(
                data.status == "New"
                    ? "New"
                    : data.status == "Latest"
                        ? "Latest"
                        : data.status == "Trending"
                            ? "Trending"
                            : "",
                textAlign: TextAlign.center,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}