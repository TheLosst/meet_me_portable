import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meet_me_portable/Pages/Registration/choose_sex_page.dart';
import 'package:meet_me_portable/Pages/Registration/what_is_your_purpose_of_dating.dart';

//import 'package:meet_me/Pages/Registration/what_is_your_purpose_of_dating.dart';
import 'package:meet_me_portable/Utils/pink_button.dart';
import 'package:meet_me_portable/Utils/globals.dart';
import '../../Utils/Push.dart';
import '../../Utils/horizontal_divider.dart';

class WhoDoYouWantToMeet extends StatelessWidget {
  const WhoDoYouWantToMeet({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MeetMe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WhoDoYouWantToMeetPage(),
    );
  }
}

class WhoDoYouWantToMeetPage extends StatefulWidget {
  const WhoDoYouWantToMeetPage({Key? key}) : super(key: key);

  @override
  State<WhoDoYouWantToMeetPage> createState() => _WhoDoYouWantToMeetPageState();
}

class _WhoDoYouWantToMeetPageState extends State<WhoDoYouWantToMeetPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color.fromRGBO(255, 64, 144, 1), Colors.black])),
        child: Center(
          child: FittedBox(
            fit: BoxFit.contain,
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  boxShadow: [
                    BoxShadow(
                        color: Color.fromRGBO(0, 0, 0, 0.25),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3))
                  ]),
              width: 595,
              height: 544,
              child: Column(
                children: [
                  const HorizontalDivider(height: 40),
                  Center(
                    child: Text(
                      defaultText[1],
                      style: const TextStyle(
                        fontSize: 40,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const HorizontalDivider(height: 80),
                  ButtonPink(
                      text: withSex[0],
                      width: 550,
                      height: 120,
                      getSexed: () {
                        user.withMeets = "0";
                        chooseSex = "Мужчин ";
                        Push().PushTo(WhatIsYourPurposeOfDating(), context);
                      }),
                  const HorizontalDivider(height: 30),
                  ButtonPink(
                      text: withSex[1],
                      width: 550,
                      height: 120,
                      getSexed: () {
                        user.withMeets = "1";
                        chooseSex = "Женщин ";
                        Push().PushTo(WhatIsYourPurposeOfDating(), context);
                      }),
                  const HorizontalDivider(height: 30),
                  ButtonPink(
                      text: withSex[2],
                      width: 550,
                      height: 120,
                      getSexed: () {
                        user.withMeets = "2";
                        chooseSex = "Людей ";
                        Push().PushTo(WhatIsYourPurposeOfDating(), context);
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
