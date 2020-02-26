import 'package:flutter/material.dart';
import 'package:scale_for_good/Dataflow/LocalStorage.dart';
import './SettingsPage.dart';
import './HomePage.dart';

class HistoryPage extends StatefulWidget {
  final LocalStorage storage;
  final String title;

  HistoryPage({Key key, this.title, @required this.storage}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        drawer: new Drawer(
          child: new ListView(
            children: <Widget>[
              new ListTile(
                title: new Text("Home Page"),
                trailing: new Icon(Icons.home),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(new MaterialPageRoute(builder:
                      (context) => HomePage(title: "Home Page")));
                }
              ),
              new ListTile(
                title: new Text("Settings Page"),
                trailing: new Icon(Icons.settings),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(new MaterialPageRoute(builder:
                      (context) => SettingsPage(title: "Settings Page")));
                }
              ),
              new ListTile(
                title: new Text("History Page"),
                trailing: new Icon(Icons.history),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(new MaterialPageRoute(builder:
                      (context) => HistoryPage(title: "History Page")));
                }
              ),
              new Divider(),
              new ListTile(
                title: new Text("Close"),
                trailing: new Icon(Icons.cancel),
                onTap: () => Navigator.of(context).pop()
              )
            ]
          )
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
                    )
                  ])
                ]
              ),
              ButtonBar(
                alignment: MainAxisAlignment.end,
                children: <Widget>[
                  FlatButton(
                    color: Colors.lightBlue,
                    textColor: Colors.white,
                    child: Text("Clear")
                  )
                ]
              )
            ]
          )
        )
      )
    );
  }

}