import 'package:flutter/widgets.dart';
import 'package:scale_for_good/devices_list/devices_bloc.dart';
import 'package:scale_for_good/repository/device_repository.dart';
import 'package:flutter_ble_lib/flutter_ble_lib.dart';

class DevicesBlocProvider extends InheritedWidget {
  final DevicesBloc devicesBloc;

  DevicesBlocProvider({
    Key key,
    DevicesBloc devicesBloc,
    Widget child,
  })  : devicesBloc =
            devicesBloc ?? DevicesBloc(DeviceRepository(), BleManager()),
        super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static DevicesBloc of(BuildContext context) => context
      .dependOnInheritedWidgetOfExactType<DevicesBlocProvider>()
      .devicesBloc;
}
