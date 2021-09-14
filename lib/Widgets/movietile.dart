import 'package:flutter/material.dart';
import '../moviepage.dart';

class MovieTile extends StatelessWidget {
  const MovieTile({Key? key, this.data}) : super(key: key);
  final dynamic data;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MoviePage(
                      title: data.title,
                    )));
      },
      child: Stack(
        children: [
          Container(
           
            margin: const EdgeInsets.only(top: 0, bottom: 20, left: 20),
            height: 330,
            width: 240,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(5),
              child:  Image.network(
                data.poster,
                height: 330,
                width: 240,
                fit: BoxFit.cover,
              ),
            )
            
          ),
          Positioned(
            left: data.status == "New"
                    ? 115
                    : data.status == "Latest"
                        ? 115
                        : data.status == "Trending"
                            ? 100
                            : 60,
            bottom: 5,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
              color: data.status == "New"
                  ? const Color(0xff00BC04)
                  : data.status == "Latest"
                      ? const Color(0xff00BC04)
                      : data.status == "Trending"
                          ? const Color(0xff00BC04)
                          : Colors.transparent,
              ),
              padding: const EdgeInsets.only(left:10,right:10),
              height: 30,
              alignment: Alignment.center,
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
