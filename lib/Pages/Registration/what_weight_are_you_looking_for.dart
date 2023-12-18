import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:meet_me_portable/Pages/Registration/what_is_your_name.dart';
import 'package:meet_me_portable/Utils/pink_button.dart';
import 'package:meet_me_portable/Utils/globals.dart';
import '../../Utils/Push.dart';
import '../../Utils/horizontal_divider.dart';

class WhatWeightAreYouLookingFor extends StatelessWidget {
  const WhatWeightAreYouLookingFor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MeetMe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WhatWeightAreYouLookingForPage(),
    );
  }
}

class WhatWeightAreYouLookingForPage extends StatefulWidget {
  const WhatWeightAreYouLookingForPage({Key? key}) : super(key: key);

  @override
  State<WhatWeightAreYouLookingForPage> createState() =>
      _WhatIsYourPurposeOfDatingState();
}

class _WhatIsYourPurposeOfDatingState
    extends State<WhatWeightAreYouLookingForPage> {
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
                      chooseSex + defaultText[4],
                      style: const TextStyle(
                        fontSize: 40,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const HorizontalDivider(height: 45),
                  ButtonPink(
                    text: peopleFat[0],
                    width: 700,
                    height: 120,
                    getSexed: () {
                      user.targetFat = "60";
                      Push().PushTo(WhatIsYourName(), context);
                    },
                  ),
                  const HorizontalDivider(height: 30),
                  ButtonPink(
                    text: peopleFat[1],
                    width: 700,
                    height: 120,
                    getSexed: () {
                      user.targetFat = "80";
                      Push().PushTo(WhatIsYourName(), context);
                    },
                  ),
                  const HorizontalDivider(height: 30),
                  ButtonPink(
                    text: peopleFat[2],
                    width: 700,
                    height: 120,
                    getSexed: () {
                      user.targetFat = "100";
                      Push().PushTo(WhatIsYourName(), context);
                    },
                  ),
                  const HorizontalDivider(height: 30),
                  ButtonPink(
                    text: peopleFat[3],
                    width: 700,
                    height: 120,
                    getSexed: () {
                      user.targetFat = "0";
                      Push().PushTo(WhatIsYourName(), context);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
