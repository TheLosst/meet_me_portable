import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meet_me_portable/Pages/MeetMeProfile.dart';
import 'package:meet_me_portable/Utils/pink_button.dart';
import 'package:meet_me_portable/Utils/globals.dart';
import '../../Utils/Push.dart';
import '../../Utils/User.dart';
import '../../Utils/horizontal_divider.dart';
import '../MeetMeSlidePeople.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:crypto/crypto.dart';



class FoundMatches extends StatelessWidget {
  const FoundMatches({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MeetMe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const FoundMatchesPage(title: 'MeetMe'),
    );
  }
}

class FoundMatchesPage extends StatefulWidget {
  const FoundMatchesPage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<FoundMatchesPage> createState() => _FoundMatchesPageState();
}

class _FoundMatchesPageState extends State<FoundMatchesPage> {
  get cursorColor => cursorColor(const Color(0x00000000));

  final TextEditingController emailInputController = TextEditingController();
  final TextEditingController passwordInputController = TextEditingController();

  register(User user1) async {
    var apiUrl = "$connIp/registerMeetMe.php";
    String securePassword = md5.convert(utf8.encode(user1.password)).toString();
    var response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        "Access-Control-Allow-Origin": "*",
        "Accept": "application/json",
        'Accept': '*/*'
      },
      body: {
        "sex": user1.sex,
        "username": user1.username,
        "password": securePassword,
        "email": user1.email,
        "withMeets": user1.withMeets.toString(),
        "targetMeet": user1.targetMeet.toString(),
        "targetHeight": user1.targetHeight.toString(),
        "targetFat": user1.targetFat.toString(),
        "birthDay": user1.birthDay,
        "liked": user1.liked,
        "aboutUser": user1.aboutUser
      },
    );
    print("aaaaaaaaaaaaaa \n\n${response.body}\n\n aaaaaaaaaaaa");
    var data = json.decode(response.body);

    switch (data) {
      case ("Error"):
        // Fluttertoast.showToast(
        //     msg: "Ошибка регистрации",
        //     toastLength: Toast.LENGTH_LONG,
        //     fontSize: 26,
        //     gravity: ToastGravity.TOP,
        //     backgroundColor: Colors.transparent,
        //     textColor: Colors.white);
        print("USER ALREADY EXISTS: ${user.username}");
        break;
      case ("Success"):
        print("\n\nSUCCESS\nUSER ADDED: ${user.username}");
        // Fluttertoast.showToast(
        //     msg: "Регистрация пользователя "
        //         "${usernameController.text}"
        //         " успешна",
        //     toastLength: Toast.LENGTH_SHORT,
        //     fontSize: 15,
        //     gravity: ToastGravity.TOP,
        //     backgroundColor: Colors.transparent,
        //     textColor: Colors.white);
        Push().PushTo(Profile(), context);
        break;
      default:
        // Fluttertoast.showToast(
        //     msg: "Нет соеденения с сервером",
        //     toastLength: Toast.LENGTH_LONG,
        //     fontSize: 26,
        //     gravity: ToastGravity.TOP,
        //     backgroundColor: Colors.transparent,
        //     textColor: Colors.white);
        break;
    }

    // if (data == "Error") {
    //
    //   return "E";
    // } else {
    //
    //   return "S";
    // }
  }
  @override
  Widget build(BuildContext context1) {
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
              height: 358,
              child: Column(
                children: [
                  const HorizontalDivider(height: 50),
                  Center(
                    child: Text(
                     matchNumber%2 != 0 ? "${defaultText[7]} $matchNumber $chooseSex" : "${defaultText[7]} $matchNumber $chooseSex",
                      style: const TextStyle(fontSize: 40),
                    ),
                  ),
                  const HorizontalDivider(height: 40),
                  Center(
                    child: SizedBox(
                      width: 356,
                      height: 75,
                      child: TextFormField(
                        controller: emailInputController,
                        maxLength: 32,
                        decoration: InputDecoration(
                          //prefixIcon: Icon(Icons.account_box),
                          //border: OutlineInputBorder(),
                          hintText: registerMail[2],
                        ),
                        validator: (String? input) {
                          return (input != null) ? 'Login incorrect' : null;
                        },
                      ),
                    ),
                  ),
                  Center(
                    child: SizedBox(
                      width: 356,
                      height: 75,
                      child: TextFormField(
                        controller: passwordInputController,
                        maxLength: 32,
                        decoration: InputDecoration(
                          //prefixIcon: Icon(Icons.account_box),
                          //border: OutlineInputBorder(),
                          hintText: "Ведите пароль",
                        ),
                        validator: (String? input) {
                          return (input != null) ? 'password incorrect' : null;
                        },
                      ),
                    ),
                  ),
                  ButtonPink(
                    text: registerMail[0],
                    width: 800,
                    height: 120,
                    getSexed: () {
                      user.email = emailInputController.text;
                      user.password = passwordInputController.text;
                      //User test = User();
                      register(user);
                      user.getAll();
                      Push().PushTo(SlideMe(), context);
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
