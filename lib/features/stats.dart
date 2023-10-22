// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, use_key_in_widget_constructors

import 'package:flutter/material.dart';

class StatsPage extends StatelessWidget {
  const StatsPage({super.key});

  @override
  Widget build(BuildContext context) {
    var _size = MediaQuery.of(context).size;

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
                  flex: 2,
                  child: Container(
                    margin: EdgeInsets.all(10),
                    // width: _size.width * .3,
                    height: 200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: EdgeInsets.all(10),
                    // width: _size.width * .2,
                    height: 200,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Container(
                    margin: EdgeInsets.all(10),
                    width: _size.width * .3,
                    height: 700,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
