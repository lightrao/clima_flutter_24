import 'package:clima_flutter_24/env_var.dart';
import 'package:clima_flutter_24/screens/location_screen.dart';
import 'package:clima_flutter_24/services/networking.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../services/location.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    getLocationData();
    super.initState();
  }

  Future<void> getLocationData() async {
    Location location = Location();
    await location.getCurrentLocation();

    var url = Uri.https(
      'api.openweathermap.org',
      '/data/2.5/weather',
      {
        'lat': location.latitude.toString(),
        'lon': location.longitude.toString(),
        'appid': API_KEY,
        'units': 'metric',
      },
    );

    NetWorkHelper netWorkHelper = NetWorkHelper(url: url);
    var weatherData = await netWorkHelper.getData();

    Navigator.push(
      context,
      MaterialPageRoute(builder: (ctx) {
        return LocationScreen(
          locationWeather: weatherData,
        );
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }
}
