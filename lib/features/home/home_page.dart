import 'package:flutter/material.dart';

import '../../core/fcm/fcm_token_debug.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Hyperlocal Customer')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Home'),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => FcmTokenDebug.showTokenDialog(context),
              child: const Text('Lihat FCM Token'),
            ),
          ],
        ),
      ),
    );
  }
}
