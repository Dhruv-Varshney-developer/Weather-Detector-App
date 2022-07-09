import 'package:flutter/material.dart';

import 'package:clima/services/networking.dart';
import 'package:clima/screens/location_screen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  void getLocation() async {
    WeatherData weatherData = WeatherData();
    var decodedWeatherData = await weatherData.getData();

    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => LocationScreen(
                decodedWeatherDataLS: decodedWeatherData,
              )),
    );
  }

  void initState() {
    super.initState();

    getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitRipple(
          color: Colors.white,
          size: 100.0,
        ),
      ),
    );
  }
}
