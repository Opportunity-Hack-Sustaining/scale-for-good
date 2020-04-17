import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:scale_for_good/Pages/History/HistoryPage.dart';
import 'package:scale_for_good/Pages/Home/HomePage.dart';
import 'package:scale_for_good/Pages/Navigation/HamburgerMenu.dart';
import 'package:scale_for_good/devices_list/devices_bloc_provider.dart';
import 'package:scale_for_good/devices_list/devices_list_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ConnectionsPage.dart';
import 'SignInPage.dart';

class SettingsPage extends StatefulWidget {

  final String title;

  SettingsPage({Key key, this.title}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();

}

class _SettingsPageState extends State<SettingsPage> {

  //toggle for weight calc. First is lbs and second is kilos
  List<bool> weightList = [false,true];

  @override
  Widget build(BuildContext context) {

    Future<bool> temp = WeightPreferencesHelper.checkForBool();
    if(temp == true) {
      if(WeightPreferencesHelper.getKiloSF() as bool) {

      }
      else {
        weightList[0] = true;
        weightList[1] = false;
      }
    }

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
                    )
                  )
                )
              ]
            )
          ),
          _buildButtonColumn(Colors.grey, Icons.edit, 'Edit'),
          Text('   '),
          _buildButtonColumn(Colors.red, Icons.cancel, 'Forget'),
          Text('   '),
          _buildButtonColumn(Colors.blue, Icons.bluetooth_connected, 'Connect')
          /*3*/
        ]
      )
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
                    )
                  )
                )
              ]
            )
          ),
          _buildButtonColumn(Colors.blue, Icons.add, 'Add'),
          Text('   ')
          /*3*/
        ]
      )
    );

    Widget knownDevicesTitle = Container(
      padding: const EdgeInsets.only(left:32,top:32),
      child: Text(
        'Known Devices',
        style: TextStyle(
          fontSize: 24
        )
      )
    );

    Widget discoveredDevicesTitle = Container(
      padding: const EdgeInsets.only(left:32,top:32),
      child: Text(
        'Discovered Devices',
        style: TextStyle(
          fontSize: 24
        )
      )
    );


    //Begin main settings
    Widget mainSettingsTitle = Container(
      padding: const EdgeInsets.only(left:32),
      child: Text(
        'Main Settings',
        style: TextStyle(
          fontSize: 24
        )
      )
    );

    Widget weightOption = ToggleButtons(
      children: <Widget>[
        Text("Lb"),
        Text("Kg")
      ],
      onPressed: (int index) async {
        setState(() {
          for (int buttonIndex = 0; buttonIndex < weightList.length; buttonIndex++) {
            if (buttonIndex == index) {
              weightList[buttonIndex] = true;
            } else {
              weightList[buttonIndex] = false;
            }
          }

        });
        await WeightPreferencesHelper.setKiloToSF(weightList[1]);
      },
      isSelected: weightList,

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
      title: widget.title,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Settings'),
          actions: <Widget>[
            FutureBuilder<bool>(
              // get the languageCode, saved in the preferences
                future: WeightPreferencesHelper.getKiloSF(),
                initialData: true,
                builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
                  return snapshot.hasData
                      ? weightList[1] = snapshot.data
                      : Container();
                }),
          ],
        ),

        drawer: HamburgerMenu(),

        body: ListView(

          padding: const EdgeInsets.only(top:30),
          children: [
            mainSettingsTitle,
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

class WeightPreferencesHelper {

  static final String _kLanguageCode = "kilos";

  //This could be repurposed to save many things
  static Future<bool> setKiloToSF(bool sett) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool(_kLanguageCode, sett);
  }

  static Future<bool> getKiloSF() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    //Return bool
    return prefs.getBool(_kLanguageCode) ?? true;

  }

  static Future<bool> checkForBool() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool checkValue = prefs.containsKey('kilos');
    return checkValue;
  }

}