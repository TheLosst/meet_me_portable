import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget SearchCardMeetMe(BuildContext context, String name, String description) {
  return Container(
      decoration: BoxDecoration(
          color: Color.fromRGBO(255, 239, 246, 1),
          boxShadow: [
            BoxShadow(
                blurRadius: 2,
                spreadRadius: 2,
                offset: Offset(0, 0),
                color: Colors.black38)
          ],
          borderRadius: BorderRadius.all(Radius.circular(15))),
      child: Column(
        children: [
          Image.network("lib/Temp/image 7.png"),
          SizedBox(
            width: 1,
            height: 7,
          ),
          Text(
            name,
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 1,
            height: 7,
          ),
          Text(
            description,
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
          ),
        ],
      ));
}
