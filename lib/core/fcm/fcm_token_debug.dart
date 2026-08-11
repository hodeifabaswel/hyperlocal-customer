// lib/core/fcm/fcm_token_debug.dart
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Menampilkan FCM token di UI (hanya debug build) agar mudah di-copy
/// tanpa perlu colok kabel / buka logcat / buka Firebase Console.
///
/// Di production (release build), fungsi ini tidak melakukan apa-apa
/// karena dibungkus [kDebugMode].
class FcmTokenDebug {
  /// Ambil token dan tampilkan di dialog dengan tombol copy.
  static Future<void> showTokenDialog(BuildContext context) async {
    // Guard: hanya debug build. Di release, langsung return.
    if (!kDebugMode) return;

    String tokenText;
    try {
      final token = await FirebaseMessaging.instance.getToken();
      tokenText = token ?? '(token null)';
    } catch (e) {
      tokenText = 'Gagal ambil token: $e';
    }

    if (!context.mounted) return;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('FCM Token (debug)'),
        content: SingleChildScrollView(
          child: SelectableText(
            tokenText,
            style: const TextStyle(fontSize: 12, fontFamily: 'monospace'),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () async {
              await Clipboard.setData(ClipboardData(text: tokenText));
              if (ctx.mounted) {
                ScaffoldMessenger.of(ctx).showSnackBar(
                  const SnackBar(content: Text('Token di-copy')),
                );
              }
            },
            child: const Text('Copy'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }
}
