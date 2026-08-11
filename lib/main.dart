// lib/main.dart
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app.dart';
import 'core/fcm/deep_link_handler.dart';
import 'core/fcm/fcm_handler.dart';
import 'core/router/app_router.dart';
// Jika pakai FlutterFire CLI (Opsi A):
import 'firebase_options.dart';

// Top-level handler untuk notifikasi saat app terminated
@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  debugPrint('[FCM] Background message: ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 1. Inisialisasi Firebase
  try {
    // Opsi A (FlutterFire CLI):
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    // Opsi B (manual) — ganti baris di atas dengan:
    // await Firebase.initializeApp();
  } catch (e) {
    debugPrint('[main] Firebase init error: $e');
  }

  // 2. Register background handler
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // 3. Minta permission notifikasi (Android 13+ butuh POST_NOTIFICATIONS)
  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  // 4. Deep link handler (aman, tidak butuh Firebase)
  final deepLinkHandler = CustomerDeepLinkHandler(router: appRouter);
  deepLinkHandler.init();

  // 5. FCM handler — sekarang aman karena Firebase sudah di-init
  final fcmHandler = FcmHandler(deepLinkHandler);
  fcmHandler.init();

  runApp(const ProviderScope(child: HyperlocalCustomerApp()));
}
