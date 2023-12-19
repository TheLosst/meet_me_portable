import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/number_symbols_data.dart';
import 'package:meet_me_portable/Pages/MeetMeProfile.dart';
import 'package:meet_me_portable/Pages/MeetMeSlidePeople.dart';
import 'package:meet_me_portable/Utils/Push.dart';
import 'package:meet_me_portable/Utils/User.dart';
import 'package:meet_me_portable/Utils/globals.dart';
import 'package:meet_me_portable/Utils/horizontal_divider.dart';

import '../AppBars/meetme_appbar.dart';
import '../Utils/InputFormatterDate.dart';
import 'MeetMeChat.dart';
import 'MeetMeEvents.dart';
import 'MeetMeSearch.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class EditProfile extends StatelessWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MeetMe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const EditProfilePage(),
    );
  }
}

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  @override
  Widget build(BuildContext context) {
    final separator = numberFormatSymbols["US"]?.DECIMAL_SEP ?? '.';
    final now = DateTime.now();
    TextEditingController myName =
        TextEditingController(text: "Имя: ${userLoggined.username}");
    TextEditingController age =
        TextEditingController(text: "${userLoggined.birthDay}");
    TextEditingController myInterest = TextEditingController(
        text: "Меня интересует: ${userLoggined.withMeets}");
    TextEditingController meetingAge = TextEditingController(
        text:
            "В возрасте: ${now.year - int.parse(userLoggined.birthDay.replaceRange(0, 6, ""))}");
    TextEditingController targetMeet =
        TextEditingController(text: "Цель: ${userLoggined.targetMeet}");
    TextEditingController aboutUsr =
        TextEditingController(text: "Описание: ${userLoggined.aboutUser} ");
    TextEditingController linkToIMG =
    TextEditingController(text: userLoggined.linkToIMG);
    Future editAndGetProfile() async {
      var apiUrl = "$connIp/EditProfile.php";
      var response = await http.post(Uri.parse(apiUrl),
          body: {
            "id":         userLoggined.id.toString(),
            "username":   userLoggined.username,
            "birthDate":  userLoggined.birthDay,
            "withMeets":  userLoggined.withMeets,
            "targetMeet": userLoggined.targetMeet,
            "about":      userLoggined.aboutUser,
            "link":       userLoggined.linkToIMG
      });
      //print(user.username);
      print(response.body);
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Моя анкета",
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600),
        ),
        backgroundColor: Color.fromRGBO(228, 122, 167, 1),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              FittedBox(
                fit: BoxFit.contain,
                child: Container(
                  width: 480,
                  height: 620,
                  foregroundDecoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                        userLoggined.linkToIMG,
                      ),
                      fit: BoxFit.fill
                    )
                  ),
                ),
                // child: Image.network(
                //   userLoggined.linkToIMG,
                //   width: 416,
                //   height: 664,
                // ),
              ),
              TextFormField(
                controller: myName,
                maxLength: 20,
              ),
              TextFormField(
                controller: age,
                maxLength: 32,
                keyboardType: TextInputType.number,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(
                      '\\d{0,2}\.\?\\d{0,2}\.\\d{0,4}')),
                  DateTextFormatter(),
                ],
              ),
              Text(
                "Регион: Россия, Москва",
              ),
              SizedBox(
                height: 11,
                width: 1,
              ),
              TextFormField(
                controller: myInterest,
                maxLength: 32,
              ),
              TextFormField(
                controller: meetingAge,
                maxLength: 32,
              ),
              SizedBox(
                height: 11,
                width: 1,
              ),
              TextFormField(
                controller: targetMeet,
                maxLength: 32,
              ),
              SizedBox(
                height: 11,
                width: 1,
              ),
              TextFormField(
                controller: aboutUsr,
                maxLength: 999,
              ),
              SizedBox(
                height: 11,
                width: 1,
              ),
              TextFormField(
                controller: linkToIMG,
                maxLength: 9999,
              ),
              ElevatedButton(
                onPressed: () {
                  userLoggined.username = myName.text.toString().replaceFirst("Имя: ", "");
                  userLoggined.birthDay = age.text.toString();
                  userLoggined.withMeets = myInterest.text.toString().replaceFirst("Меня интересует: ", "");
                  userLoggined.targetMeet = targetMeet.text.toString().replaceFirst("Цель: ", "");
                  userLoggined.aboutUser = aboutUsr.text.toString().replaceFirst("Описание: ", "");
                  userLoggined.linkToIMG = linkToIMG.text;
                  userLoggined.getAll();
                  editAndGetProfile();
                  Push().PushTo(Profile(), context);
                },
                child: Text(
                  "Сохранить изменения",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 28,
                      fontWeight: FontWeight.w600),
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStateColor.resolveWith(
                        (states) =>
                            Color.fromRGBO(255, 239, 246, 1)),
                    shape: MaterialStateProperty.all<
                            RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                            side:
                                BorderSide(color: Colors.white)))),
              )
            ],
          ),
        ),
      ),
    );
  }
}
