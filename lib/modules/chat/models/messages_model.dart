import 'dart:convert';

class MessageModel {
  int id;
  String message;
  int senderId;
  int receiverId;
  int conversationId;
  DateTime createdAt;

  MessageModel({
    required this.id,
    required this.message,
    required this.senderId,
    required this.receiverId,
    required this.conversationId,
    required this.createdAt,
  });

  factory MessageModel._fromJson(Map<String, dynamic> json) => MessageModel(
        id: json["id"],
        message: json["message"],
        senderId: json["senderId"],
        receiverId: json["receiverId"],
        conversationId: json["conversationId"],
        createdAt: DateTime.parse(json["createdAt"]),
      );

  static List<MessageModel> fromResponseBody(String str) =>
      List<MessageModel>.from(
          json.decode(str).map((x) => MessageModel._fromJson(x)));
}
