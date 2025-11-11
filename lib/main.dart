import 'package:alla/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // Initializes plugins before runApp()
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge); // Enables edge-to-edge mode

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false, // Debug banner false
      routerConfig: router,
    );
  }
}


