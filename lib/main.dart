import 'package:bluetooth_chat/pages/chat_screen.dart';
import 'package:bluetooth_chat/pages/set_username_screen.dart';
import 'package:bluetooth_chat/pages/square_screen.dart';
import 'package:bluetooth_chat/pages/welcome_screen.dart';
import 'package:bluetooth_chat/providers/bluetooth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => BluetoothProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
        return MaterialApp(
      title: 'P2P Bluetooth Chat',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => WelcomeScreen(),
        '/username': (context) => SetUsernameScreen(),
        '/square': (context) => SquareScreen(),
        '/chat': (context) => ChatScreen(),
      },
    );
  }
}
   
