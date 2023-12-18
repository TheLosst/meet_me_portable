class Messages
{
  String fromUser = " ";
  String toUser = " ";
  String text = " ";
  Messages({required this.fromUser,required this.toUser,required this.text});

  factory Messages.fromJson(json) => Messages(
      fromUser: json['fromUsr'].toString(),
      toUser: json['toUsr'].toString(),
      text: json['text'].toString(),
  );

}
