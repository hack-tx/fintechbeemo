import 'package:flutter/material.dart';
import 'package:another_dashed_container/another_dashed_container.dart';

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
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: DashedContainer(
          dashColor: Colors.black,
          dashedLength: 10.0,
          blankLength: 2.0,
          strokeWidth: 2.0,
          child: Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.all(20), // Reduced margin
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            width: MediaQuery.of(context).size.width * 0.7, // Adjusted width
            height: MediaQuery.of(context).size.height * 0.4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Drag and drop your file here to start uploading',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18, // Increased font size
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40), // Increased spacing
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width *
                          0.1, // Adjust the width as needed
                      child: Divider(
                        color: Colors.black,
                        thickness: 2,
                      ),
                    ),
                    SizedBox(width: 10),
                    Text('OR',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16)),
                    SizedBox(width: 10),
                    Container(
                      width: MediaQuery.of(context).size.width *
                          0.1, // Adjust the width as needed
                      child: Divider(
                        color: Colors.black,
                        thickness: 2,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40), // Increased spacing
                ElevatedButton(
                  onPressed: () {
                    // Handle file picking logic here
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.white,
                    onPrimary: Colors.black,
                    side: const BorderSide(
                        color: Colors.black, width: 2), // Added border
                    padding: const EdgeInsets.symmetric(
                        horizontal: 50, vertical: 15),
                    textStyle: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  child: const Text('Browse Files'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
