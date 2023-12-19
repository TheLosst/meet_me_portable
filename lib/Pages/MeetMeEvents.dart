import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meet_me_portable/Utils/horizontal_divider.dart';

import 'package:progress_indicators/progress_indicators.dart';

import '../Utils/ListMessages.dart';
import '../Utils/Push.dart';
import '../Utils/User.dart';
import '../Utils/globals.dart';
import 'ItemsToBuild/NewContatsWidget.dart';
import 'MeetMeChat.dart';
import 'MeetMeProfile.dart';
import 'MeetMeSearch.dart';
import 'MeetMeSlidePeople.dart';
import 'package:http/http.dart' as http;

class MeetMeEvents extends StatelessWidget {
  const MeetMeEvents({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MeetMe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MeetMeEventsPage(),
    );
  }
}

class MeetMeEventsPage extends StatefulWidget {
  const MeetMeEventsPage({Key? key}) : super(key: key);

  @override
  State<MeetMeEventsPage> createState() => _MeetMeEventsPageState();
}

Future<void> createUsers() async {
  //List<DiskProp> test = await fetchDiskDescr();
  usersSwipeListData = await fetchAllUsers();
}

// У сообщения должен быть id и мы смотрим, чтобы сообщение отправлялось от нас пользователю с id и наоборот, и находим список id
int searchUsers(int inputID){
  for(int i = 0; i < usersSwipeListData.length; i++)
    {
      // print("________________");
      // print(inputID);
      // print(usersSwipeListData.elementAt(i).id);
      // print(usersSwipeListData.elementAt(i).email);
      // print(i);
      // print("________________");
      if (usersSwipeListData.elementAt(i).id == inputID)
        {
          print("${usersSwipeListData.elementAt(i).username} -> ${i}");
          return i;
        }
    }
  return 0;
}

Future<List<User>> fetchAllUsers() async {
  final response =
  await http.get(Uri.parse('$connIp/GetListUsersMeetMe.php'));
  if (response.statusCode == 200) {
    var buff = json.decode(response.body);
    print(buff);
    return buff.map<User>(User.fromJson).toList();
  } else {
    throw Exception('Все сломалось!');
  }
}
Future<List<ListMessages>> getListSendedUsers() async{
  final response = await http.post(Uri.parse('$connIp/getUserIDToSended.php'),
      body: {"id": userLoggined.id.toString(),
      });
  print(json.decode(response.body));
  return json.decode(response.body).map<ListMessages>(ListMessages.fromJson).toList();
}

Future<List?> buildListMess() async{
  toUsers = await getListSendedUsers();
  print("toUsers");
  print(toUsers.length);
  print("toUsers");
  return toUsers;
}

