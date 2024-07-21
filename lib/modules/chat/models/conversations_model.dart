import 'dart:convert';

class ConversationModel {
  int conversationId;
  String lastMessage;
  String lastMessageTime;
  List<Participant> participants;

  ConversationModel({
    required this.conversationId,
    required this.lastMessage,
    required this.lastMessageTime,
    required this.participants,
  });

  factory ConversationModel._fromJson(Map<String, dynamic> json) =>
      ConversationModel(
        conversationId: json["conversationId"],
        lastMessage: json["lastMessage"],
        lastMessageTime: json["lastMessageTime"],
        participants: List<Participant>.from(
            json["participants"].map((x) => Participant.fromJson(x))),
      );

  static List<ConversationModel> fromResponse(String str) =>
      List<ConversationModel>.from(
          json.decode(str).map((x) => ConversationModel._fromJson(x)));
}

class Participant {
  int id;
  String fullName;

  Participant({
    required this.id,
    required this.fullName,
  });

  factory Participant.fromJson(Map<String, dynamic> json) => Participant(
        id: json["id"],
        fullName: json["fullName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "fullName": fullName,
      };
}