import 'package:flutter/material.dart';
import 'package:scale_for_good/Pages/HistoryPage.dart';
import './HomePage.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final List<bool> isSelected = [false,true];
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

      padding: const EdgeInsets.only(left:32,top:32),
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


    //Begin main settings
    Widget MainSettingsTitle = Container(

      padding: const EdgeInsets.only(left:32),
      child: Text(
        'Main Settings',
        style: TextStyle(
          fontSize: 24,
        ),
      ),
    );

    Widget weightOption = ToggleButtons(
      children: <Widget>[
        Text("Lb"),
        Text("Kg")
      ],
      onPressed: (int index) {
        setState(() {
          for (int buttonIndex = 0; buttonIndex < isSelected.length; buttonIndex++) {
            if (buttonIndex == index) {
              isSelected[buttonIndex] = true;
            } else {
              isSelected[buttonIndex] = false;
            }
          }
        });
      },
      isSelected: isSelected,
    );


    Widget calcWeight = Container(
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
                    'Calculate Weight:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
          weightOption,
          Text('   '),
          /*3*/
        ],
      ),
    );

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

        body: ListView(
          padding: const EdgeInsets.only(top:30),
          children: [
            MainSettingsTitle,
            calcWeight,
            knownDevicesTitle,
            knownDevices,
            knownDevices,
            discoveredDevicesTitle,
            discovDevices,
            discovDevices
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