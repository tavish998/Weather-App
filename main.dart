import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MaterialApp(
    home: Weather(),
  ));
}



class Weather extends StatefulWidget {
  @override
  _WeatherState createState() => _WeatherState();
}

class _WeatherState extends State<Weather> {

  TextEditingController inputcontroller = new TextEditingController();
  double temp = 34;
  double feelsLike = 36;
  String env = "smoke";
  double windSpeed = 12.8;
  String city;

  void getWeatherInfo() async {
    city = inputcontroller.text;
    var response = await http.get(Uri.parse(
      "http://api.openweathermap.org/data/2.5/weather?q=${city}&appid=c66a46ae66f5d01f9ed93efacfe12a0f"));

    Map details = jsonDecode(response.body);

    setState(() {
      temp = (details['main']['temp'] - 273.15).roundToDouble();
      feelsLike = (details['main']['feels_like'] - 273.15).roundToDouble();
      windSpeed = details['wind']['speed'];
      env = details['weather'][0]['main'];
    });

    
  
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Mausam"),
        backgroundColor: Colors.grey[900],
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 30),
            Text('Enter City', 
            style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold)),
            SizedBox(height: 20),
            TextField(
              controller: inputcontroller,
              decoration: InputDecoration(
                hintText: "City Name",
                border: OutlineInputBorder())
            ),
            SizedBox(height: 10),
            ElevatedButton(onPressed: getWeatherInfo,
             child: Text("Get Weather Info")),
            Divider(height: 30, color: Colors.grey[600],),

            Text("Temprature"),
            SizedBox(height: 3),
            Text("$temp deg Celcius",style: TextStyle(fontSize: 25)),
            SizedBox(height: 20),

            Text("Feels Like"),
            SizedBox(height: 3),
            Text("$feelsLike deg Celcius",style: TextStyle(fontSize: 25)),
            SizedBox(height: 20),

            Text("Environment"),
            SizedBox(height: 3),
            Text(env,style: TextStyle(fontSize: 25)),
            SizedBox(height: 20),

            Text("Wind Speed"),
            SizedBox(height: 3),
            Text("$windSpeed",style: TextStyle(fontSize: 25)),

            ],

        
        ),
      ),

    );
  }
}