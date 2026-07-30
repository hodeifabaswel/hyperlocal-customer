import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // TODO(sprint-3): Firebase.initializeApp()
  // TODO(sprint-3): ClientInfoInterceptor.create(buildType: kBuildType)
  runApp(const ProviderScope(child: HyperlocalCustomerApp()));
}
