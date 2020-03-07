import 'package:flutter/cupertino.dart';
import 'package:flutter_ble_lib/flutter_ble_lib.dart';
import 'package:flutter_ble_lib/internal/_managers_for_classes.dart';

abstract class SensorTagTemperatureUuids {
  static String test = "wef";
  static Map<String, dynamic> json = new Map();
  static ManagerForPeripheral manager;
  static Peripheral peripheral = new Peripheral.fromJson(json, manager);
  static String weightService =
      "27cf08c1-076a-41af-becd-02ed6f6109b9";
  static const String weightCharacteristic =
      "fd758b93-0bfa-4c52-8af0-85845a74a606";


}
