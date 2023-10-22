// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, use_key_in_widget_constructors, sort_child_properties_last, unnecessary_string_interpolations

import 'dart:convert';

import 'package:fintechbeemo/features/linechart.dart';
import 'package:fintechbeemo/features/miniChat.dart';
import 'package:fintechbeemo/features/pieChart.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CategoryCard extends StatelessWidget {
  final String categoryName;
  final double total;
  final int count;
  final double average;

  CategoryCard({
    required this.categoryName,
    required this.total,
    required this.count,
    required this.average,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              categoryName,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Total: \$${total.toStringAsFixed(2)}'),
            Text('Count: $count'),
            Text('Average: \$${average.toStringAsFixed(2)}'),
          ],
        ),
      ),
    );
  }
}

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

  Map<String, dynamic> _trendAnalysis(transactions) {
    // Assume transactions are sorted by date
    final monthlySpending = <String, double>{};
    final monthlyIncome = <String, double>{};

    for (var transaction in transactions) {
      final date = DateTime.parse(transaction['Date']);
      final month = '${date.year}-${date.month.toString().padLeft(2, '0')}';
      final amount = transaction['Amount'];

      if (amount > 0) {
        monthlyIncome[month] = (monthlyIncome[month] ?? 0) + amount;
      } else {
        monthlySpending[month] = (monthlySpending[month] ?? 0) - amount;
      }
    }

    // Check if spending and income are increasing or decreasing
    final spendingTrend =
        monthlySpending.values.last > monthlySpending.values.first
            ? 'Increasing'
            : 'Decreasing';
    final incomeTrend = monthlyIncome.values.last > monthlyIncome.values.first
        ? 'Increasing'
        : 'Decreasing';

    return {
      'Spending Trend': spendingTrend,
      'Income Trend': incomeTrend,
    };
  }

  Map<String, double> analyzeTransactions(transactions) {
    double totalSpending = 0;
    double totalEarning = 0;
    DateTime startDate = DateTime.parse(transactions.first['Date']);
    DateTime endDate = DateTime.parse(transactions.last['Date']);

    for (var transaction in transactions) {
      double amount = transaction['Amount'];
      if (amount > 0) {
        totalEarning += amount;
      } else {
        totalSpending +=
            -amount; // Convert negative spending to positive for summation
      }
    }

    int numDays = endDate.difference(startDate).inDays + 1;
    int numWeeks = (numDays / 7).ceil();
    double weeklySpending = totalSpending / numWeeks;
    double earningSpendingRatio =
        totalEarning / (totalSpending == 0 ? 1 : totalSpending);

    return {
      'Weekly Spending': weeklySpending,
      'Earning to Spending Ratio': earningSpendingRatio,
    };
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
          var summaryData = mapData['Summary'];
          var transactionBalance = analyzeTransactions(transactions);
          var trendAnalysis = _trendAnalysis(transactions);

          List<Widget> categoryCards = summaryData.entries.map<Widget>((entry) {
            String categoryName = entry.key;
            Map<String, dynamic> categoryData = entry.value;
            return CategoryCard(
              categoryName: categoryName,
              total: categoryData['Total'],
              count: categoryData['Count'],
              average: categoryData['Average'],
            );
          }).toList();

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
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.all(5),
                              padding: EdgeInsets.all(10),
                              // width: _size.width * .3,
                              height: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.grey[100],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Spending Balance',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24),
                                  ),

                                  Divider(),
                                  Row(
                                    children: [
                                      Text(
                                        "Weekly Avg Spending: ",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "\$${transactionBalance['Weekly Spending']!.toStringAsFixed(2)}",
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Text(
                                        "Earning to Spending Ratio: ",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "${transactionBalance['Earning to Spending Ratio']!.toStringAsFixed(2)}",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),

                                  Row(
                                    children: [
                                      Text(
                                        "Spending Trend: ",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "${trendAnalysis['Spending Trend']!.toString()}",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Text(
                                        "Income Trend: ",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        "${trendAnalysis['Income Trend']!.toString()}",
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ],
                                  ),

                                  // LineChartBalance(
                                  //   transactions: transactions,
                                  // )
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.all(5),
                              // width: _size.width * .3,
                              height: MediaQuery.of(context).size.width * .38,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.grey),

                              child: MiniChat(),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 3,
                        child: Column(
                          children: [
                            Container(
                              margin: EdgeInsets.all(5),
                              padding: EdgeInsets.all(10),
                              // width: _size.width * .2,
                              height: 400,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.grey[100]),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Top Categories',
                                    style: TextStyle(
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  PieChartTransactions(
                                    summaryData: summaryData,
                                  ),
                                ],
                              ),
                            ),
                          ],
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
                              color: Colors.grey[100]),
                          child: ListView.builder(
                            itemCount: transactions.length,
                            itemBuilder: (context, index) {
                              final transaction = transactions[index];
                              return Card(
                                elevation: 0.0,
                                margin: EdgeInsets.all(5),
                                child: ListTile(
                                  tileColor: Colors.grey[100],
                                  title: Text(transaction['Description']),
                                  subtitle: Column(
                                    children: [
                                      Row(
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
                                                        transaction['Amount'] <
                                                                0
                                                            ? Colors.red
                                                            : Colors.green),
                                              ),
                                              Text(
                                                  '${transaction['Category']}'),
                                            ],
                                          ),
                                        ],
                                      ),
                                      Divider(
                                        thickness: 1,
                                      )
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
