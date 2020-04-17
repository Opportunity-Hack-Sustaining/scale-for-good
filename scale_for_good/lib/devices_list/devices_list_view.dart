import 'dart:async';

import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:scale_for_good/Pages/Settings/ConnectionsPage.dart';
import 'package:scale_for_good/Pages/History/HistoryPage.dart';
import 'package:scale_for_good/Pages/Home/HomePage.dart';

import 'package:scale_for_good/model/ble_device.dart';

import 'devices_bloc.dart';
import 'devices_bloc_provider.dart';
import 'hex_painter.dart';

typedef DeviceTapListener = void Function();

class DevicesListScreen extends StatefulWidget {
  @override
  State<DevicesListScreen> createState() => DeviceListScreenState();
}

class DeviceListScreenState extends State<DevicesListScreen> {
  DevicesBloc _devicesBloc;
  StreamSubscription _appStateSubscription;

  @override
  void didUpdateWidget(DevicesListScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    Fimber.d("didUpdateWidget");
  }

  void _onPause() {
    Fimber.d("onPause");
    _appStateSubscription.cancel();
    _devicesBloc.dispose();
  }

  void _onResume() {
    Fimber.d("onResume");
    _devicesBloc.init();
    _appStateSubscription = _devicesBloc.pickedDevice.listen((bleDevice) async {
      Fimber.d("navigate to details");
      _onPause();
      await Navigator.pushNamed(context, "/details");
      _shouldRunOnResume = true;
      Fimber.d("back from details");
    });
  }

  bool _shouldRunOnResume = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Fimber.d("DeviceListScreenState didChangeDependencies");
    if (_devicesBloc == null) {
      _devicesBloc = DevicesBlocProvider.of(context);
      if (_shouldRunOnResume) {
        _shouldRunOnResume = false;
        _onResume();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Fimber.d("build DeviceListScreenState");
    if (_shouldRunOnResume) {
      _shouldRunOnResume = false;
      _onResume();
    }
    return Scaffold(
      appBar: AppBar(
        title: Text('Bluetooth devices'),
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
                title: new Text("Connections Page"),
                enabled: false,
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
      body: StreamBuilder<List<BleDevice>>(
        initialData: _devicesBloc.visibleDevices.value,
        stream: _devicesBloc.visibleDevices,
        builder: (context, snapshot) => RefreshIndicator(
          onRefresh: _devicesBloc.refresh,
          child: DevicesList(_devicesBloc, snapshot.data),
        ),
      ),
    );
  }

  @override
  void dispose() {
    Fimber.d("Dispose DeviceListScreenState");
    _onPause();
    super.dispose();
  }

  @override
  void deactivate() {
    print("deactivate");
    super.deactivate();
  }

  @override
  void reassemble() {
    Fimber.d("reassemble");
    super.reassemble();
  }
}

class DevicesList extends ListView {
  DevicesList(DevicesBloc devicesBloc, List<BleDevice> devices)
      : super.separated(
            separatorBuilder: (context, index) => Divider(
                  color: Colors.grey[300],
                  height: 0,
                  indent: 0,
                ),
            itemCount: devices.length,
            itemBuilder: (context, i) {
              Fimber.d("Build row for $i");
              return _buildRow(context, devices[i],
                  _createTapListener(devicesBloc, devices[i]));
            });

  static DeviceTapListener _createTapListener(
      DevicesBloc devicesBloc, BleDevice bleDevice) {
    return () {
      Fimber.d("clicked device: ${bleDevice.name}");
      devicesBloc.devicePicker.add(bleDevice);
    };
  }

  static Widget _buildAvatar(BuildContext context, BleDevice device) {
    switch (device.category) {
      case DeviceCategory.sensorTag:
        return CircleAvatar(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset('assets/ti_logo.png'),
            ),
            backgroundColor: Theme.of(context).accentColor);
      case DeviceCategory.hex:
        return CircleAvatar(
            child: CustomPaint(painter: HexPainter(), size: Size(20, 24)),
            backgroundColor: Colors.black);
      case DeviceCategory.other:
      default:
        return CircleAvatar(
            child: Icon(Icons.bluetooth),
            backgroundColor: Theme.of(context).primaryColor,
            foregroundColor: Colors.white);
    }
  }

  static Widget _buildRow(BuildContext context, BleDevice device,
      DeviceTapListener deviceTapListener) {
    return ListTile(
      leading: Padding(
        padding: const EdgeInsets.only(top: 8),
        child: _buildAvatar(context, device),
      ),
      title: Text(device.name),
      trailing: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: Icon(Icons.chevron_right, color: Colors.grey),
      ),
      subtitle: Column(
        children: <Widget>[
          Text(
            device.id.toString(),
            style: TextStyle(fontSize: 10),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          )
        ],
        crossAxisAlignment: CrossAxisAlignment.start,
      ),
      onTap: deviceTapListener,
      contentPadding: EdgeInsets.fromLTRB(16, 0, 16, 12),
    );
  }
}
