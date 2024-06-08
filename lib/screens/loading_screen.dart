import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../services/location.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocation();
  }

  void getLocation() async {
    try {
      Location l = Location();
      await l.getCurrentLocation();
      if (kDebugMode) {
        print(l.latitude);
      }
      if (kDebugMode) {
        print(l.longitude);
      }
      getData(l.longitude, l.latitude);
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  Future<void> getData(double longitude, double latitude) async {
    String lon = longitude.toString();
    String lat = latitude.toString();
    http.Response response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=e1bc73925ed6dd716191c10142271fb9'));
    if (response.statusCode == 200) {
      String data = response.body;
      var longi=jsonDecode(data)['coord']['lon'];
      if (kDebugMode) {
        print(longi);
      }
    } else {
      if (kDebugMode) {
        print(response.statusCode);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
