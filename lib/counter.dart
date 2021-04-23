import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';

//import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Counter {
  Counter() {
    _readCount().then((count) => _count.value = count);
  }

  ValueNotifier<int> _count = ValueNotifier(0);

  ValueListenable<int> get count => _count;

  ValueNotifier<double> _lati = ValueNotifier(0);

  ValueListenable<double> get lati => _lati;

  ValueNotifier<double> _long = ValueNotifier(0);

  ValueListenable<double> get long => _long;

  void increment() {
    _count.value++;
    _writeCount(_count.value);
  }

  void getLocatio() async {
    try {
      await Geolocator.getCurrentPosition().then((value) {
        _lati.value=value.latitude;
        _long.value=value.longitude;
      });
    } on PlatformException catch (err) {}
    /*try {
      final LocationData _locationResult = await location.getLocation();
      //_location = _locationResult;
      _lati.value=_locationResult.latitude;
      _long.value=_locationResult.longitude;
    } on PlatformException catch (err) {
    }*/
  }

  Future<int> _readCount() async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.getInt('Counter.count') ?? 0;
  }

  Future<void> _writeCount(int count) async {
    var prefs = await SharedPreferences.getInstance();
    return prefs.setInt('Counter.count', count);
  }
}
