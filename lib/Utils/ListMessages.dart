class ListMessages {
  ListMessages({required this.id});

  late String id;

  factory ListMessages.fromJson(json) => ListMessages(
        id: json['toUsr'].toString(),
      );
}
