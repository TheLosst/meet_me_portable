import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:meet_me_portable/Utils/globals.dart';

import '../../Utils/User.dart';
import '../../Utils/horizontal_divider.dart';

class MyCard extends StatelessWidget {
  const MyCard({
    Key? key, required this.user
  }) : super(key: key);

  final User? user;



  @override
  Widget build(BuildContext context) {
    //MyCard kek = MyCard(user: user);
    return FittedBox(
      fit: BoxFit.contain,
      child: Container(
        width:  350,
        height:  250,
        decoration: BoxDecoration(
          color: Color.fromRGBO(255, 225, 238, 1),
          borderRadius: BorderRadius.all(Radius.circular(40)),
          border: Border.all(color: Colors.white, width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 1,
              offset: Offset(1, 1), // Shadow position
            ),
          ],
        ),
        child: Container(
          width: 120,
          height:  100,
          child: Row(
            children: [
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(
                    left: 10),
                height:  150,
                width:  150,
                decoration: BoxDecoration(),
                child: Center(
                  child: Container(
                    width: 150,
                    foregroundDecoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                        image: DecorationImage(
                            image: NetworkImage(
                              user!.linkToIMG,
                            ),
                            fit: BoxFit.fill
                        )
                    ),
                  )
                    // child: Image.network(
                    //   kek.user!.linkToIMG,
                    //   width: MediaQuery.of(context).size.width * 0.23,
                    //   height: MediaQuery.of(context).size.height * 0.6,
                    // )
                ),
              ),
              SizedBox(
                width:  150,
                child: Center(
                  child: Container(
                    //color: Colors.black,
                    width:  250,
                    height:  300,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HorizontalDivider(height: 15),
                        FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              "${user!.username}, ${user!.birthDay}",
                              textAlign: TextAlign.left,
                              style: TextStyle(fontSize: 24),
                            )),
                        FittedBox(
                            fit: BoxFit.scaleDown,
                            child: Text(
                              "Из Москвы, 1 км от вас",
                              softWrap: true,
                              style: TextStyle(
                                  fontSize: 24, color: Colors.black45),
                            )),
                        HorizontalDivider(height: 1),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Container(
                            width:  100,
                            height:
                             50,
                            child: Text( //TODO сделать скалирование
                              user!.targetMeet,
                              softWrap: true,
                              style: TextStyle(fontSize: 10),
                            ),
                          ),
                        ),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Container(
                            width:  200,
                            height: 50,
                            child: Text( //TODO сделать скалирование
                              user!.aboutUser,
                              style: TextStyle(fontSize: 15),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                        HorizontalDivider(height: 2),
                        HorizontalDivider(height: 2),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 50,
                              height: 50,
                              child: IconButton(
                                  onPressed: () {
                                    matchEngine.currentItem?.nope();
                                    print("</3");
                                  },
                                  icon: Image.asset(
                                    "lib/Icons/broken-heart 1.png",
                                  )),
                            ),
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: SizedBox(
                                width: 50,
                                height: 50,
                                child: IconButton(
                                    onPressed: () {
                                      matchEngine.currentItem?.like();
                                      print("<3");
                                    },
                                    icon: Image.asset(
                                        "lib/Icons/heart colored.png")),
                              ),
                            ),
                            FittedBox(
                              fit: BoxFit.scaleDown,
                              child: SizedBox(
                                width: 50,
                                height: 50,
                                child: IconButton(
                                    onPressed: () {
                                      currentPageIndex = 1;
                                      matchEngine.currentItem?.superLike();
                                      print("Chat");
                                    },
                                    icon: Image.asset(
                                        "lib/Icons/conversation 1.png")),
                              ),
                            )
                          ],
                        ),

                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}