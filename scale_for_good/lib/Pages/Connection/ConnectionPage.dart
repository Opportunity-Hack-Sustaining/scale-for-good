import 'package:flutter/material.dart';

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
      title: 'Flutter layout demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Flutter layout demo'),
        ),
        body: ListView(
          padding: const EdgeInsets.only(top:30),
          children: [
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