class _MeetMeEventsPageState extends State<MeetMeEventsPage> {
  ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    createUsers();
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 51, top: 57),
              child: Container(
                width: 504,
                height: 59,
                decoration: BoxDecoration(
                    color: Color.fromRGBO(255, 225, 238, 1),
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    border: Border.all(color: Colors.white, width: 1),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withOpacity(0.25),
                          spreadRadius: 1,
                          blurRadius: 1,
                          offset: Offset(0, 1))
                    ]),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                        width: 83,
                        height: 39,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            "Все",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 28,
                                fontWeight: FontWeight.w300),
                          ),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateColor.resolveWith(
                                  (states) =>
                                      Color.fromRGBO(225, 182, 200, 1)),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ))),
                        )),
                    SizedBox(width: 37, height: 1),
                    Container(
                        width: 135,
                        height: 39,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            "Онлайн",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 28,
                                fontWeight: FontWeight.w300),
                          ),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateColor.resolveWith(
                                  (states) =>
                                      Color.fromRGBO(225, 182, 200, 1)),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ))),
                        )),
                    SizedBox(width: 37, height: 1),
                    Container(
                        width: 195,
                        height: 39,
                        child: ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            "Избранные",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 28,
                                fontWeight: FontWeight.w300),
                          ),
                          style: ButtonStyle(
                              backgroundColor: MaterialStateColor.resolveWith(
                                  (states) =>
                                      Color.fromRGBO(225, 182, 200, 1)),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15),
                              ))),
                        )),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 51, top: 146),
              child: Text(
                "Новые контакты: ",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.w400),
              ),
            ),
            Padding(
                padding: EdgeInsets.only(left: 51, top: 203),
                child: Container(
                  width: 515,
                  height: 800,
                  child: FutureBuilder<List?>(
                    future: buildListMess(),
                    builder: (BuildContext context, AsyncSnapshot<List?> snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        return ListView.builder(
                            itemCount: toUsers.length,
                            itemBuilder: (BuildContext context, int index) =>
                                NewContactWidget(
                                    user,
                                    context,
                                    Color.fromRGBO(255, 239, 246, 1),
                                    usersSwipeListData.elementAt(searchUsers(int.parse(toUsers.elementAt(index).id))).targetMeet,
                                    usersSwipeListData.elementAt(searchUsers(int.parse(toUsers.elementAt(index).id))).username,
                                    usersSwipeListData.elementAt(searchUsers(int.parse(toUsers.elementAt(index).id))).linkToIMG,
                                    true, searchUsers(int.parse(toUsers.elementAt(index).id)))
                        );
                      } else {
                        return Center(
                          child: CollectionSlideTransition(
                            children: const <Widget>[
                              Icon(Icons.accessible),
                              Icon(Icons.arrow_right_alt),
                              Icon(Icons.accessible_forward_sharp),
                            ],
                          ),
                        );
                      }
                    },
                  ),
                )),
            Padding(
              padding: const EdgeInsets.only(left: 1078, top: 0),
              child: Column(
                children: [
                  Text(
                    "События: ",
                    style:
                        TextStyle(fontSize: 28, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    width: 1,
                    height: 11,
                  ),
                  Container(
                    width: 650,
                    height: 59,
                    decoration: BoxDecoration(
                        color: Color.fromRGBO(255, 225, 238, 1),
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        border: Border.all(color: Colors.white, width: 1),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black.withOpacity(0.25),
                              spreadRadius: 1,
                              blurRadius: 1,
                              offset: Offset(0, 1))
                        ]),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                            width: 83,
                            height: 39,
                            child: ElevatedButton(
                              onPressed: () {},
                              child: Text(
                                "Все",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 28,
                                    fontWeight: FontWeight.w300),
                              ),
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateColor
                                      .resolveWith((states) =>
                                          Color.fromRGBO(225, 182, 200, 1)),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ))),
                            )),
                        SizedBox(width: 37, height: 1),
                        Container(
                            width: 110,
                            height: 39,
                            child: ElevatedButton(
                              onPressed: () {},
                              child: Text(
                                "Гости",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 28,
                                    fontWeight: FontWeight.w300),
                              ),
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateColor
                                      .resolveWith((states) =>
                                          Color.fromRGBO(225, 182, 200, 1)),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ))),
                            )),
                        SizedBox(width: 37, height: 1),
                        Container(
                            width: 115,
                            height: 39,
                            child: ElevatedButton(
                              onPressed: () {},
                              child: Text(
                                "Лайки",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 28,
                                    fontWeight: FontWeight.w300),
                              ),
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateColor
                                      .resolveWith((states) =>
                                          Color.fromRGBO(225, 182, 200, 1)),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ))),
                            )),
                        SizedBox(width: 37, height: 1),
                        Container(
                            width: 195,
                            height: 39,
                            child: ElevatedButton(
                              onPressed: () {},
                              child: Text(
                                "Избранные",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 28,
                                    fontWeight: FontWeight.w300),
                              ),
                              style: ButtonStyle(
                                  backgroundColor: MaterialStateColor
                                      .resolveWith((states) =>
                                          Color.fromRGBO(225, 182, 200, 1)),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ))),
                            )),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 1,
                    height: 75,
                  ),
                  Flexible(
                    child: SizedBox(
                      width: 1000,
                      child: ListView.builder(
                        controller: _scrollController,
                          itemCount: 15,
                          itemBuilder: (BuildContext context, int index) =>
                              NewContactWidget(
                                  user,
                                  context,
                                  Color.fromRGBO(255, 239, 246, 1),
                                  "Хотите написать первое сообщение?",
                                  "Match! Вы понравились Курсед ;)","test", false,0)),
                    ),
                  ),
                  SizedBox(
                    width: 1100,
                    height: 1,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
