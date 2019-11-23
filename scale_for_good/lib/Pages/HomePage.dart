import 'package:flutter/material.dart';
import 'package:scale_for_good/Pages/HistoryPage.dart';
import 'dart:math';
import './SettingsPage.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _weight = 0;
  DateTime _dateTime = new DateTime.now();
  String _sentStatus = "";
  Random weightGenerator = Random();
  String _donatorName;
  String _donationDesc;
  String _donatorEmail;
  var donation = new List(5);

  void _sendWeight() {
    setState(() {
      _weight = weightGenerator.nextInt(50);
      _dateTime = DateTime.now();
      _sentStatus = "Weight sent!";
      _donatorName = "";
      _donationDesc = "";
      _donatorEmail = "";
    });
  }

  void _zeroWeight() {
    setState(() {
      _weight = 0;
    });
  }

  getDonation() {
    donation[0] = _weight;
    donation[1] = _dateTime;
    donation[2] = _donatorName;
    donation[3] = _donationDesc;
    donation[4] = _donatorEmail;
    return donation;
  }
  String mainProfilePicture = "https://randomuser.me/api/portraits/women/44.jpg";
  String otherProfilePicture = "https://randomuser.me/api/portraits/women/47.jpg";

  void switchUser(){
    String backupString = mainProfilePicture;
    this.setState((){
      mainProfilePicture = otherProfilePicture;
      otherProfilePicture = backupString;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
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
                  Navigator.of(context).push(new MaterialPageRoute(builder: (context) => HomePage(title: 'Home Page')));
                }
            ),
            new ListTile(
                title: new Text("Settings"),
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              'Total Weight:',
              style: Theme.of(context).textTheme.display1,
            ),
            Text(
              '$_weight' + ' kg',
              style: Theme.of(context).textTheme.display3,
            ),
            Text(
              'Date: ' + '$_dateTime',
              //style: Theme.of(context).textTheme.display1
            ),
            TextField(
              decoration: InputDecoration(
                labelText: "Donator's name:",
              ),
              onChanged: (text){
                _donatorName = text;
              },
            ),
            TextField(
              decoration: InputDecoration(
                labelText: "Donation description:",
              ),
              onChanged: (text){
                _donationDesc = text;
              },
            ),
            TextField(
                decoration: InputDecoration(
                  labelText: "Donator's email:",
                ),
                onChanged: (text){
                  _donatorEmail = text;
                }
            ),
            Text(
              '$_sentStatus',
            ),
          ],
        ),
      ),
      persistentFooterButtons: <Widget>[
        FlatButton(
          color: Colors.lightBlue,
          textColor: Colors.white,
          onPressed: _sendWeight,
          child: Text("Send"),
        ),
        FlatButton(
          color: Colors.lightBlue,
          textColor: Colors.white,
          onPressed: _zeroWeight,
          child: Text("Zero"),
        )
      ],
    );
  }
}

class OtherPage extends StatelessWidget{

  final String pageText;

  OtherPage(this.pageText);

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: new AppBar(title: new Text(pageText)),
      body: new Center(
        child: new Text(pageText),
      ),
    );
  }
}

