import 'package:flutter/material.dart';

class HistoryPage extends StatefulWidget {
  HistoryPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {

  void _convertToCSV() {
    //TODO: Add conversion functionality
  }

  @override
  Widget build(BuildContext context) {

    return Container(
        color: Colors.white,
        padding: EdgeInsets.all(10.0),

        child: Column(
          children: <Widget>[
            Table(
              border: TableBorder.all(color: Colors.grey),
              children: [
                TableRow(children: [
                  Text(
                    'Weight:',
                    style: TextStyle(color: Colors.black, fontSize: 10),
                  ),
                  Text(
                    'Time:',
                    style: TextStyle(color: Colors.black, fontSize: 10),
                  ),
                  Text(
                    'Donator:',
                    style: TextStyle(color: Colors.black, fontSize: 10),
                  ),
                  Text(
                    'Description:',
                    style: TextStyle(color: Colors.black, fontSize: 10),
                  ),
                ]),
                TableRow(children: [
                  Text(
                    '24 kg',
                    style: TextStyle(color: Colors.black, fontSize: 10),
                  ),
                  Text(
                    DateTime.now().toString(),
                    style: TextStyle(color: Colors.black, fontSize: 10),
                  ),
                  Text(
                    'Mr. Example',
                    style: TextStyle(color: Colors.black, fontSize: 10),
                  ),
                  Text(
                    'Candy corn',
                    style: TextStyle(color: Colors.black, fontSize: 10),
                  ),
                ]),
              ],
            ),
            ButtonBar(
              alignment: MainAxisAlignment.end,
              children: <Widget>[
                FlatButton(
                  color: Colors.lightBlue,
                  textColor: Colors.white,
                  child: Text("Clear"),
                ),
                FlatButton(
                  color: Colors.lightBlue,
                  textColor: Colors.white,
                  onPressed: _convertToCSV,
                  child: Text("Export to CSV"),
                ),
              ],
            ),
          ],
        ),
    );
  }
}