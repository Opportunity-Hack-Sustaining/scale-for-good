import 'package:flutter/material.dart';
import './SettingsPage.dart';
import './HomePage.dart';

class HistoryPage extends StatefulWidget {
  HistoryPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        title: 'Settings',
        home: Scaffold(
        appBar: AppBar(
        title: Text('Settings'),
    ),

    drawer: new Drawer(
    child: new ListView(
    children: <Widget>[

    new ListTile(
    title: new Text("Home Page"),
    trailing: new Icon(Icons.home),
    onTap: () {
    Navigator.of(context).pop();
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) => HomePage(title: 'Home Page')));
    }
    ),
    new ListTile(
    title: new Text("Settings Page"),
    trailing: new Icon(Icons.settings),
    onTap: () {
    Navigator.of(context).pop();
    Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => SettingsPage(title: "Settings")));
    }
    ),
    new ListTile(
    title: new Text("History"),
    trailing: new Icon(Icons.history),
    onTap: () {
    Navigator.of(context).pop();
    Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => HistoryPage(title: "History")));
    }
    ),
    new Divider(),
    new ListTile(
    title: new Text("Close"),
    trailing: new Icon(Icons.cancel),
    onTap: () => Navigator.of(context).pop(),
    )

    ],
    ),
    ),
  body: Container(
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
    )
    ],
    ),
    ],
    ),
    )
    )
    );
  }
}