import 'package:fimber/fimber.dart';
import 'package:flutter/material.dart';
import 'package:scale_for_good/devices_list/devices_bloc_provider.dart';
import 'package:scale_for_good/devices_list/devices_list_view.dart';
import 'package:scale_for_good/device_details/device_detail_view.dart';
import 'package:scale_for_good/device_details/devices_details_bloc_provider.dart';


//final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

class ConnectionsPage extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FlutterBleLib example',

      /*theme: new ThemeData(
        primaryColor: new Color(0xFF0A3D91),
        accentColor: new Color(0xFFCC0000),
      ),*/

      initialRoute: "/",
      routes: <String, WidgetBuilder>{
        "/": (context) => DevicesBlocProvider(child: DevicesListScreen()),
        "/details": (context) => DeviceDetailsBlocProvider(child: DeviceDetailsView()),
      },
      //navigatorObservers: [routeObserver],
    );
  }
}
