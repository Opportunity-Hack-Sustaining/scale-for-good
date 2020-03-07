
import 'package:flutter/material.dart';
import 'package:scale_for_good/device_details/device_details_bloc.dart';
import 'package:scale_for_good/device_details/view/button_view.dart';
import 'package:scale_for_good/device_details/view/logs_container_view.dart';

class ManualTestView extends StatelessWidget {
  final DeviceDetailsBloc _deviceDetailsBloc;

  ManualTestView(this._deviceDetailsBloc);

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(children: <Widget>[
        Expanded(
          flex: 3,
          child: SingleChildScrollView(
            child: _createControlPanel(),
          ),
        ),
        Expanded(
          flex: 7,
          child: LogsContainerView(_deviceDetailsBloc.logs),
        )
      ]),
    );
  }

  void _connect() {
    _deviceDetailsBloc.connect();
  }

  void _disconnect() {
    _deviceDetailsBloc.disconnectManual();
  }

  void _readRssi() {
    _deviceDetailsBloc.readRssi();
  }

  void _discovery() {
    _deviceDetailsBloc.discovery();
  }

  void _fetchConnectedDevices() {
    _deviceDetailsBloc.fetchConnectedDevices();
  }

  void _fetchKnownDevices() {
    _deviceDetailsBloc.fetchKnownDevices();
  }

  void _readCharacteristicForPeripheral() {
    _deviceDetailsBloc.readCharacteristicForPeripheral();
  }

  void _readCharacteristicForService() {
    _deviceDetailsBloc.readCharacteristicForService();
  }

  void _readCharacteristicDirectly() {
    _deviceDetailsBloc.readCharacteristicDirectly();
  }



  void _disableBluetooth() {
    _deviceDetailsBloc.disableBluetooth();
  }

  void _enableBluetooth() {
    _deviceDetailsBloc.enableBluetooth();
  }

  void _fetchBluetoothState() {
    _deviceDetailsBloc.fetchBluetoothState();
  }

  Column _createControlPanel() {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: Row(
            children: <Widget>[
              ButtonView("Connect", action: _connect),
              ButtonView("Disconnect", action: _disconnect),
              ButtonView("Connected devices", action: _fetchConnectedDevices),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: Row(
            children: <Widget>[
              ButtonView("Read Rssi", action: _readRssi),
              ButtonView("Request MTU"),
              ButtonView("Known devices", action: _fetchKnownDevices),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: Row(
            children: <Widget>[
              ButtonView("Cmon baby work", action: _discovery),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: Row(
            children: <Widget>[
              ButtonView("Read weight via peripheral",
                  action: _readCharacteristicForPeripheral),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: Row(
            children: <Widget>[
              ButtonView("Read weight via service",
                  action: _readCharacteristicForService),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: Row(
            children: <Widget>[
              ButtonView("Read weight directly",
                  action: _readCharacteristicDirectly),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: Row(
            children: <Widget>[
              ButtonView("Read Weight", action: _readCharacteristicForPeripheral),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: Row(
            children: <Widget>[
              ButtonView("Enable bluetooth", action: _enableBluetooth),
              ButtonView("Disable bluetooth", action: _disableBluetooth),
              ButtonView("Fetch BT State", action: _fetchBluetoothState),
            ],
          ),
        ),
      ],
    );
  }
}
