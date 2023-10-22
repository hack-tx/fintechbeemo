// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, use_key_in_widget_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class StatsPage extends StatefulWidget {
  const StatsPage({super.key});

  @override
  State<StatsPage> createState() => _StatsPageState();
}

class _StatsPageState extends State<StatsPage> {
  Future<String>? _dataFuture;

  @override
  void initState() {
    super.initState();
    _dataFuture = fetchCsvData(); // Fetch data on init
  }

  Future<String> fetchCsvData() async {
    final response = await http.get(
      Uri.parse('http://45.55.39.250/get-csv'),
      headers: {'accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      // If the server returns an OK response, parse the JSON
      final data = response.body;
      print('Data fetched successfully: $data');
      return data;
    } else {
      // If the server did not return a 200 OK response,
      // throw an exception.
      throw Exception('Failed to load data');
    }
  }

  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;

    return FutureBuilder<String>(
      future: _dataFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // If the Future is still running, show a loading indicator
          return CircularProgressIndicator();
        } else if (snapshot.hasError) {
          // If we run into an error, display it to the user
          return Text('Error: ${snapshot.error}');
        } else {
          // print(snapshot.data);
          Map<String, dynamic> mapData = jsonDecode(snapshot.data!);

          var transactions = mapData['Transactions'];

          // snapshot.data;
          // If the Future is complete and no errors occurred,
          // display the created posts
          return Expanded(
            flex: 8,
            child: Container(
              padding: EdgeInsets.all(20),
              color: Colors.grey[200],
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 4,
                        child: Container(
                          margin: EdgeInsets.all(5),
                          // width: _size.width * .3,
                          height: 200,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.grey),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          margin: EdgeInsets.all(5),
                          // width: _size.width * .2,
                          height: 200,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.grey),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Container(
                          margin: EdgeInsets.all(5),
                          width: _size.width * .3,
                          height: 850,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.grey[300]),
                          child: ListView.builder(
                            itemCount: transactions.length,
                            itemBuilder: (context, index) {
                              final transaction = transactions[index];
                              return Card(
                                margin: EdgeInsets.all(5),
                                child: ListTile(
                                  title: Text(transaction['Description']),
                                  subtitle: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Text('${transaction['Date']}'),
                                        ],
                                      ),
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Text(
                                              '\$${transaction['Amount']}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 25,
                                                  color:
                                                      transaction['Amount'] < 0
                                                          ? Colors.red
                                                          : Colors.green),
                                            ),
                                            Text('${transaction['Category']}'),
                                          ]),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}
