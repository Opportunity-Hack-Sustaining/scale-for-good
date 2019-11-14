import 'package:flutter/material.dart';
import 'dart:math';

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

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            RaisedButton(
              child: Text('Settings'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => _SettingsPageState()),
                );
              },
            ),
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

class _SettingsPageState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    Widget knownDevices = Container(
      padding: const EdgeInsets.only(left:32, right:32, top:12, bottom:12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            /*1*/
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*2*/
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    'Scale name',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
          _buildButtonColumn(Colors.grey, Icons.edit, 'Edit'),
          Text('   '),
          _buildButtonColumn(Colors.red, Icons.cancel, 'Forget'),
          Text('   '),
          _buildButtonColumn(Colors.blue, Icons.bluetooth_connected, 'Connect'),
          /*3*/
        ],
      ),
    );

    Widget discovDevices = Container(
      padding: const EdgeInsets.only(left:32, right:32, top:12, bottom:12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            /*1*/
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /*2*/
                Container(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    'Scale name',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
          _buildButtonColumn(Colors.blue, Icons.add, 'Add'),
          Text('   '),
          /*3*/
        ],
      ),
    );

    Widget knownDevicesTitle = Container(
      padding: const EdgeInsets.only(left:32),
      child: Text(
        'Known Devices',
        style: TextStyle(
          fontSize: 24,
        ),
      ),
    );
    Widget discoveredDevicesTitle = Container(
      padding: const EdgeInsets.only(left:32,top:32),
      child: Text(
        'Discovered Devices',
        style: TextStyle(
          fontSize: 24,
        ),
      ),
    );

    return MaterialApp(
      title: 'Settings',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Settings'),
        ),
        body: ListView(
          padding: const EdgeInsets.only(top:30),
          children: [
            RaisedButton(
              child: Text('Home Page'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage(title: 'Scale for Good')),
                );
              },
            ),
            knownDevicesTitle,
            knownDevices,
            knownDevices,
            discoveredDevicesTitle,
            discovDevices,
            discovDevices,
          ],
        ),
      ),
    );
  }

  Column _buildButtonColumn(Color color, IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: color),
        Container(
          margin: const EdgeInsets.only(top: 8),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              color: color,
            ),
          ),
        ),
      ],
    );
  }
}