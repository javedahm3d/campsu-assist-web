import 'package:flutter/material.dart';

class SquareGridTile extends StatelessWidget {
  final AssetImage logo;
  final String title;
  final Function() onTap;
  const SquareGridTile(
      {super.key,
      required this.logo,
      required this.title,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        child: InkWell(
          onTap: onTap,
          child: Container(
              width: MediaQuery.of(context).size.width * 0.2,
              height: MediaQuery.of(context).size.width * 0.15,
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    Color.fromARGB(138, 167, 167, 167),
                    Colors.grey
                  ]),
                  color: Color.fromARGB(78, 134, 134, 134),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.white, width: 4)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  //logo
                  Image(height: 185, width: 170, image: logo),
                  Text(
                    title,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  )
                ],
              )),
        ));
  }
}
