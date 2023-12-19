import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:meet_me_portable/Utils/Push.dart';
import 'package:meet_me_portable/Utils/pink_button.dart';
import 'package:progress_indicators/progress_indicators.dart';

import 'AppBars/bottom_nav_bar.dart';
import 'Pages/MeetMeEvents.dart';
import 'Utils/ListMessages.dart';
import 'Utils/MeetMeMessageBar.dart';
import 'Utils/MessagesClass.dart';
import 'Utils/MyChatBubles.dart';
import 'Utils/User.dart';
import 'Utils/globals.dart';

class PrivateChat extends StatefulWidget {
  const PrivateChat({super.key});
  @override
  State<PrivateChat> createState() => _PrivateChatState();
}

class _PrivateChatState extends State<PrivateChat> {
  Future<List<Messages>> createMessage() async {
    mes = await fetchAllMessage();
    return mes;
  }

  Future<List<Messages>> fetchAllMessage() async {
    final response = await http.post(Uri.parse('$connIp/getMessage.php'),
        body: {
          "id": userLoggined.id.toString(),
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

  void rebuildAllChildren(BuildContext context) {
    void rebuild(Element el) {
      el.markNeedsBuild();
      el.visitChildren(rebuild);
    }
    (context as Element).visitChildren(rebuild);
  }

  Future sentMessage(String s, context) async {

    final response =
        await http.post(Uri.parse('$connIp/sendMessage.php'), body: {
      "fromUsr": userLoggined.id.toString(),
      "toUsr": (messageTo.id - 3).toString(),
      "text": s
    });
    print(json.decode(response.body));
    Push().PushTo(PrivateChat(), context);
  }

  Future<List<ListMessages>> getListSendedUsers() async {
    final response =
        await http.post(Uri.parse('$connIp/getUserIDToSended.php'), body: {
      "id": userLoggined.id.toString(),
    });
    print(json.decode(response.body));
    return json
        .decode(response.body)
        .map<ListMessages>(ListMessages.fromJson)
        .toList();
  }

  Future<List?> buildListMess() async {
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

  ScrollController _chatScroll = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(usersSwipeListData.elementAt(searchUsers(int.parse(toUsers.elementAt(index_users_chat).id))).username),
        actions: [
          ElevatedButton(onPressed: (){Push().PushTo(BottomNavBarMeetMe(), context);}, child: Text("Back"), style: ElevatedButton.styleFrom(
            primary: Colors.transparent,
            shadowColor: Colors.transparent,
            onPrimary: Colors.pinkAccent,
          ),),
        ],
        backgroundColor: Color.fromRGBO(228, 122, 167, 1),
      ),
        body: Stack(children: [
      Container(
        width: double.infinity,
        height: double.infinity,
        child: FutureBuilder<List<Messages>>(
            future: createMessage(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Messages>?> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return ListView.builder(
                  controller: _chatScroll,
                  itemCount: mes.length,
                  itemBuilder: (BuildContext context, int index) => MeetMeBubble(
                    text: mes.elementAt(index).text,
                    color: Color.fromRGBO(237, 212, 223, 1),
                    seen: true,
                    tail: false,
                    isSender: mes.elementAt(index).fromUser ==
                            userLoggined.id.toString()
                        ? true
                        : false,
                    nameSender: usersSwipeListData
                        .elementAt(
                            searchUsers(int.parse(mes.elementAt(index).fromUser)))
                        .username,
                  ),
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
            }),
      ),
          Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 20),
                child: MeetMeMessageBar(
                  sendButtonColor: Color.fromRGBO(232, 189, 208, 1),
                  messageBarColor: Colors.transparent,
                  onSend: (_) => sentMessage(_,context),
                  actions: [],
                ),
              ))
    ]));
  }
}
