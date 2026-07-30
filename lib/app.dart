import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HyperlocalCustomerApp extends StatelessWidget {
  const HyperlocalCustomerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Hyperlocal',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorSchemeSeed: const Color(0xFF2E7D32),
        useMaterial3: true,
        textTheme: const TextTheme(bodyMedium: TextStyle(fontSize: 16)),
      ),
      routerConfig: _router,
    );
  }
}

final _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder:
          (context, state) => const Scaffold(
            body: Center(child: Text('Customer App — Sprint 2 scaffold')),
          ),
    ),
  ],
);
