// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, library_private_types_in_public_api, prefer_const_declarations

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:http/http.dart' as http;

class AIChatBotPage extends StatefulWidget {
  @override
  _AIChatBotPageState createState() => _AIChatBotPageState();
}

class _AIChatBotPageState extends State<AIChatBotPage> {
  final List<BubbleSpecialThree> _messages = [];
  final TextEditingController _controller = TextEditingController();

  Future<void> postQuestion() async {
    final url = 'http://45.55.39.250/statement-question';
    final headers = {
      'Content-Type': 'application/json',
      'accept': 'application/json',
    };
    final body = jsonEncode({'question': _controller.text});

    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      // If the server returns an OK response, parse the JSON
      print('Response data: ${response.body}');

      setState(() {
        _messages.add(
          BubbleSpecialThree(
            text: response.body,
            color: const Color.fromRGBO(1, 150, 255, 1),
            tail: true,
            isSender: false,
            textStyle: TextStyle(
                color: Colors.white,
                fontSize: 20), // Increase the fontSize here
          ),
        );
      });
    } else {
      // If the server did not return a 200 OK response,
      // throw an exception.
      throw Exception('Failed to post question');
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenSize = MediaQuery.of(context).size;

    return Scaffold(
      body: Row(
        children: [
          if (screenSize.width > 600) ...[
            Expanded(
              flex: 2,
              child: _buildSideMenu(),
            ),
          ],
          Expanded(
            flex: 8,
            child: _buildChatArea(),
          ),
        ],
      ),
    );
  }

  Widget _buildSideMenu() {
    return Container(
      margin: const EdgeInsets.only(right: 10.0),
      child: Column(
        children: [
          const SizedBox(height: 50.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 50.0,
                height: 50.0,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                ),
                child: Center(
                  child: Image.asset(
                    'assets/images/money.png',
                    width: 70.0,
                    height: 70.0,
                  ),
                ),
              ),
              const SizedBox(width: 10.0),
              const Text(
                'Money Buddy',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20.0),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 0.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.0),
              color: const Color.fromRGBO(0, 191, 100, 1),
            ),
            child: Container(
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.all(14.0),
                    child: Icon(Icons.chat_bubble, color: Colors.white),
                  ),
                  SizedBox(width: 20.0),
                  Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text(
                      'AI Chat',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatArea() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
            child: ListView.builder(
          shrinkWrap: true,
          itemCount: _messages.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: _messages[index].isSender
                    ? MainAxisAlignment.end
                    : MainAxisAlignment.start,
                children: [
                  Flexible(child: _messages[index]),
                ],
              ),
            );
          },
        )),
        Container(
          padding: EdgeInsets.all(10.0),
          child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Type your message here...',
            ),
            onSubmitted: (value) {
              postQuestion();
              setState(() {
                _messages.add(
                  BubbleSpecialThree(
                    text: value,
                    color: const Color.fromRGBO(0, 191, 100, 1),
                    tail: true,
                    isSender: true,
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 20), // Increase the fontSize here
                  ),
                );
              });
              _controller.clear();
            },
          ),
        ),
      ],
    );
  }
}
