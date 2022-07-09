import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/services/weather.dart';
import 'package:clima/services/networking.dart';
import 'package:clima/screens/city_screen.dart';

class LocationScreen extends StatefulWidget {
  LocationScreen({this.decodedWeatherDataLS});
  final decodedWeatherDataLS;

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherModel weathermodel = WeatherModel();

  int temp;
  var city;
  var id;
  var condition;
  String weathericon;
  String message;
  @override
  void initState() {
    super.initState();
    var x = widget.decodedWeatherDataLS;
    updateUI(x);
  }

  void updateUI(var y) {
    setState(() {
      if (y == null) {
        temp = 0;
        weathericon = 'error';
        message = 'There is some error in input';
        city = '';
        return;
      } else {
        double localtemp = y['main']['temp'];
        city = y['name'];
        id = y['id'];
        condition = y['weather'][0]['id'];

        temp = localtemp.toInt();
        weathericon = weathermodel.getWeatherIcon(condition);
        message = weathermodel.getMessage(temp);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ElevatedButton(
                    onPressed: () async {
                      WeatherData weatherData = WeatherData();
                      var z = await weatherData.getData();

                      updateUI(z);
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      var city = await Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CityScreen()),
                      );
                      if (city != null) {
                        WeatherData weatherData = WeatherData();
                        var weathercity = await weatherData.getCityData(city);
                        updateUI(weathercity);
                      }
                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      "${temp.toString()}°C",
                      style: kTempTextStyle,
                    ),
                    Text(
                      weathericon,
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  " $message in $city!",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
