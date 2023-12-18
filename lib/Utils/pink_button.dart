import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Pages/Registration/who_do_you_want_to_meet.dart';

class ButtonPink extends StatelessWidget {
  ButtonPink({
    Key? key,
    required this.text,
    required this.width,
    required this.height,
    required this.getSexed,

  }) : super(key: key);

  final String text;
  final double width;
  final double height;
  final Function getSexed;




  @override
  Widget build(BuildContext context) {
    return Container(
      width: width / MediaQuery.of(context).devicePixelRatio,
      height: height / MediaQuery.of(context).devicePixelRatio,
      decoration: const BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromRGBO(194, 35, 102, 1),
                Color.fromRGBO(228, 122, 167, 1),
              ]),
          borderRadius: BorderRadius.all(Radius.circular(50)),
          boxShadow: [
            BoxShadow(
                color: Color.fromRGBO(0, 0, 0, 0.25),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3))
          ]),
      child: ElevatedButton(
        onPressed: () {
          getSexed();
        },
        style: ElevatedButton.styleFrom(
          primary: Colors.transparent,
          shadowColor: Colors.transparent,
          onPrimary: Colors.pinkAccent,
        ),
        child: Text(
          text,
          style: const TextStyle(color: Colors.black, fontSize: 24),
        ),
      ),
    );
  }
}
