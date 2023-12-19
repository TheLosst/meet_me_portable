import 'dart:convert';
//import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meet_me_portable/Pages/MeetMeProfile.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;

import '../../AppBars/bottom_nav_bar.dart';
import '../../Utils/Push.dart';
import '../../Utils/User.dart';
import '../../Utils/globals.dart';
import '../../Utils/horizontal_divider.dart';
import '../../Utils/pink_button.dart';
import '../MeetMeSlidePeople.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MeetMe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();

}



class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailInputController = TextEditingController();
    TextEditingController passwordInputController = TextEditingController();
    Future login(User user) async {
      var apiUrl = "$connIp/loginMeetMe.php"; //Устанавливаем ссылку на php скрипт для работы с базой данных
      var profilepage = "$connIp/profileMeetMe.php";
      String securePassword = md5.convert(utf8.encode(user.password)).toString();
      var response = await http.post(Uri.parse(apiUrl), body: {
        "email": user.email,
        "password": securePassword,
      });
      var responseProfile = await http.post(Uri.parse(profilepage), body: {
        "email": user.email,
      });
      print("Login php ${responseProfile.body}");
      var data = json.decode(response.body);



      //tempProfile = tempProfile.replaceFirst('[{email: ', '').replaceFirst('}]', '');

      if (data == "Success") {


        final profileJsonParsed = jsonDecode(responseProfile.body);
        print(profileJsonParsed);
        userLoggined = User.fromJson((profileJsonParsed[0]));
        print(userLoggined.email);
        print("\n\nSUCCESSFUL LOGIN, NICE :)");
        //user.setName(user.username);
        //user.setPassword(" ");
        //user.setEmail(tempProfile);

        Push().PushTo(BottomNavBarMeetMe(), context);
        //Navigator.push(context, MaterialPageRoute(builder: (context)=>DashBoard(),),);
      } else {
        // Fluttertoast.showToast(
        //     msg: "Ошибка входа, логин и/или пароль неверны!",
        //     toastLength: Toast.LENGTH_LONG,
        //     fontSize: 26,
        //     gravity: ToastGravity.TOP,
        //     backgroundColor: Colors.transparent,
        //     textColor: Colors.white
        // );
        print("ERROR: WRONG PASSWORD OR USERNAME");
      }
    }
    return Scaffold(
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
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
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
                    text: "Войти в аккаунт",
                    width: 350,
                    height: 59,
                    getSexed: () {
                      user.email = emailInputController.text;
                      user.password = passwordInputController.text;
                      //User test = User();
                      login(user);
                      user.getAll();
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
