import 'package:cloud_firestore/cloud_firestore.dart';

class Chat {
  final String userId;
  final String name;
  final String imageUrl;
  final String sentById;
  final String lastMessage;
  final Timestamp timeSent;

  Chat({
    required this.userId,
    required this.name,
    required this.imageUrl,
    required this.sentById,
    required this.lastMessage,
    required this.timeSent,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'name': name,
      'sentById': sentById,
      'imageUrl': imageUrl,
      'lastMessage': lastMessage,
      'timeSent': timeSent,
    };
  }

  factory Chat.fromMap(Map<String, dynamic> map) {
    return Chat(
      userId: map['userId'] as String,
      sentById: map['sentById'] as String,
      name: map['name'] as String,
      imageUrl: map['imageUrl'] as String,
      lastMessage: map['lastMessage'] as String,
      timeSent: map['timeSent'] as Timestamp,
    );
  }
}
