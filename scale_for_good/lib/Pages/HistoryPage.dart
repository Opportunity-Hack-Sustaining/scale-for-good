import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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

  DateFormat dateFormat = new DateFormat.yMMMd("en_US");

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
                      (context) => HomePage(title: "Home Page", storage: widget.storage)));
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
                      (context) => HistoryPage(title: "History Page", storage: widget.storage)));
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
              DataTable(
                columns: [
                  DataColumn(label: Text("Weight")),
                  DataColumn(label: Text("Date")),
                  DataColumn(label: Text("Donator")),
                  DataColumn(label: Text("Description"))
                ],
                rows: widget.storage.getDonationsList().map(
                    (dono) => DataRow(
                      cells: <DataCell>[
                        DataCell(Container(
                          width: 50,
                          child: Text(dono.weight.toString())
                        )),
                        DataCell(Container(
                          width: 50,
                          child: Text(dateFormat.format(dono.date))
                        )),
                        DataCell(Text(dono.donatedBy)),
                        DataCell(Text(dono.description))
                      ]
                    )
                ).toList()
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