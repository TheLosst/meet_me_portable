import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meet_me_portable/Pages/ItemsToBuild/NewContatsWidget.dart';
import 'package:meet_me_portable/Utils/ListMessages.dart';
import 'package:meet_me_portable/Utils/MeetMeMessageBar.dart';
import 'package:meet_me_portable/Utils/MessagesClass.dart';

//import '../AppBars/meetme_appbar.dart';
import 'package:http/http.dart' as http;
import 'package:progress_indicators/progress_indicators.dart';
import '../Utils/MyChatBubles.dart';
import '../Utils/Push.dart';
import '../Utils/User.dart';
import '../Utils/globals.dart';
import 'MeetMeEvents.dart';
import 'MeetMeProfile.dart';
import 'MeetMeSearch.dart';
import 'MeetMeSlidePeople.dart';

class MeetMeChat extends StatelessWidget {
  const MeetMeChat({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MeetMe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MeetMeChatPage(),
    );
  }
}

Future<List<Messages>> createMessage() async {
  mes = await fetchAllMessage();
  return mes;
}

Future<List<Messages>> fetchAllMessage() async {
  final response = await http.post(Uri.parse('$connIp/getMessage.php'),
      body: {"id": userLoggined.id.toString(),
            "toid": messageTo.id.toString()
      });
  if (response.statusCode == 200) {
    var buff = json.decode(response.body);
    print("object");
    print(buff);
    print("object");
    return buff.map<Messages>(Messages.fromJson).toList();
  } else {
    throw Exception('Все сломалось!');
  }
}


Future sentMessage(String s) async{
  final response = await http.post(Uri.parse('$connIp/sendMessage.php'),
      body: {"fromUsr": userLoggined.id.toString(),
              "toUsr": messageTo.id.toString(),
              "text": s
      });
  print(json.decode(response.body));
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


Future<void> createUsers() async {
  //List<DiskProp> test = await fetchDiskDescr();
  usersSwipeListData = await fetchAllUsers();
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


class MeetMeChatPage extends StatefulWidget {
  const MeetMeChatPage({Key? key}) : super(key: key);

  @override
  State<MeetMeChatPage> createState() => _MeetMeChatPageState();
}

class _MeetMeChatPageState extends State<MeetMeChatPage> {
  ScrollController _chatScroll = ScrollController();

  @override
  Widget build(BuildContext context) {
    createUsers();
    //buildListMess();
    //reloadIn30sec(context);
    return Scaffold(
      body: Center(
        child: FittedBox(
          fit: BoxFit.contain,
          child: Stack(
            children: [
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
                padding: EdgeInsets.only(left: 619, top: 98),
                child: Container(
                  height: 824,
                  width: 1100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(40)),
                    border: Border.all(color: Colors.white, width: 1),
                    color: Color.fromRGBO(255, 239, 246, 1),
                  ),
                  child: Stack(
                    children: [
                      Padding(
                          padding: EdgeInsets.only(top: 22, left: 36),
                          child: SizedBox(
                            width: 1028,
                            child: NewContactWidget(
                                user,
                                context,
                                Color.fromRGBO(232, 189, 208, 1),
                                messageTo.targetMeet.isEmpty
                                    ? " "
                                    : messageTo.targetMeet,
                                messageTo.username.isEmpty
                                    ? " "
                                    : messageTo.username,
                                messageTo.linkToIMG,false,0),
                          )),
                      Padding(
                        padding: EdgeInsets.only(top: 170, left: 64),
                        child: Container(
                          width: 970,
                          height: 575,
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(255, 239, 246, 1),
                            //border: Border(bottom: BorderSide(width: 1, color: Colors.white)),
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                          ),
                          child: FutureBuilder<List<Messages>>(
                              future: createMessage(),
                              builder: (BuildContext context,
                                  AsyncSnapshot<List<Messages>?> snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.done) {
                                  return ListView.builder(
                                    controller: _chatScroll,
                                    itemCount: mes.length,
                                    itemBuilder:
                                        (BuildContext context, int index) =>
                                            MeetMeBubble(
                                      text: mes.elementAt(index).text,
                                      color: Color.fromRGBO(237, 212, 223, 1),
                                      seen: true,
                                      tail: false,
                                      isSender: mes.elementAt(index).fromUser == userLoggined.id.toString() ? true : false,
                                      nameSender: usersSwipeListData.elementAt(searchUsers(int.parse(mes.elementAt(index).fromUser))).username,
                                    ),
                                  );
                                }
                                else
                                  {
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
                              }),
                        ),
                      ),
                      Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: EdgeInsets.only(bottom: 20),
                            child: MeetMeMessageBar(
                              sendButtonColor: Color.fromRGBO(232, 189, 208, 1),
                              messageBarColor: Colors.transparent,
                              onSend: (_) => sentMessage(_),
                              actions: [],
                            ),
                          ))
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
