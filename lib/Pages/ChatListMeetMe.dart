import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meet_me_portable/Utils/Push.dart';
import 'package:progress_indicators/progress_indicators.dart';

import '../Utils/ListMessages.dart';
import '../Utils/MessagesClass.dart';
import '../Utils/User.dart';
import '../Utils/globals.dart';
import 'package:http/http.dart' as http;

import '../private_chat.dart';
import 'ItemsToBuild/NewContatsWidget.dart';
import 'MeetMeEvents.dart';

class MessageList extends StatelessWidget {
  const MessageList({super.key});

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

  Future sentMessage(String s) async {
    final response =
        await http.post(Uri.parse('$connIp/sendMessage.php'), body: {
      "fromUsr": userLoggined.id.toString(),
      "toUsr": messageTo.id.toString(),
      "text": s
    });
    print(json.decode(response.body));
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: 515,
          height: 800,
          child: FutureBuilder<List?>(
            future: buildListMess(),
            builder: (BuildContext context, AsyncSnapshot<List?> snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                return ListView.builder(
                    itemCount: toUsers.length,
                    itemBuilder: (BuildContext context, int index1) =>
                        GestureDetector(
                              onTap: () {
                                index_users_chat = searchUsers(int.parse(toUsers.elementAt(index1).id));
                                Push().PushTo(PrivateChat(), context);
                              },
                          child: NewContactWidget(
                              user,
                              context,
                              Color.fromRGBO(255, 239, 246, 1),
                              usersSwipeListData
                                  .elementAt(searchUsers(
                                      int.parse(toUsers.elementAt(index1).id)))
                                  .targetMeet,
                              usersSwipeListData
                                  .elementAt(searchUsers(
                                      int.parse(toUsers.elementAt(index1).id)))
                                  .username,
                              usersSwipeListData
                                  .elementAt(searchUsers(
                                      int.parse(toUsers.elementAt(index1).id)))
                                  .linkToIMG,
                              true,
                              searchUsers(
                                  int.parse(toUsers.elementAt(index1).id))),
                        ));
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
        ),
    );
  }
}
