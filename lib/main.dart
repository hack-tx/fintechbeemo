import 'package:fintechbeemo/features/ai_chatbot.dart';
import 'package:fintechbeemo/features/user_flow.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'File Upload UI',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: (AIChatBotPage()), // Use the AiChatbotPage as the home page
    );
  }
}
