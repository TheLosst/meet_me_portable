//import 'dart:ffi';
import 'dart:math';

import 'package:meet_me_portable/Utils/ListMessages.dart';
import 'package:swipe_cards/swipe_cards.dart';

import 'MessagesClass.dart';
import 'User.dart';

const List<String> defaultText = ["Укажите свой пол","С кем вы хотите познакомиться?","Какая у вас цель      знакомства?","какого роста Вы ищете","какого веса Вы ищете","Как Вас зовут?","Когда у Вас день рождения?","Найдено"];
const List<String> sex = ["Мужчина", "Женщина"];
const List<String> withSex = ["С мужчинами","С женщинами","Со всеми"];
const List<String> targetMeeting = ["Отношения","Флирт","Встреча, свидание"];
const List<String> peopleHeight = ["До 170 см", "От 170 до 190 см", "Выше 190", "Любого"];
const List<String> peopleFat = ["До 60 кг","От 60 до 80 кг","От 80 до 100 кг","Любого"];
const String next = "Далее";
const List<String> registerMail = ["Регистрация с почтой", "Электронная почта", "Введите электронную почту"];
const List<String> loginField = ["Ваше имя","Введите Ваше имя"];
const List<String> birthday = ["День","Месяц","Год"];
//List<bool> kekv = [true,false,true,false,true,false,true,false,true,false,true,false,true,false,true,false,true,false,true,false,true,false,];
String chooseSex = "TestValue";

List<User> usersSwipeListData = [];
List<ListMessages> toUsers = [];

int matchNumber = Random().nextInt(1500)%10*10;

User user = User(id: 0 ,sex: "0",withMeets: "null",targetMeet: "null",targetHeight: "null",targetFat: "null",username: "null",birthDay: "null",email: "null",password: "null",liked: "0",aboutUser: "Тут пусто...",linkToIMG: "null");
late User userLoggined;
User messageTo = user;

int currentPageIndex = 2;

late int index_users_chat;

late Future<List<User>> usersToSwipe;

MatchEngine matchEngine = MatchEngine();

String connIp = "http://192.168.56.108:80";
List<Messages> mes = [];

final regExpLogin = RegExp(
    r'[\^$*.\[\]{}()?\-"!@#%&/\,><:;_~`+='
    ']'
);

final regExpEmail = RegExp(
    r'[@.'
    ']'
);

