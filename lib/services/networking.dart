import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:clima/services/location.dart';

class WeatherData {
  Future<dynamic> getData() async {
    Location location = Location();
    await location.getCurrentLocation();
    var latitude = location.latitude;
    var longitude = location.longitude;

    http.Response response = await http.get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=e261888443b9c97a40c77b7d12e5f953&units=metric"));
    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
      //temperature = jsonDecode(data)['main']['temp'];
      //city = jsonDecode(data)['name'];
      //id = jsonDecode(data)['id'];
      //condition = jsonDecode(data)['weather'][0]['id'];
    } else
      print(response.statusCode);
  }

  Future<dynamic> getCityData(String city) async {
    http.Response response = await http.get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=$city&appid=e261888443b9c97a40c77b7d12e5f953&units=metric"));
    if (response.statusCode == 200) {
      String data = response.body;
      return jsonDecode(data);
    } else
      print(response.statusCode);
  }
}
