import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:creator_connect/models/message.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../models/chat.dart';

final chatRepository = ChatRepository(
  auth: FirebaseAuth.instance,
  firestore: FirebaseFirestore.instance,
);

class ChatRepository {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  ChatRepository({
    required this.auth,
    required this.firestore,
  });

  Stream<List<Chat>> getChats() {
    return firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .orderBy('timeSent', descending: true)
        .snapshots()
        .asyncMap<List<Chat>>((event) async {
      List<String> userIds = event.docs
          .map((chatDoc) => chatDoc.data()['userId'] as String)
          .toList();

      if (userIds.isEmpty) return [];

      var userSnapshots = await firestore
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
        String lastMessage = chatData['lastMessage'];
        Timestamp timeSent = chatData['timeSent'];
        String userId = chatData['userId'];

        String name = userMap[userId]?['name'];
        String imageUrl = userMap[userId]?['imageUrl'];

        return Chat(
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

  void addMessage({
    required String receiverUserId,
    required String message,
  }) async {
    try {
      Timestamp timeSent = Timestamp.now();
      _saveDataToChatSubcollection(receiverUserId, timeSent, message);
      _saveDataToMessageSubcollection(receiverUserId, timeSent, message);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  void _saveDataToChatSubcollection(
      String receiverUserId, Timestamp timeSent, String message) async {
    // save in current user's chats subcollection
    await firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .doc(receiverUserId)
        .set({
      'userId': receiverUserId,
      'lastMessage': message,
      'timeSent': timeSent
    });

    // save in receiver user's chat subcollection
    await firestore
        .collection('users')
        .doc(receiverUserId)
        .collection('chats')
        .doc(auth.currentUser!.uid)
        .set({
      'userId': auth.currentUser!.uid,
      'lastMessage': message,
      'timeSent': timeSent
    });
  }

  void _saveDataToMessageSubcollection(
      String receiverUserId, Timestamp timeSent, String message) async {
    // save in current user's messages subcollection
    var senderDocRef = firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .doc(receiverUserId)
        .collection('messages')
        .doc();

    final senderMessage = Message(
        id: senderDocRef.id,
        senderId: auth.currentUser!.uid,
        receiverId: receiverUserId,
        text: message,
        timeSent: timeSent,
        isSeen: true);

    await senderDocRef.set(senderMessage.toMap());

    // save in receiver user's messages subcollection
    var receiverDocRef = firestore
        .collection('users')
        .doc(receiverUserId)
        .collection('chats')
        .doc(auth.currentUser!.uid)
        .collection('messages')
        .doc();

    final receiverMessage = Message(
        id: receiverDocRef.id,
        senderId: auth.currentUser!.uid,
        receiverId: receiverUserId,
        text: message,
        timeSent: timeSent,
        isSeen: false);

    await receiverDocRef.set(receiverMessage.toMap());
  }

  Stream<List<Message>> getMessages({required String userId}) {
    return firestore
        .collection('users')
        .doc(auth.currentUser!.uid)
        .collection('chats')
        .doc(userId)
        .collection('messages')
        .orderBy('timeSent')
        .snapshots()
        .asyncMap<List<Message>>((event) {
      List<Message> messages = event.docs
          .map((messageDoc) => Message.fromMap(messageDoc.data()))
          .toList();

      return messages;
    });
  }
}
