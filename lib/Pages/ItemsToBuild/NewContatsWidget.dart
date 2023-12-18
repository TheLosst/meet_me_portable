import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Utils/Push.dart';
import '../../Utils/User.dart';
import '../../Utils/globals.dart';
import '../MeetMeChat.dart';

Widget NewContactWidget(User? user, context, var color, String text,
    String name, String urlToImg, bool message, int i) {
  if (!message) {
    return Card(
      color: color,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          side: BorderSide(color: Colors.white, width: 1)),
      child: Stack(
        children: [
          Padding(
              padding: EdgeInsets.only(left: 0, top: 0),
              child: Container(
                width: 80,
                height: 80,
                foregroundDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                        image: NetworkImage(
                          (urlToImg.length < 15
                              ? "https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg?w=1060&t=st=1684600090~exp=1684600690~hmac=6b75e741db344adf46f23e43867d7278eac69b2ec466432330c81a641df4b986"
                              : urlToImg),
                        ),
                        fit: BoxFit.fill)),
              )),
          Padding(
            padding: EdgeInsets.only(left: 110, top: 11),
            child: Text(
              name,
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(left: 110, top: 49),
              child: Text(text,
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w400)))
        ],
      ),
    );
  } else {
    return Card(
      color: color,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          side: BorderSide(color: Colors.white, width: 1)),
      child: Stack(
        children: [
          Padding(
              padding: EdgeInsets.only(left: 0, top: 0),
              child: Container(
                width: 80,
                height: 80,
                foregroundDecoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                        image: NetworkImage(
                          (urlToImg.length < 15
                              ? "https://img.freepik.com/free-vector/businessman-character-avatar-isolated_24877-60111.jpg?w=1060&t=st=1684600090~exp=1684600690~hmac=6b75e741db344adf46f23e43867d7278eac69b2ec466432330c81a641df4b986"
                              : urlToImg),
                        ),
                        fit: BoxFit.fill)),
              )),
          Padding(
            padding: EdgeInsets.only(left: 110, top: 11),
            child: Text(
              name,
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
            ),
          ),
          Padding(
              padding: EdgeInsets.only(left: 110, top: 49),
              child: Text(text,
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w400))),
          Padding(
            padding: EdgeInsets.only(left: 400),
            child: SizedBox(
              width: 30,
              height: 30,
              child: ElevatedButton(
                onPressed: () {
                  messageTo = usersSwipeListData.elementAt(i);
                  Push().PushTo(MeetMeChat(), context);
                },
                child: Text("M"),
              ),
            ),
          )
        ],
      ),
    );
  }
}
