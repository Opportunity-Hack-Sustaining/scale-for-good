part of test_scenarios;

typedef TestedFunction = Future<void> Function();

class PeripheralTestOperations {
  final Peripheral peripheral;
  final Logger log;
  final Logger logError;
  StreamSubscription monitoringStreamSubscription;
  final BleManager bleManager;

  PeripheralTestOperations(
      this.bleManager, this.peripheral, this.log, this.logError);

  Future<void> connect() async {
    await _runWithErrorHandling(() async {
      log("Connecting to ${peripheral.name}");
      await peripheral.connect();
      SensorTagTemperatureUuids.peripheral = peripheral;
      log("Connected!");
    });
  }

  Future<void> cancelTransaction() async {
    await _runWithErrorHandling(() async {
      log("Starting operation to cancel...");
      peripheral
          .discoverAllServicesAndCharacteristics(transactionId: "test")
          .catchError((error) {
        BleError bleError = error as BleError;
        return logError("Cancelled operation caught an error: "
            "\nerror code ${bleError.errorCode.value},"
            "\nreason: ${bleError.reason}");
      });
      log("Operation to cancel started: discover all"
          " services and characteristics");

      log("Cancelling operation...");
      await bleManager.cancelTransaction("test");
      log("Operation cancelled!");
    });
  }

  Future<void> getConvertedWeight() async => await _runWithErrorHandling(() async {
    await peripheral.discoverAllServicesAndCharacteristics();
    Service savedService;
    Characteristic savedCharacteristic;
    List<Service> services = await peripheral.services();
    log("PRINTING SERVICES for \n${peripheral.name}");
    services.forEach((service) =>
    (service.uuid.contains(SensorTagTemperatureUuids.weightService))?
        savedService = service: log("Found WRONG service \n${service.uuid}"));

    log("PRINTING CHARACTERISTICS FOR SERVICE \n${savedService.uuid}");


    //Use this if the characteristic value is known
    List<Characteristic> characteristics = await savedService.characteristics();
    characteristics.forEach((characteristic) =>
      (characteristic.uuid.contains(SensorTagTemperatureUuids.weightCharacteristic))?
      savedCharacteristic = characteristic: log("Found WRONG characteristic \n${characteristic.uuid}"));

    log("HELLO THIS IS THE CHARACTERISTIC I WANT \n${savedCharacteristic.uuid}");
    Uint8List readValue1 = (await savedCharacteristic.read());
    log("AND THIS IS SUPPOSED TO BE THE VALUE \n$readValue1");

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
    log("TESTING WEIGHT CONVERSION");
    log("D: $d");
    log("C: $c");
    log("B: $b");
    log("A: $a");
    int total = a + (b*256) + (c*65536) + d;
    log("TOTAL CONVERTED VALUE: $total");
    log("Weight: \n$readValue");

    //turn on when characteristic value is unknown
    /*characteristicFromPeripheral.forEach((characteristic) =>
        log("Found characteristic \n ${characteristic.uuid}")
    );*/

  });


  Future<void> discoveryOld() async => await _runWithErrorHandling(() async {
        await peripheral.discoverAllServicesAndCharacteristics();
        List<Service> services = await peripheral.services();
        log("PRINTING SERVICES for \n${peripheral.name}");
        services.forEach((service) => log("Found service \n${service.uuid}"));
        Service service = services[2];
        log("PRINTING CHARACTERISTICS FOR SERVICE \n${service.uuid}");

        List<Characteristic> characteristics = await service.characteristics();
        characteristics.forEach((characteristic) {
          log("${characteristic.uuid}");
        });

        log("PRINTING CHARACTERISTICS FROM \nPERIPHERAL for the same service");
        List<Characteristic> characteristicFromPeripheral =
            await peripheral.characteristics(service.uuid);
        Uint8List readValue = (await characteristicFromPeripheral[0].read());
        int d = readValue[0];
        int c = readValue[1];
        int b = readValue[2];
        int a = readValue[3];
        log("TESTING WEIGHT CONVERSION");
        log("D: $d");
        log("C: $c");
        log("B: $b");
        log("A: $a");
        int total = a + (b*256) + (c*65536) + d;
        log("TOTAL CONERTED VALUE: $total");
        log("Weight: \n$readValue");
        characteristicFromPeripheral.forEach((characteristic) =>
            log("Found characteristic \n ${characteristic.uuid}")

        );

        //------------ descriptors
        List<Descriptor> descriptors;

        var printDescriptors = () => descriptors.forEach((descriptor) {
              log("Descriptor: ${descriptor.uuid}");
            });

        log("Using IR Temperature service/IR Temperature Data "
            "characteristic for following descriptor tests");
        log("PRINTING DESCRIPTORS FOR PERIPHERAL");

        descriptors = await peripheral.descriptorsForCharacteristic(
            SensorTagTemperatureUuids.weightService,
            SensorTagTemperatureUuids.weightCharacteristic);

        printDescriptors();
        descriptors = null;

        log("PRINTING DESCRIPTORS FOR SERVICE");
        Service chosenService = services.firstWhere((elem) =>
            elem.uuid ==
            SensorTagTemperatureUuids.weightService.toLowerCase());

        descriptors = await chosenService.descriptorsForCharacteristic(
            SensorTagTemperatureUuids.weightCharacteristic);

        printDescriptors();
        descriptors = null;

        List<Characteristic> temperatureCharacteristics =
            await chosenService.characteristics();
        Characteristic chosenCharacteristic = temperatureCharacteristics.first;

        log("PRINTING DESCRIPTORS FOR CHARACTERISTIC");
        descriptors = await chosenCharacteristic.descriptors();

        printDescriptors();
      });


  Future<void> disconnect() async {
    await _runWithErrorHandling(() async {
      log("WAITING 10 SECOND BEFORE DISCONNECTING");
      await Future.delayed(Duration(seconds: 10));
      log("DISCONNECTING...");
      await peripheral.disconnectOrCancelConnection();
      log("Disconnected!");
    });
  }


  Future<void> _runWithErrorHandling(TestedFunction testedFunction) async {
    try {
      await testedFunction();
    } on BleError catch (e) {
      logError("BleError caught: ${e.errorCode.value} ${e.reason}");
    } catch (e) {
      if (e is Error) {
        debugPrintStack(stackTrace: e.stackTrace);
      }
      logError("${e.runtimeType}: $e");
    }
  }
}
