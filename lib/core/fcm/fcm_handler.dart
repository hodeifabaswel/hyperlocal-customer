import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'deep_link_handler.dart';

class FcmHandler {
  final CustomerDeepLinkHandler _deepLinkHandler;
  FcmHandler(this._deepLinkHandler);

  void init() {
    // Background → user tap notifikasi → buka app
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      _handleFcmMessage(message);
    });

    // Terminated → user tap notifikasi → cold start
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) _handleFcmMessage(message);
    });

    // Foreground: sengaja TIDAK di-listen.
    // Real-time saat app terbuka di-handle via WebSocket (core/ws/).
  }

  void _handleFcmMessage(RemoteMessage message) {
    final deepLink = message.data['deep_link'] as String?;
    if (deepLink != null) {
      debugPrint('[FCM] deep_link: $deepLink');
      _deepLinkHandler.handleUri(Uri.parse(deepLink));
    }
  }
}
