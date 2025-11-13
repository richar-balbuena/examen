import 'package:flutter/material.dart';
import 'package:examen/mensajeria/config/app_theme.dart';
import 'package:examen/mensajeria/presentacion/chat/chat_screen.dart';
import 'package:examen/mensajeria/presentacion/provider/chat_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers:[
      ChangeNotifierProvider(create:(_) => ChatProvider())
      ],
      
    child: MaterialApp(
        title: 'si o no App',
        debugShowCheckedModeBanner: false,
        theme: AppTheme(selectedColor: 0).theme(),
        home: const ChatScreen()
        ),
    );
  }
}
