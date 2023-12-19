import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../Pages/ChatListMeetMe.dart';
import '../Pages/MeetMeChat.dart';
import '../Pages/MeetMeEditProfile.dart';
import '../Pages/MeetMeEvents.dart';
import '../Pages/MeetMeProfile.dart';
import '../Pages/MeetMeSearch.dart';
import '../Pages/MeetMeSlidePeople.dart';
import '../Utils/globals.dart';

class BottomNavBarMeetMe extends StatefulWidget {
  const BottomNavBarMeetMe({super.key});

  @override
  State<BottomNavBarMeetMe> createState() => _BottomNavBarMeetMeState();
}

class _BottomNavBarMeetMeState extends State<BottomNavBarMeetMe> {


  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        indicatorColor: Colors.amber,
        selectedIndex: currentPageIndex,
        destinations: <Widget>[
          NavigationDestination(
            selectedIcon: Image.asset(
              "lib/Icons/heart 1.png",
              color: Colors.black,
            ),
            icon: Image.asset(
              "lib/Icons/heart 1.png",
              color: Colors.black,
            ),
            label: 'Знакомства',
          ),
          NavigationDestination(
            icon: Badge(
              label: Text('2'),
              child: Image.asset("lib/Icons/conversation 1.png",
                  color: Colors.black),
            ),
            label: 'Сообщения',
          ),
          NavigationDestination(
            icon: Image.asset("lib/Icons/user 1.png", color: Colors.black),
            label: 'Профиль',
          ),
        ],
      ),
      body: <Widget>[
        SlideMe(),
        MessageList(),
        Profile(),
      ][currentPageIndex],
    );
  }
}
