import 'package:firebase_messaging/firebase_messaging.dart';

class MessagingController {

  static final MessagingController _messagingController = new MessagingController._internal();
  FirebaseMessaging _messaging;

  factory MessagingController(){
    return _messagingController;
  }

  MessagingController._internal(){
    _messaging = FirebaseMessaging();
    _configure();
  }

  void _configure(){
    _messaging.requestNotificationPermissions();

    _messaging.configure(
        onMessage: (Map<String, dynamic> message) {
        print("onMessage: $message");
        print(message);
      },
      onLaunch: (Map<String, dynamic> message) {
        print("onLaunch: $message");
        print(message);
      },
      onResume: (Map<String, dynamic> message) {
        print("onResume: $message");
        print(message);
      }
    ); // NECESSARY
  }

  Future<String> getToken(){
    return _messaging.getToken();
  }

}