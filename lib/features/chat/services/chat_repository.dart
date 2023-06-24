import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../common/services/firebase_service.dart';
import '../../../models/chat.dart';

class ChatRepository {
  static Stream<List<Chat>> getChats() {
    return FirebaseService.firestore
        .collection('users')
        .doc(FirebaseService.auth.currentUser!.uid)
        .collection('chats')
        .orderBy('timeSent', descending: true)
        .snapshots()
        .asyncMap<List<Chat>>((event) async {
      List<String> userIds = event.docs
          .map((chatDoc) => chatDoc.data()['userId'] as String)
          .toList();
      var userSnapshots = await FirebaseService.firestore
          .collection('users')
          .where(FieldPath.documentId, whereIn: userIds)
          .get();

      Map<String, Map<String, dynamic>> userMap = {};
      for (var userDoc in userSnapshots.docs) {
        userMap[userDoc.id] = {
          'name': userDoc.get('name'),
          'imageUrl': userDoc.get('imageUrl')
        };
      }

      List<Chat> chats = event.docs.map((chatDoc) {
        var chatData = chatDoc.data();
        String id = chatData['id'];
        String lastMessage = chatData['lastMessage'];
        Timestamp timeSent = chatData['timeSent'];
        String userId = chatData['userId'];

        String name = userMap[userId]?['name'];
        String imageUrl = userMap[userId]?['imageUrl'];

        return Chat(
          id: id,
          userId: userId,
          name: name,
          imageUrl: imageUrl,
          lastMessage: lastMessage,
          timeSent: timeSent,
        );
      }).toList();

      return chats;
    });
  }
}
