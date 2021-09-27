import 'package:flutter/material.dart';

class DumyScreen extends StatefulWidget {
  const DumyScreen({Key? key}) : super(key: key);

  @override
  _DumyScreenState createState() => _DumyScreenState();
}

class _DumyScreenState extends State<DumyScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    color: Colors.blue,
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Container(
                    color: Colors.red,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              color: Colors.orange,
            ),
          ),

        ],
      ),
    );
  }
}
