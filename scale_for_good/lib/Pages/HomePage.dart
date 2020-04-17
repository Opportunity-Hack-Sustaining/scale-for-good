import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:scale_for_good/Dataflow/Donation.dart';
import 'package:scale_for_good/Dataflow/LocalStorage.dart';
import 'package:flutter_ble_lib/flutter_ble_lib.dart';
import 'package:scale_for_good/Pages/HistoryPage.dart';
import 'package:scale_for_good/Pages/SignInPage.dart';
import 'package:scale_for_good/model/ble_device.dart';
import 'package:scale_for_good/sensor_tag_config.dart';
import 'dart:math';
import '../sensor_tag_config.dart';
import '../sensor_tag_config.dart';
import './SettingsPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'ConnectionsPage.dart';

class HomePage extends StatefulWidget {
  final LocalStorage storage;
  final String title;

  HomePage({Key key, this.title, @required this.storage}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<bool> isSelected = [false,true];

  /**************************************
   * Need peripheral on this page
   **************************************/
  int _kgWeight = 0;
  String globalService = SensorTagTemperatureUuids.weightService;
  String globalCharacteristic = SensorTagTemperatureUuids.weightCharacteristic;
  Peripheral peripheral;
  double _weight = 0;
  double _calculatedWeight = 0;
  String _weightType = 'kg';
  bool lbs = true;
  bool kg = false;
  DateTime _dateTime = new DateTime.now();
  String _sentStatus = "";
  Random weightGenerator = Random();
  String _donatorName;
  String _donationDesc;
  String _donatorEmail;

  @override
  void initState() {
    super.initState();
    widget.storage.init();
  }

  void _sendWeight() {

    widget.storage.writeDonation(new Donation(
        date: _dateTime,
        weight: _weight,
        donatedBy: _donatorName,
        description: _donationDesc,
        email: _donatorEmail
    ));

    setState(() {
      _weight = weightGenerator.nextDouble();
      _calculatedWeight = _weight;
      _isKilos(isSelected[1]);
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
      _calculatedWeight = 0;
    });
  }

  void _isKilos(bool kilo) {
    if (kilo == false) {
      setState(() {
        _weightType = 'lbs';
        _calculatedWeight = (_weight * 2.20462);
      });
    }
    else {
      setState(() {
        _weightType = 'kg';
        _calculatedWeight = _weight;
      });
    }
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
                title: new Text("Sign In"),
                trailing: new Icon(Icons.home),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(new MaterialPageRoute(builder: (context) => SignInPage(title: 'Sign In')));
                }
            ),
            new Divider(),

            new ListTile(
                title: new Text("Home Page"),
                enabled: false,
                trailing: new Icon(Icons.home),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(new MaterialPageRoute(builder: (context) => HomePage(title: "Home Page", storage: widget.storage)));
                }
            ),
            new ListTile(
                title: new Text("Connections Page"),
                trailing: new Icon(Icons.settings),
                onTap: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).push(
                      new MaterialPageRoute(
                          builder: (BuildContext context) => ConnectionsPage()));
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
                (_calculatedWeight).toStringAsFixed(2) + '$_weightType',
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
                setState(() {
                  _donatorName = text;
                });
              },
            ),
            TextField(
              decoration: InputDecoration(
                labelText: "Donation description:",
              ),
              onChanged: (text){
                setState(() {
                  _donationDesc = text;
                });
              },
            ),
            TextField(
                decoration: InputDecoration(
                  labelText: "Donator's email:",
                ),
                onChanged: (text){
                  setState(() {
                    _donatorEmail = text;
                  });
                }
            ),
            Text(
              '$_sentStatus',
            ),
            Container(
              padding: const EdgeInsets.only(top: 180),
            ),


        ToggleButtons(
          children: <Widget>[
            Text("Lb"),
            Text("Kg")
          ],
          onPressed: (int index) {

            setState(() {
              for (int buttonIndex = 0; buttonIndex < isSelected.length; buttonIndex++) {
                if (buttonIndex == index) {
                  isSelected[buttonIndex] = true;
                  _isKilos(true);
                } else {
                  isSelected[buttonIndex] = false;
                  _isKilos(false);
                }
              }
            });
          },
          isSelected: isSelected,
        ),

          ],
        ),
      ),
      persistentFooterButtons: <Widget>[
        FlatButton(
          color: Colors.lightBlue,
          textColor: Colors.white,
          onPressed: getConvertedWeight,
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

  Future<void> getConvertedWeight() async {

      peripheral = SensorTagTemperatureUuids.peripheral;
        print("Connecting to ${peripheral.name}");
        await peripheral.connect();
        //SensorTagTemperatureUuids.peripheral = peripheral;
        print("Connected!");

    await peripheral.discoverAllServicesAndCharacteristics();
    Service savedService;
    Characteristic savedCharacteristic;
    List<Service> services = await peripheral.services();
    print("PRINTING SERVICES for \n${peripheral.name}");
    services.forEach((service) =>
    (service.uuid.contains(SensorTagTemperatureUuids.weightService))?
    savedService = service: print("Found WRONG service \n${service.uuid}"));

    print("PRINTING CHARACTERISTICS FOR SERVICE \n${savedService.uuid}");


    //Use this if the characteristic value is known
    List<Characteristic> characteristics = await savedService.characteristics();
    characteristics.forEach((characteristic) =>
    (characteristic.uuid.contains(SensorTagTemperatureUuids.weightCharacteristic))?
    savedCharacteristic = characteristic: print("Found WRONG characteristic \n${characteristic.uuid}"));

    print("HELLO THIS IS THE CHARACTERISTIC I WANT \n${savedCharacteristic.uuid}");
    Uint8List readValue1 = (await savedCharacteristic.read());
    print("AND THIS IS SUPPOSED TO BE THE VALUE \n$readValue1");

    //Use this if the characteristic value is unknown
    /*log("PRINTING CHARACTERISTICS FROM \nPERIPHERAL for the same service");
    List<Characteristic> characteristicFromPeripheral =
    await peripheral.characteristics(savedService.uuid);*/

    //Switch savedCharacteristic to characteristicFromPeripheral[0]
    Uint8List readValue = (await savedCharacteristic.read());
    int d = readValue[0];
    int c = readValue[1];
    int b = readValue[2];
    int a = readValue[3];
    print("TESTING WEIGHT CONVERSION");
    print("D: $d");
    print("C: $c");
    print("B: $b");
    print("A: $a");
    int total = a + (b*256) + (c*65536) + d;
    print("TOTAL CONVERTED VALUE: $total");
    print("Weight: \n$readValue");

    //turn on when characteristic value is unknown
    /*characteristicFromPeripheral.forEach((characteristic) =>
        log("Found characteristic \n ${characteristic.uuid}")
    );*/

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

