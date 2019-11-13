import 'package:flutter/material.dart';
import 'dart:math';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _weight = 0;
  String _sentStatus = "";
  Random weightGenerator = Random();

  void _sendWeight() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _weight = weightGenerator.nextInt(50);
      _sentStatus = "Weight sent!";
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.

        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
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
              "Donator's name:",
              style: Theme.of(context).textTheme.display1,
            ),
            TextField(
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Enter donator's name"
              ),
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
              '$_sentStatus',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _sendWeight,
        tooltip: 'Send weight',
        child: Text("Send"),
      ), // This trailing comma makes auto-formatting nicer for build methods.
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