import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
// Main Components
import 'package:harp_flutter/components/main/AppHeader.dart';
import 'package:harp_flutter/components/main/RefreshDrag.dart';
import 'package:harp_flutter/components/main/BottomBar.dart';
import 'package:harp_flutter/store/index.dart';
import 'dart:async';
import 'package:blue_thermal_printer/blue_thermal_printer.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'testprint.dart';

class PrintPage extends StatefulWidget {
  @override
  State<PrintPage> createState() => _PrintPageState();
}

class _PrintPageState extends State<PrintPage> {
  BlueThermalPrinter bluetooth = BlueThermalPrinter.instance;

  List<BluetoothDevice> _devices = [];
  BluetoothDevice? _device;
  bool _connected = false;
  bool? isConnected = false;
  String? pathImage;
  TestPrint? testPrint;
  @override
  
  Widget build(BuildContext context) {
    
    

  Future<void> initPlatformState() async {
    bool isConnected = await bluetooth.isConnected as bool;
    List<BluetoothDevice> devices = [];
    try {
      devices = await bluetooth.getBondedDevices();
    } on PlatformException {
      // TODO - Error
    }

    bluetooth.onStateChanged().listen((state) {
      switch (state) {
        case BlueThermalPrinter.CONNECTED:
          setState(() {
            _connected = true;
            print("bluetooth device state: connected");
          });
          break;
        case BlueThermalPrinter.DISCONNECTED:
          setState(() {
            _connected = false;
            print("bluetooth device state: disconnected");
          });
          break;
        case BlueThermalPrinter.DISCONNECT_REQUESTED:
          setState(() {
            _connected = false;
            print("bluetooth device state: disconnect requested");
          });
          break;
        case BlueThermalPrinter.STATE_TURNING_OFF:
          setState(() {
            _connected = false;
            print("bluetooth device state: bluetooth turning off");
          });
          break;
        case BlueThermalPrinter.STATE_OFF:
          setState(() {
            _connected = false;
            print("bluetooth device state: bluetooth off");
          });
          break;
        case BlueThermalPrinter.STATE_ON:
          setState(() {
            _connected = false;
            print("bluetooth device state: bluetooth on");
          });
          break;
        case BlueThermalPrinter.STATE_TURNING_ON:
          setState(() {
            _connected = false;
            print("bluetooth device state: bluetooth turning on");
          });
          break;
        case BlueThermalPrinter.ERROR:
          setState(() {
            _connected = false;
            print("bluetooth device state: error");
          });
          break;
        default:
          print(state);
          break;
      }
    });

    if (!mounted) return;
    setState(() {
      _devices = devices;
    });

    if (isConnected) {
      setState(() {
        _connected = true;
      });
    }
  }
  void initState() {
    super.initState();
    initPlatformState();
  }
  
 List<DropdownMenuItem<BluetoothDevice>> _getDeviceItems() {
    List<DropdownMenuItem<BluetoothDevice>> items = [];
    if (_devices.isEmpty) {
      items.add(DropdownMenuItem(
        child: Text('NONE'),
      ));
    } else {
      _devices.forEach((device) {
        items.add(DropdownMenuItem(
          child: Text(device.name.toString()),
          value: device,
        ));
      });
    }
    return items;
  }

  Future show(
    String message, {
    Duration duration: const Duration(seconds: 3),
  }) async {
    await new Future.delayed(new Duration(milliseconds: 100));
    ScaffoldMessenger.of(context).showSnackBar(
      new SnackBar(
        content: new Text(
          message,
          style: new TextStyle(
            color: Colors.white,
          ),
        ),
        duration: duration,
      ),
    );
  }

  void _connect() {
    if (_device == null) {
      show('No device selected.');
    } else {
      bluetooth.isConnected.then((isConnected) {
        if (!isConnected!) {
          bluetooth.connect(_device as BluetoothDevice).catchError((error) {
            setState(() => _connected = false);
          });
          setState(() => _connected = true);
        }
      });
    }
  }

  void _disconnect() {
    bluetooth.disconnect();
    setState(() => _connected = false);
  }

  

    final StoreX storex = Get.put(StoreX()); 
    var vdata ={}; // new Map.from(vdata); <- apabila mengambil vdata untuk memutus object reference
    return Scaffold(
      // ================ body
      body: Container(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              children: <Widget>[
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Device:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Expanded(
                      child: DropdownButton(
                        items: _getDeviceItems(),
                        onChanged: (value) => setState(() => _device = value as BluetoothDevice),
                        value: _device,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.brown),
                      onPressed: () {
                        initPlatformState();
                      },
                      child: Text(
                        'Refresh',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: _connected ? Colors.red : Colors.green),
                      onPressed: _connected ? _disconnect : _connect,
                      child: Text(
                        _connected ? 'Disconnect' : 'Connect',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 10.0, right: 10.0, top: 50),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(primary: Colors.brown),
                    onPressed: () {
                      bluetooth.isConnected.then((isConnected) {
                      print(isConnected);
                      if (isConnected!) {
                        bluetooth.printNewLine();
                        bluetooth.printCustom("HEADER", 3, 1);
                        bluetooth.printNewLine();
                        // bluetooth.printImage(pathImage); //path of your image/logo
                        bluetooth.printNewLine();
                //      bluetooth.printImageBytes(bytes.buffer.asUint8List(bytes.offsetInBytes, bytes.lengthInBytes));
                        bluetooth.printLeftRight("LEFT", "RIGHT", 0);
                        bluetooth.printLeftRight("LEFT", "RIGHT", 1);
                        bluetooth.printLeftRight("LEFT", "RIGHT", 1, format: "%-15s %15s %n");
                        bluetooth.printNewLine();
                        bluetooth.printLeftRight("LEFT", "RIGHT", 2);
                        bluetooth.printLeftRight("LEFT", "RIGHT", 3);
                        bluetooth.printLeftRight("LEFT", "RIGHT", 4);
                        bluetooth.printNewLine();
                        bluetooth.print3Column("Col1", "Col2", "Col3", 1);
                        bluetooth.print3Column("Col1", "Col2", "Col3", 1,
                            format: "%-10s %10s %10s %n");
                        bluetooth.printNewLine();
                        bluetooth.print4Column("Col1", "Col2", "Col3", "Col4", 1);
                        bluetooth.print4Column("Col1", "Col2", "Col3", "Col4", 1,
                            format: "%-8s %7s %7s %7s %n");
                        bluetooth.printNewLine();
                        String testString = " čĆžŽšŠ-H-ščđ";
                        bluetooth.printCustom(testString, 1, 1, charset: "windows-1250");
                        bluetooth.printLeftRight("Številka:", "18000001", 1,
                            charset: "windows-1250");
                        bluetooth.printCustom("Body left", 1, 0);
                        bluetooth.printCustom("Body right", 0, 2);
                        bluetooth.printNewLine();
                        bluetooth.printCustom("Thank You", 2, 1);
                        bluetooth.printNewLine();
                        bluetooth.printQRcode("Insert Your Own Text to Generate", 200, 200, 1);
                        bluetooth.printNewLine();
                        bluetooth.printNewLine();
                        bluetooth.paperCut();
                      }
                    });
                    },
                    child: Text('PRINT TEST',
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
        ),
        
      // drawer
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Get.to(TerdekatPage());
        },
        backgroundColor: Colors.blue.withOpacity(0.5),
        child: Icon(Icons.pin_drop),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomBar1(), // import dari Components BottomBar
    );
  }
}
