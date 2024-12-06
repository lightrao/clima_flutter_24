import 'dart:convert';

import 'package:clima_flutter_24/env_var.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../services/location.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    getLocation();
    super.initState();
  }

  Future<void> getLocation() async {
    Location location = Location();
    await location.getCurrentLocation();
    print(location.latitude);
    print(location.longitude);
  }

  void getData() async {
    var url = Uri.https(
      'api.openweathermap.org',
      '/data/2.5/weather',
      {
        'lat': '30.489772',
        'lon': '-99.771335',
        'appid': API_KEY,
      },
    );

    http.Response response = await http.get(url);
    if (response.statusCode == 200) {
      String data = response.body;
      var decodedData = jsonDecode(data);

      var temperature = decodedData['main']['temp'];
      var condition = decodedData['weather'][0]['id'];
      var cityName = decodedData['name'];
    } else {
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            getData();
          },
          child: Text('Get Location'),
        ),
      ),
    );
  }
}
