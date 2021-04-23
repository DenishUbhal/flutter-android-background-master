import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';

import 'counter.dart';

class CounterService {

  factory CounterService.instance() => _instance;

  CounterService._internal();

  static final _instance = CounterService._internal();

  final _counter = Counter();

  ValueListenable<int> get count => _counter.count;

  void startCounting() async{

    Stream.periodic(Duration(seconds: 4)).listen((_) async{

      //var permission = await Permission.locationAlways.isGranted;
      var permission = await Permission.locationAlways.isGranted;

      if(!permission){
        var t = await Permission.locationAlways.request();
      }

      _counter.increment();
      _counter.getLocatio();
      print('Counter incremented: ${_counter.count.value}');
      Fluttertoast.showToast(
          msg: "Latitude : ${_counter.lati.value}\n Longitude : ${_counter.long.value}",
          //msg: "${_counter.count.value.toString()}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    });
  }

}
