// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'package:flutter/material.dart';

class AIChatBotPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Chat UI',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ChatUIScreen(),
    );
  }
}

class ChatUIScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Logo Name Here'),
        leading: CircleAvatar(
          backgroundColor: Colors.white,
          // You can add an image to the CircleAvatar if you have one.
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(20.0),
            padding: EdgeInsets.all(20.0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black),
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Text('AI Chat'),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.all(20.0),
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: ListView(
                children: [
                  // Add your chat messages here as Text widgets or custom widgets.
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(20.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Ask a few questions here...',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    // Handle the send button press here.
                  },
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
