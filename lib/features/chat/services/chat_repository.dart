import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../common/services/firebase_service.dart';
import '../../../models/chat.dart';

class ChatRepository {
  static Future<List<Chat>> getChats() async {
    try {
      var chatsData = await FirebaseService.firestore
          .collection('users')
          .doc(FirebaseService.auth.currentUser!.uid)
          .collection('chats')
          .orderBy('timeSent', descending: true)
          .get();

      List<Future<Chat>> chats = chatsData.docs.map((chatDoc) async {
        var chatData = chatDoc.data();
        String id = chatData["id"];
        String lastMessage = chatData["lastMessage"];
        Timestamp timeSent = chatData["timeSent"];
        String userId = chatData['userId'];

        var userData = await FirebaseService.firestore
            .collection('users')
            .doc(userId)
            .get();

        String name = userData.get('name');
        String imageUrl = userData.get('imageUrl');

        return Chat(
          id: id,
          userId: userId,
          name: name,
          imageUrl: imageUrl,
          lastMessage: lastMessage,
          timeSent: timeSent,
        );
      }).toList();

      return Future.wait(chats);
    } catch (e) {
      throw Exception(e);
    }
  }
}
