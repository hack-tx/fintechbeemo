import 'package:flutter/material.dart';

class AIChatBotPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              margin: EdgeInsets.only(right: 10.0),
              child: Column(
                children: [
                  SizedBox(height: 50.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 50.0,
                        height: 50.0,
                        decoration: BoxDecoration(
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
                      SizedBox(width: 10.0),
                      Text(
                        'Money Buddy',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 5.0, vertical: 0.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Color.fromRGBO(0, 191, 100, 1),
                    ),
                    child: Container(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Icon(Icons.chat_bubble, color: Colors.white),
                          ),
                          SizedBox(width: 20.0),
                          Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Text(
                              'AI Chatbot',
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
            ),
          ),
          Expanded(
            flex: 8,
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    color: Colors
                        .white, // Change to your preferred color or design
                    child: ListView(
                      children: [
                        // Add your chat messages here
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(10.0),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Type your message here...',
                    ),
                    // Add your text field submission logic here
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
