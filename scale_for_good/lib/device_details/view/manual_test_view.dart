
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


  void _discovery() {
    _deviceDetailsBloc.discovery();
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
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: Row(
            children: <Widget>[
              ButtonView("Test Device", action: _discovery),
            ],
          ),
        ),
      ],
    );
  }
}
