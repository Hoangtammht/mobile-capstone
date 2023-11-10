import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fe_capstone/blocs/UserPreferences.dart';
import 'package:fe_capstone/models/ChatUser.dart';
import 'package:fe_capstone/models/Message.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebaseAPI {
  static FirebaseMessaging fcmMessaging = FirebaseMessaging.instance;
  static FirebaseFirestore fireStore = FirebaseFirestore.instance;

  static Future<String?> getFirebaseMessagingToken() async {
    await fcmMessaging.requestPermission();
    final fcmToken = await fcmMessaging.getToken();
    print('Token: $fcmToken');
    initPushNotifications();
    initLocalNotifications();
    return fcmToken;
  }

  static Future<Stream<QuerySnapshot<Map<String, dynamic>>>> userExists(
      String ploID) async {
    String? userID = await UserPreferences.getUserID();
    return fireStore.collection('plo/${ploID}/cus').where(
        'id', isEqualTo: userID).snapshots();
  }

  static Future<void> createUser() async {
    String? userID = await UserPreferences.getUserID();
    String? fullName = await UserPreferences.getFullName();
    final time = DateTime
        .now()
        .millisecondsSinceEpoch
        .toString();
    final user = ChatUser(
        id: userID!, name: fullName!, lastMessage: '', time: time);
    await fireStore.collection('plo/${userID}/cus').doc(user.id).set(
        user.toJson());
  }

  static Future<void> createUserForCus(String ploId) async {
    String? userID = await UserPreferences.getUserID();
    String? fullName = await UserPreferences.getFullName();
    final time = DateTime
        .now()
        .millisecondsSinceEpoch
        .toString();
    final user = ChatUser(
        id: userID!, name: fullName!, lastMessage: '', time: time);
    await fireStore.collection('plo/${ploId}/cus').doc(user.id).set(
        user.toJson());
  }

  static Future<void> deleteUserForCus(String ploId) async {
    String? userID = await UserPreferences.getUserID();
    final QuerySnapshot subcollectionSnapshot = await fireStore.collection('plo/$ploId/cus/$userID/messages').get();
    for (final doc in subcollectionSnapshot.docs) {
      await doc.reference.delete();
    }
    await fireStore.collection('plo/${ploId}/cus/').doc(userID!).delete();
  }

  static Future<void> deleteUser(String cusID) async {
    String? userID = await UserPreferences.getUserID();
    final QuerySnapshot subcollectionSnapshot = await fireStore.collection('plo/$userID/cus/$cusID/messages').get();
    for (final doc in subcollectionSnapshot.docs) {
      await doc.reference.delete();
    }
    await fireStore.collection('plo/$userID/cus/').doc(cusID!).delete();
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getAllUser(String ploID) {
    return fireStore
        .collection('plo/${ploID}/cus/')
        .where('id', isNotEqualTo: ploID)
        .snapshots();
  }


  static Future<Stream<QuerySnapshot<Map<String, dynamic>>>> getAllMessages(
      ChatUser user) async {
    String? thisUserID = await UserPreferences.getUserID();
    if (user.id.startsWith('P')) {
      return fireStore.collection('plo/${user.id}/cus/${thisUserID}/messages')
          .snapshots();
    } else {
      return fireStore.collection('plo/${thisUserID}/cus/${user.id}/messages')
          .snapshots();
    }
  }
  static Future<void> sendMessage(ChatUser user, String msg) async {
    final time = DateTime
        .now()
        .millisecondsSinceEpoch
        .toString();
    String? thisUserID = await UserPreferences.getUserID();
    final MessageCustom message = MessageCustom(
        toId: user.id,
        msg: msg,
        read: '',
        type: Type.text,
        fromId: thisUserID!,
        sent: time);
    if (user.id.startsWith('P')) {
      final ref =
      fireStore.collection('plo/${user.id}/cus/${thisUserID}/messages');
      await ref.doc(time).set(message.toJson());
    } else {
      final ref =
      fireStore.collection('plo/${thisUserID}/cus/${user.id}/messages');
      await ref.doc(time).set(message.toJson());
    }
  }

  static Future<void> updateMessageStatus(MessageCustom message) async {
    final time = DateTime
        .now()
        .millisecondsSinceEpoch
        .toString();
    if (message.fromId.startsWith('P')){
      fireStore.collection(
          'plo/${message.fromId}/cus/${message.toId}/messages').doc(
          message.sent).update({'read': time});
    } else {
      fireStore.collection(
          'plo/${message.toId}/cus/${message.fromId}/messages').doc(
          message.sent).update({'read': time});
    }
  }

  static Future<Stream<QuerySnapshot<Map<String, dynamic>>>> getLastMessage(
      ChatUser user) async {
    String? thisUserID = await UserPreferences.getUserID();
    if (user.id.startsWith('P')) {
      return fireStore.collection('plo/${user.id}/cus/${thisUserID}/messages')
          .limit(1).orderBy('sent', descending: true)
          .snapshots();
    }
    return fireStore.collection('plo/${thisUserID}/cus/${user.id}/messages')
        .limit(1).orderBy('sent', descending: true)
        .snapshots();
  }
}
Future initPushNotifications() async {
  await FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
    alert: true,
    badge: true,
    sound: true,
  );

  FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
  FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  FirebaseMessaging.onMessage.listen((message) {
    final notification = message.notification;
    if (notification == null) return;

    _localNotifications.show(
      notification.hashCode,
      notification.title,
      notification.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          _androidChanel.id,
          _androidChanel.name,
          channelDescription: _androidChanel.description,
          icon: '@drawable/ic_launcher', // Fixed typo
        ),
      ),
      payload: jsonEncode(message.data),
    );
  });
}

final _androidChanel = const AndroidNotificationChannel(
  "high_importance_channel",
  "high Importance Notifications",
  description: "This is a channel",
  importance: Importance.defaultImportance,
);

final _localNotifications = FlutterLocalNotificationsPlugin();

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('Title: ${message.notification?.title}');
  print('Body: ${message.notification?.body}');
  print('Payload: ${message.data}');
}

void handleMessage(RemoteMessage? message) {
  if (message == null) return;
}

Future initLocalNotifications() async {
  const android = AndroidInitializationSettings('@drawable/ic_launcher');
  const settings = InitializationSettings(android: android);

  await _localNotifications.initialize(
    settings,
    onDidReceiveNotificationResponse: (payload) {
      final message = RemoteMessage.fromMap(jsonDecode(payload as String));
      handleMessage(message);
    },
  );

  final platform = _localNotifications.resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>();
  await platform?.createNotificationChannel(_androidChanel);
}
