import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meet_me_portable/Pages/Registration/found_matches.dart';
import 'package:meet_me_portable/Utils/pink_button.dart';
import 'package:meet_me_portable/Utils/globals.dart';
import '../../Utils/InputFormatterDate.dart';
import '../../Utils/Push.dart';
import '../../Utils/horizontal_divider.dart';

class WhensYourBirthday extends StatelessWidget {
  const WhensYourBirthday({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MeetMe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WhensYourBirthdayPage(title: 'MeetMe'),
    );
  }
}

class WhensYourBirthdayPage extends StatefulWidget {
  const WhensYourBirthdayPage({Key? key, required this.title})
      : super(key: key);

  final String title;

  @override
  State<WhensYourBirthdayPage> createState() => _WhensYourBirthdayPageState();
}

class _WhensYourBirthdayPageState extends State<WhensYourBirthdayPage> {
  get cursorColor => cursorColor(const Color(0x00000000));

  final TextEditingController dayInputController = TextEditingController();
  final TextEditingController monthInputController = TextEditingController();
  final TextEditingController yearInputController = TextEditingController();

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
                  const HorizontalDivider(height: 30),
                  Center(
                    child: Text(
                      defaultText[6],
                      style: const TextStyle(fontSize: 30),
                    ),
                  ),
                  const HorizontalDivider(height: 70),
                  Center(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 80,
                          height: 0,
                        ),
                        Center(
                          child: SizedBox(
                            width: 107,
                            height: 59,
                            child: TextFormField(
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              keyboardType: TextInputType.number,
                              controller: dayInputController,
                              maxLength: 2,
                              decoration: InputDecoration(
                                  //prefixIcon: Icon(Icons.account_box),
                                  //border: OutlineInputBorder(),
                                  hintText: birthday[0]),
                              validator: (String? input) {
                                return (input != null) ? 'Login incorrect' : null;
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 53,
                          height: 0,
                        ),
                        Center(
                          child: SizedBox(
                            width: 107,
                            height: 59,
                            child: TextFormField(
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              keyboardType: TextInputType.number,
                              controller: monthInputController,
                              maxLength: 2,
                              decoration: InputDecoration(
                                  //prefixIcon: Icon(Icons.account_box),
                                  //border: OutlineInputBorder(),
                                  hintText: birthday[1]),
                              validator: (String? input) {
                                return (input != null) ? 'Login incorrect' : null;
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 53,
                          height: 0,
                        ),
                        Center(
                          child: SizedBox(
                            width: 107 ,
                            height: 59,
                            child: TextFormField(
                              inputFormatters: <TextInputFormatter>[
                                //DateTextFormatter(),
                                //FilteringTextInputFormatter.allow(RegExp('\\d{0,2}\.\?\\d{0,2}\.\\d{0,4}')),
                              ],
                              //keyboardType: TextInputType.number,
                              controller: yearInputController,
                              maxLength: 4,
                              decoration: InputDecoration(
                                  //prefixIcon: Icon(Icons.account_box),
                                  //border: OutlineInputBorder(),
                                  hintText: birthday[2],

                              ),
                              validator: (String? input) {
                                return (input != null) ? 'Login incorrect' : null;
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const HorizontalDivider(height: 50),
                  ButtonPink(
                    text: next,
                    width: 700,
                    height: 120,
                    getSexed: (){
                      user.birthDay = (dayInputController.text + "." + monthInputController.text + "." + yearInputController.text);
                      Push().PushTo(FoundMatches(), context);
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
