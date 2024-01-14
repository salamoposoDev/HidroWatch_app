import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationApi {
  final _firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotification() async {
    await _firebaseMessaging.requestPermission();

    // final fcmToken = await _firebaseMessaging.getToken();

    // log('token = $fcmToken');
    // print('token = $fcmToken');
  }

  Future<void> notificationByTopic() async {
    await _firebaseMessaging.subscribeToTopic('user');
  }
}
